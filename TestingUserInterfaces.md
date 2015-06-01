# Testing user interfaces #

Unit testing code is pretty easy. That doesn't mean that I always do it, and it doesn't mean that it's easy to write good tests, but in general it's easy -- just run the code and make sure that the result was the expected. It gets trickier when there are side effects that need to be tested, and trickier when the side effects are asynchronous, and even trickier when the thing you're testing is hard or impossible to isolate. Combine these and you have user interfaces.

In Flex most things you do with views are asychronous, and almost everything has side effects. Views are also hard to isolate because they need to be part of a Flex ecosystem to function properly.

Nevertheless, there are a few strategies for testing user interfaces in Flex.

## The default strategy ##
The first is to try to simulate user interaction by manually dispatching the events that "real" interaction would, and test the results. This strategy quickly runs into problems because of the asychronous nature of Flex views, and the ratio of tests to lines of testing code gets really low because of all the crud needed just to handle the interaction. Also, you can't test the views in isolation (but that is a problem with Flex).

## The sequence-based strategy ##
The second strategy builds on the first, but tries to avoid the complexity by creating a framework that handles it for you. This is how the "Sequences" feature of the testing framework [Fluint](http://code.google.com/p/fluint/) works. It lets you specify the steps to perform more or less declaratively and handles the asynchronous aspects for you. Below is an example (taken from the [Sequences page from the Fluint site](http://code.google.com/p/fluint/wiki/Sequences)):

```
var sequence : SequenceRunner = new SequenceRunner(this);

sequence.addStep(new SequenceSetter(form.usernameTI, {text: passThroughData.username}));
sequence.addStep(new SequenceWaiter(form.usernameTI, FlexEvent.VALUE_COMMIT, 100));

sequence.addStep(new SequenceSetter(form.passwordTI, {text: passThroughData.password}));
sequence.addStep(new SequenceWaiter(form.passwordTI, FlexEvent.VALUE_COMMIT, 100));

sequence.addStep(new SequenceEventDispatcher(form.loginBtn, new MouseEvent("click", true, false)));
sequence.addStep(new SequenceWaiter(form, "loginRequested", 100));

sequence.addAssertHandler(handleLoginEvent, passThroughData);

sequence.run();
```

This is definitely a workable solution, but still the ratio of tests to lines of testing code is low (all the code above does is set the text of two input fields and click a button) and the views are still not tested in isolation.

## The separation strategy ##
The third strategy is to skip testing the views altogether. It may sound absurd, but if you have read the PresentationModel page you probably have an idea of what I mean.

Think about why you want to test your user interfaces in the first place, you want test the view logic, right? You're not so interested in testing the position, size and colour of your controls, but what information they display and what happens when the user interacts with them.

The easiest way to test view logic is to extract it from the view into a presenter object and test that. [Paul Williams](http://weblogs.macromedia.com/paulw/) has written an excellent series on [how to test user interfaces](http://weblogs.macromedia.com/paulw/archives/2008/03/unit_testing_us.html) (and if you're bored by this article just read his instead, it's much better), where he explores a number of presentational patterns and how to apply testing to them. In my reading of these I have come to the conclusion that the best fit for Flex is the presentational pattern PresentationModel, both in terms of how easy it is to work with (mostly down how terse binding expressions are when the view is implemented in MXML) and how simple it is to test in comparison to the others (because it has no dependency on the view, and as such it's easy to test in isolation).

If you extract the logic from the view the code above could be simplified into something like this:

```
presentationModel.username = passThroughData.username;
presentationModel.password = passThroughData.password;
presentationModel.addEventListener("loginRequested", asyncHandler(handleLoginEvent, 100, passThroughData));
presentationModel.login();
```

or this, depending on whether you let the view or the presentation model handle the `username` and `password` values:

```
presentationModel.addEventListener("loginRequested", asyncHandler(handleLoginEvent, 100, passThroughData));
presentationModel.login(passThroughData.username, passThroughData.password);
```

Most of the simplification comes from the fact that you don't have to take Flex' asychronous nature into consideration, that removes a lot of the complexity.

By extracting your view logic into its own class it becomes so much easier to test it. Testing in isolation is as easy as testing any other piece of code in you application (meaning that you can easily [make it harder by writing badly designed code](http://googletesting.blogspot.com/2008/07/how-to-write-3v1l-untestable-code.html)) and you become free of the asychronous nature of Flex views. Writing a unit test for a PresentationModel is more or less exactly as writing unit tests for any other class.

To see two concrete examples of tests for presentation models, look at [TestMainModel.as](http://code.google.com/p/mate-examples/source/browse/trunk/examples/documentbased/src/example/view/test/TestMainModel.as) and [TestDocumentModel.as](http://code.google.com/p/mate-examples/source/browse/trunk/examples/documentbased/src/example/view/test/TestDocumentModel.as) from the document-based example.

### Is that the whole story, though? ###
But wait a minute, I hear you say. Are we really testing everything? How can we be sure that the view is correct if the presentation model is correct? Shouldn't we be testing that the view actually displays the right data and that the right methods are called when buttons are clicked?

Of course you could, but it doesn't pay. I belive that you have to be pragmatic about what you test. If the potential benefits are small and/or the amount of code you need to write is large, then it probably doesn't pay. Things like

```
<Label text="{presentationModel.myFancyLabel}"/>
```

or

```
<Button click="presentationModel.doTheThing()"/>
```

fall into the category of things that aren't worth testing, along with, for example, simple getters and setters. It's unlikely that you would catch any bugs with a test written for the two examples above.

If you look at the testing code I've written for the document-based example I've actually written a few tests for things that are too simple to merit testing. For example I have a test for this method (from DocumentModel)

```
public function undo( ) : void {
	dispatcher.dispatchEvent(new UndoEvent(UndoEvent.UNDO));
}
```

which is clearly overkill

```
[Test]
public function undoDispatched( ) : void {
	dispatcher.addEventListener(UndoEvent.UNDO, asyncHandler(onUndo, 100));
		
	model.undo();
}
	
private function onUndo( event : UndoEvent, data : Object ) : void { }
```

While I don't recommend that you write tests like these, it doesn't hurt either. I chose to write the one above (and a few other like it) to illustrate how you could do it, in case you wanted to. But just to be clear: if the complexity of the method increased, if it changed, for example, to dispatch events only in certain circumstances then I would definitely write a test for it.