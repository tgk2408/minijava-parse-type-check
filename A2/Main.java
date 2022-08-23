import syntaxtree.*;
import visitor.*;
import java.util.*;

public class Main {
   public static void main(String [] args) {
       try {
         Node root = new MiniJavaParser(System.in).Goal();
         GJDepthFirst df= new GJDepthFirst();
         HashMap<String,SymbolTable> TotalTable= new HashMap<String, SymbolTable>();
         root.accept(df, TotalTable);
         // Iterator it = TotalTable.entrySet().iterator();
         // while(it.hasNext()){
         //    Map.Entry mapElement = (Map.Entry) it.next();
         //    String key = (String) mapElement.getKey();
         //    SymbolTable value= (SymbolTable)mapElement.getValue();
         //    System.out.println(key);
         //    value.print_SymbolTable();
         // }
         System.out.println("Program type checked successfully");
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 

