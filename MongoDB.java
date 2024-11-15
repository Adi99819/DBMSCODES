package MongoDB;

import java.util.Scanner;

import com.mongodb.*;


public class MongoDB {
	public static void Stringdata(String data,DBCollection table) {
		DBCursor cursor=table.find();
		if(cursor.hasNext()) {
		while(cursor.hasNext()) {
			String Strdata=(String)cursor.next().get(data);
			if(data=="Name") {
			System.out.print(data+" :"+Strdata+"\t\t\t");
			}
			else {
				System.out.print(data+":"+Strdata+"\t");
			}
		}
		System.out.println(" ");
	}
		else {
			System.out.print("");
		}
	}
	
	public static void Intdata(String data,DBCollection table) {
		DBCursor cursor=table.find();
		if(cursor.hasNext()) {
		while(cursor.hasNext()) {
			 int dataint=(Integer)cursor.next().get(data);
			System.out.print(data+" :"+dataint+"\t\t\t\t");
		}
		System.out.println(" ");
	}
		else {
			System.out.print("");
		}
	}
	
	public static void main(String[] args) throws Exception {
		MongoClient mongo=new MongoClient("localhost",27017); 
		System.out.println("Connected to the database successfully");
		
		Scanner sc=new Scanner(System.in);
		int n,age=0;
		String name=" ",mobileno=" ",ans=" ",ans1=" ";
		
		do {
		DB db=mongo.getDB("Info");
		DBCollection table=db.createCollection("Personal",null);
		System.out.println("Enter the no of record you want to insert:");
		n=sc.nextInt();
		for(int i=1;i<=n;i++) {
			BasicDBObject info= new BasicDBObject(i);
			System.out.println("Enter Data"+(i));
			System.out.print("Enter name:");
			name=sc.next();
			info.put("Name",name);
			System.out.print("Enter age:");
			age=sc.nextInt();
			info.put("Age",age);
			System.out.print("Enter Mobile Number:");
			mobileno=sc.next();
			info.put("Mobile Number",mobileno);
			table.insert(info);
		}
		System.out.println("Insert Operation");
		Stringdata("Name", table);
		Stringdata("Mobile Number", table);
		Intdata("Age", table);
		
		System.out.print("Enter the no of record you want to delete:");
		n=sc.nextInt();
		for(int i=1;i<=n;i++) {
			BasicDBObject info= new BasicDBObject(i);
			System.out.println("Enter Data"+(i));
			System.out.print("Enter name:");
			name=sc.next();
			info.put("Name",name);
			table.remove(info);
		}

		System.out.println("Delete Operation");
		Stringdata("Name", table);
		Stringdata("Mobile Number", table);
		Intdata("Age", table);
		System.out.println("Do yo want to drop database: ");
		ans=sc.next();
		if(ans.equals("y")||ans.equals("Y")){
				db.dropDatabase();
				System.out.println("Database Droped ");
		}
		System.out.println("Do you want to continue:");
		ans1=sc.next();
		}while(ans1.equals("y")||ans1.equals("Y"));
	}

}