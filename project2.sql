SPOOL C:\BD2\Project2.txt
SELECT to_char(sysdate, 'DD Month YYYY Day HH:MI:SS') FROM dual;

-- Question 1

CREATE OR REPLACE FUNCTION question1 (num1 IN NUMBER, num2 IN NUMBER)
	RETURN NUMBER AS
		product NUMBER;
	BEGIN
		product := num1 * num2;
	RETURN product;
END;
/

SELECT question1(5,5), question1(15,5), question1(7,11) FROM dual;



-- Question 2

SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE question2 (num1 IN NUMBER, num2 IN NUMBER) AS
	product NUMBER;
	BEGIN
		product := question1(num1,num2);
		DBMS_OUTPUT.PUT_LINE('For a rectangle of size ' || num1 || ' by ' || num2 || ', the area is ' || product ||'.');
	END;
/

EXEC question2(2,3)
EXEC question2(7,9)
EXEC question2(4,11)




-- Question 3

CREATE OR REPLACE PROCEDURE question3 (num1 IN NUMBER, num2 IN NUMBER) AS
	product NUMBER;
	BEGIN
		IF (num1 = num2) THEN
			DBMS_OUTPUT.PUT_LINE('Square');
		ELSE
			product := question1(num1,num2);
			DBMS_OUTPUT.PUT_LINE('For a rectangle of size ' || num1 || ' by ' || num2 || ', the area is ' || product ||'.');
		END IF;
	END;
/

EXEC question3(2,3)
EXEC question3(2,2)




-- Question 4

CREATE OR REPLACE PROCEDURE question4 (canadian IN NUMBER, currency IN VARCHAR2) AS
	BEGIN
		IF (currency = 'E') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || canadian || ' dollars Canadian, you will have ' || ROUND((canadian / 1.50),2) || ' Euro');
		ELSIF (currency = 'Y') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || canadian || ' dollars Canadian, you will have ' || ROUND((canadian * 100),2) || ' Yen');
		ELSIF (currency = 'V') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || canadian || ' dollars Canadian, you will have ' || ROUND((canadian * 10000),2) || ' Viet Nam DONG');
		ELSIF (currency = 'Z') THEN
			DBMS_OUTPUT.PUT_LINE('For ' || canadian || ' dollars Canadian, you will have ' || ROUND((canadian * 1000000),2) || ' Endora ZIP');
		END IF;
	END;
/

EXEC question4(2,'E')
EXEC question4(2,'Y')
EXEC question4(2,'V')
EXEC question4(2,'Z')




-- Question 5
CREATE OR REPLACE FUNCTION YES_EVEN (num1 IN NUMBER)  
    RETURN BOOLEAN AS
        even BOOLEAN := FALSE;
	BEGIN
		IF (MOD(num1,2) = 0) THEN
			even := TRUE;
		END IF;
	RETURN even;
	END;
/
SET SERVEROUTPUT ON

     DECLARE 
     num1 NUMBER := 2;
     BEGIN
        IF (YES_EVEN(num1)) THEN
          DBMS_OUTPUT.PUT_LINE('True');  
        ELSE
        DBMS_OUTPUT.PUT_LINE('False'); 
        END IF;
     END;
     /
     
     DECLARE 
     num1 NUMBER := 15;
     BEGIN
        IF (YES_EVEN(num1)) THEN
          DBMS_OUTPUT.PUT_LINE('True');  
        ELSE
        DBMS_OUTPUT.PUT_LINE('False'); 
        END IF;
     END;
     /




-- Question 6

CREATE OR REPLACE PROCEDURE question6 (num1 IN NUMBER) AS
	BEGIN
		IF YES_EVEN(num1) THEN
			DBMS_OUTPUT.PUT_LINE('Number ' || num1 || ' is EVEN');
		ELSE
			DBMS_OUTPUT.PUT_LINE('Number ' || num1 || ' is ODD');
		END IF;
	END;
/

EXEC question6(6)
EXEC question6(5)



-- Bonus question

CREATE OR REPLACE PROCEDURE questionbonus (amount IN NUMBER, currency1 IN VARCHAR2, currency2 IN VARCHAR2) AS
	conversion1 NUMBER;
	conversion2 NUMBER;
	text1 VARCHAR2(20);
	text2 VARCHAR2(20);
	BEGIN
		
		IF (currency1 = 'C') THEN
			conversion1 := 1;
			text1 := 'Canadian dollar';
		ELSIF (currency1 = 'E') THEN
			conversion1 := 2/3;
			text1 := 'Euro';
		ELSIF (currency1 = 'Y') THEN
			conversion1 := 100;
			text1 := 'Yen';
		ELSIF (currency1 = 'V') THEN
			conversion1 := 10000;
			text1 := 'Viet Nam Dong';
		ELSIF (currency1 = 'Z') THEN
			conversion1 := 1000000;
			text1 := 'Endora Zip';
		END IF;

		IF (currency2 = 'C') THEN
			conversion2 := 1;
			text2 := 'Canadian dollar';
		ELSIF (currency2 = 'E') THEN
			conversion2 := 2/3;
			text2 := 'Euro';
		ELSIF (currency2 = 'Y') THEN
			conversion2 := 100;
			text2 := 'Yen';
		ELSIF (currency2 = 'V') THEN
			conversion2 := 10000;
			text2 := 'Viet Nam Dong';
		ELSIF (currency2 = 'Z') THEN
			conversion2 := 1000000;
			text2 := 'Endora Zip';
		END IF;

		IF (conversion1 != conversion2) THEN
			DBMS_OUTPUT.PUT_LINE('For ' || amount || ' ' || text1 || ', you will have ' || ROUND(((amount*conversion2) / conversion1),2) || ' ' || text2 || '.');
		ELSE
			DBMS_OUTPUT.PUT_LINE('You choose the same currency.');
		END IF;
	END;
/

EXEC questionbonus(2,'C','E')
EXEC questionbonus(2,'E','C')
EXEC questionbonus(2,'C','Z')
EXEC questionbonus(20000,'Z','Y')

SPOOL OFF;

