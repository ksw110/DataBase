> DB멘토링 : 김광진 ... router128@hanmail.net

● 객체지향프로그래밍(OOP, Object-Oriented Programming) : JAVA

   객체란?

  . 세상에 존재하는 것(유무형)
  . 사람/동물/사물/공간/장소/노래/느낌/감정 등 개념적 정의

  (1) 고유한 속성 
  (2) 타인도 알 수 있는 것 
  (3) 사전에 등록된 단어 

  A : "우리 오늘 점심 때 라면 먹을래?"
  B : "응, 그래 좋아~!"

         라면 --> 객체(o)

"오뚜기진라면" --> 인스턴스(o) : 객체가 구체화된 실체 
---------------------------------------------------------------------
* 객체의 고유한 속성을 자바 언어에서 어떻게 표현하지?

> Primitive Type(초기/기초/기본 타입)

정수형(4)
. byte    ... 8 bit : 2^8=256(-128~-1, 0~127)
. short   ...16 bit
. int     ...32 bit
. long    ...64 bit
실수형(2)
. float   ...32 bit
. double  ...64 bit
문자형(1)
. char    ...16 bit 유니코드
불린형(1)
. boolean ... 1 bit (True/False)

* 비트(bit, binary digit) : 컴퓨터에서 정보를 표시하기 위한 최소 단위(0,1)
---------------------------------------------------------------------
> 속성 + 기능까지 포함된 객체는 어떻게 다루지? 클래스

(1) 사용자 정의 클래스(user-defined class) : Student 
(2) 내장 클래스(built-in class) : ArrayList / String / Integer / Double / Random / Date / Calendar etc

학생 : 이름/나이/학과  +  출석하다()/공부하다()/시험보다()
      --------------     ------------------------------
          (속성)                   (기능)

public class Student {                                 // 클래스 이름

   private String name;                                // 속성:멤버필드:Property
   private int age;

   
   public Student()                                    // 생성자 1
   {
   
   }
   
   public Student(String name, int age)                // 생성자 2
   {
      this.name = name;
      this.age  = age;
   }
   
   public void setName(String name) {                  // 기능:메소드:멤버함수:Operation
         this.name = name;  
   }
      
   public String getName() {
         return this.name;
   }

   public void setAge(int age) {
         this.age = age;
   }
      
   public int getAge() {
         return this.age;
   }
}          

(0) 객체──┐
(1) 고유 속성 --> Primitive Type (기초타입 8가지)
(2) 속성+기능 --> Reference Type (클래스/추상클래스/인터페이스)

---------------------------------------------------------------------
> 추상클래스(Abstract Class)

   (type)       (subtype)
. 구기종목 : 축구/야구/농구/배구/탁구
. 가전제품 : TV/냉장고/세탁기/전자렌지
. 모양     : 세모/네모/동그라미/마름모/별모양
. 색깔     : 빨강/노랑/파랑/초록/보라

class C extends A   (o)
class C extends A, B(x) // 자바에서는 중복상속 금지
---------------------------------------------------------------------
>인터페이스(interface) : 객체들 간에 자주 발생하는 동작이나 상태를 미리 정의해 놓은 것.

 face <--> face

     .talk()
     .fight()

public interface Human {

   public void talk();
   public void fight();

}     

public class Boy implements Human {

   @Override // 재정의
   public void talk()
   {
      System.out.println("Boy is talking...");
   }

   @Override
   public void fight()
   {
      System.out.println("Boy is fighting..");
   }
}

public void talk()  // 선언부(head)
{
   ....             // 구현부(body)
}

public interface ITV {

   public void on();
   public void off();
   public void switchChannel(int channel);

}

Tom Crusso : "There is no new thing under the sun." (1923)


Student.java  --> Student.class --> JVM(Java Virtual Machine) --> Java Runtime Data Area 


int a = 10;
Student s1 = new Student();


[Stack Area] .......................[Heap Area]

  a  = 10                           new Student()  : ox392852391548934fed
  s1 = ox392852391548934fed

---------------------------------------------------------------------

