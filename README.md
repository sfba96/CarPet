# CarPet

CarPet is a speech radio-controlled car. It uses the natural language from the person talking to it and reacts depending on the command that is being said.
The car can understand more than english. However, I played with the ambiguity of the language in the code. Basically, the car can understand only english and some 
really different words from spanish. Nonetheless, I used the recognition patterns that I saw on the speech API and use them to fool the code. For example, if anyone says allez
the car will still understand but only because it interprets it as ally and that word is built in the code.

It has been built combining js, processing and arduino.

JS uses a speech recognition library that is then sent to processign, from processing it is sent to arduino in order to translate the words into readable commands.



 
