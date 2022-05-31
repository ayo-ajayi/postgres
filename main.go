package main

import (
	"bufio"
	"database/sql"
	"fmt"
	_ "github.com/lib/pq"
	"os"
	"strings"
)

func main() {
	Dbase()
}

var db *sql.DB
var err error
var psqlconn string

func Dbase() {
	psqlconn = Config()
	db, err = sql.Open("postgres", psqlconn)
	CheckError(err)

	defer db.Close()

	err = db.Ping()
	CheckError(err)

	fmt.Println("Connected!")
	var insertStmt string

	consoleReader := bufio.NewReader(os.Stdin)
	fmt.Println("Enter your query: ")

	insertStmt, _ = consoleReader.ReadString('\n')

	_, e := db.Exec(insertStmt)
	CheckError(e)
	if e == nil {
		defer fmt.Println("\nExecuted!")
	}

	insertStmt = strings.ToLower(insertStmt)
	position := strings.Index(insertStmt, " ")
	insertStmt_ := insertStmt[:position]

	if insertStmt_ == "select" {
		getData(insertStmt)
	}

}

func CheckError(err error) {
	if err != nil {
		panic(err)
	}
}

func Config() (dbUrl string) {
	dbUrl = os.Getenv("DATABASE_URL")
	return dbUrl
}

func getData(insertStmt string) {
	rows, err := db.Query(insertStmt)
	CheckError(err)

	defer rows.Close()
	for rows.Next() {

		var id int
		var name string
		var roll int

		err = rows.Scan(&id, &name, &roll)
		CheckError(err)

		fmt.Println(id, name, roll)
	}

	CheckError(err)
}

//https://www.katacoda.com/enterprisedb/scenarios/create-use-table

// insert into "students"("id", "name", "roll") values(148, 'Johnaie', 19)
//delete from "students" where id=1
//select * from students limit 3