Student s1 = new Student();   (o)
Human   h1 = new Human();     (x)
Boy     h1 = new Boy();       (o)
Human   h1 = new Boy();       (o)

ex) List list = new ArrayList();

Student s1 = new Student("Tomson", 28);
Student s2 = new Student("Jack",   25);
Student s3 = new Student("Bill",   24);
Student s4 = new Student("John",   26);
Student s5 = new Student("Steve",  28);

ArrayList<Student> list = new ArrayList<Student>();

list.add(s1);
list.add(s2);
list.add(s3);
list.add(s4);
list.add(s5);

list = {s1, s2, s3, s4, s5}

for (int i = 0; i < list.size(); i++) {
   Student s = list.get(i);
   System.out.println(s.getName());
}

for (Student s : list)
{
   System.out.println(s.getName());
}

* ArrayList 사용 시 주의사항 3가지 

(i) ArrayList<T> list = new ArrayList<T>();   // 타입<T>가 생략된 경우, Object가 기본타입으로 세팅됨.

ArrayList list = new ArrayList();
list.add("a");                                // "a"가 들어갈 때, String이 아니라 Object로 들어감.
String s = (String) list.get(0);              // 형변환이 필요함.

ArrayList<String> list = new ArrayList<String>();
list.add("b");                                // "b"가 들어갈 때, String으로 들어감.
String s = list.get(0);                       // 형변환이 필요없음.

(ii) ArrayList<String> list = new ArrayList<>(); // 인정됨? 됨. 왜죠? 타입추론.

(iii) ArrayList<int> list = new ArrayList<int>(); // 타입에 int같은 Primitive Type은 쓸 수 없음.

ArrayList<int> list = new ArrayList<int>();           (x)
ArrayList<Integer> list = new ArrayList<Integer>();   (o)
list.add(new Integer(10));                        // boxing
list.add(10);                                     // autoboxing

int...Integer 

int a = 10;
Integer num1 = new Integer(a);    // boxing 
int     num2 = num1.intValue();   // unboxing
Integer num3 = a;                 // autoboxing
int     num4 = num3;              // autounboxing

[Wrapper Class] : Primitive Type --> Reference Type으로 바꿔주는 클래스
----------------------------------------------------------------------
         기초타입(8) ... 참조형 클래스
            byte    ...  Byte
            short   ...  Short
            int     ...  Integer
            long    ...  Long
            float   ...  Float
            double  ...  Double
            char    ...  Character
            boolean ...  Boolean 
-----------------------------------------------------------------------

* 근데, 인스턴스 개수가 엄청 많아지면 어떡할래? 데이터베이스!


회원관리 = {회원1, 회원2, 회원3, 회원4, 회원5, ... } <-- 두 개 이상의 인스턴스: 엔터티(Entity)

회원관리         MEMBER_INFO/ MEMBERS/ T_MEMBER/ TB_MEMBER/ TBL_MEMBER
---------------------------------------------------------------------
회원 아이디      MB_ID VARCHAR2(20) NOT NULL
회원 비밀번호    MB_PW VARCHAR2(20) NOT NULL
회원 이름        MB_NAME VARCHAR2(40) NOT NULL 
회원 이메일      MB_EMAIL VARCHAR(50) NOT NULL
---------------------------------------------------------------------

CREATE TABLE TB_MEMBER(
   MB_ID VARCHAR2(20) NOT NULL,
   MB_PW VARCHAR2(20) NOT NULL,
   MB_NAME VARCHAR2(40) NOT NULL,
   MB_EMAIL VARCHAR(50) NOT NULL,
   CONSTRAINT PK_MEMBER PRIMARY KEY(MB_ID)
);

CREATE TABLE T2 (
   ....
   ....
   ....
);

쌤! 제가 타이핑을 해서 테이블을 하나씩 만들고 있습니다.
손가락이 너무 아픕니다. ㅠ.ㅠ
좀 더 편한 방법이 업떠요? 이떠요! 모죠? DB설계툴!!!(???!!!)

(1) https://www.erwin.com      (전세계 1위) <--'네카라쿠배당토직야'

(2) https://www.erdcloud.com 

(3) https://www.aquerytool.com (국산허접, but....)










