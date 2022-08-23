package visitor;
import java.util.*;

public class SymbolTable {
    String class_name;
    HashMap<String,String> variables;
    HashMap<String,MethodTable> method_map;
    String parent_class;

    SymbolTable() {
        class_name = null;
        variables = new HashMap<String, String>();
        method_map = new HashMap<String, MethodTable>();
        parent_class = null;
    }

    SymbolTable(String name) {
        class_name = name;
        variables = new HashMap<String, String>();
        method_map = new HashMap<String, MethodTable>();
        parent_class = null;
    }

    SymbolTable(String parent, String name) {
        parent_class = parent;
        class_name = name;
        variables = new HashMap<String, String>();
        method_map = new HashMap<String, MethodTable>();
    }

    public void print_SymbolTable() {
        System.out.println(parent_class + " " + class_name);
        System.out.println(variables);
        Iterator it = method_map.entrySet().iterator();
        while(it.hasNext()){
           Map.Entry mapElement = (Map.Entry) it.next();
           String key = (String) mapElement.getKey();
           MethodTable value= (MethodTable)mapElement.getValue();
           System.out.println(key);
           value.print_MethodTable();
        }
        return;
    }
};

class MethodTable {
    String access_mode;
    String type;
    String method_name;
    LinkedList<Pair<String, String>> args;
    HashMap<String, String> variables;
    String parent_name;
    
    MethodTable() {
        args = new LinkedList<Pair<String, String>>();
        variables = new HashMap<String, String>();
        parent_name = null;
    }
    MethodTable(String parent, String name) {
        args = new LinkedList<Pair<String, String>>();
        variables = new HashMap<String, String>();
        parent_name = parent;
        method_name = name;
    }

    public void addArgs(String id, String type) {
        Pair<String, String> temp = new Pair<String, String>(id, type);
        for (Pair<String, String> i : args) {
            if (i.identifier == id) {
                System.out.println("Type error");
                System.exit(0);
            }
        }
        this.args.add(temp);
        return;
    }

    public void print_MethodTable() {
        System.out.println(access_mode + " " + type + " "+ method_name + " "+ parent_name);
        for (Pair<String, String> i : args) {
            System.out.println(i.identifier + " " + i.type);
        }
        System.out.println(variables);
        return;
    }
};

class Pair<T1, T2> {
    T1 identifier;
    T2 type;

    Pair (T1 id, T2 type) {
        this.identifier = id;
        this.type = type;
    }
};