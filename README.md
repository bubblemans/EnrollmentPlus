# DeanzaClassRegister
An app to help De Anza students schedule and even register classes.
## Code Style
1. Variable declaration
   - Use meaningful words, instead of x, y, z.
   - Do not use underline.
   - Use all uppercase for constant.(ex: CONSTANT)
   - Without using space, use uppercase to separate words, but the first word start with lowercase.(ex: countDownTimer)
   - Type complete words, instead of shorten words.(ex: userLogInPassword)
   
2. Comment style
   - File's comment
   ```swift
   /**
      File's name
      This file is to ...
           
      @author Alvin Lin
      @version 1.0 28/3/18
   */  
   ```
   - Function's comment
   ```swift
   /**
      Simple function purpose or definition.
      
      @param parameter's name [type] [simple definition]
      @return parameter's name [type] [simple additional notes]
   */  
   
   ex
   /**
      Function swap two different nodes.
      @param nodeA [int] [the order of first node]
      @param nodeB [int] [the order of second node]
      @return [bool] [true if success, false if fail]
   */
   ```
   - if else comment
   ```swift
   if count >= 20  {
   // Check if the user play this game over 20 times.
   }
   else if count >= 10 {
   // Check if the user play this game between 10 times and 20 times.
   }
   else {
   // Check if the user play this game less than 10 times.
   }
   ```
   - Variable
   ```swift
   var name = "Alvin" // the user's name
   ```
3. One tab is 4 spaces.
4. if-else statement
   - A space after if or else, and a space before open curly bracket.
   - Do not put else after close curly bracket.
   ```swift
   if commit == true {
   ...
   }
   else {
   ...
   }
   ```




