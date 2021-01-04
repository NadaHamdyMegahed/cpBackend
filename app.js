const express = require('express');
const app = express();
const cors = require("cors");
const fs = require('fs');
app.use(express.json());
var cmd=require('node-cmd');
const lineReader = require('line-reader');
const httpN = require("https-localhost")('http://bachelor.ap.ngrok.io')

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET, PUT, POST, DELETE, OPTIONS");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, X-Auth-Token, Content-Type, Accept"
  );
  // res.header("Access-Control-Expose-Headers", "Access-Token", "X-Auth-Token")
  next();
});
app.use(
  cors({
    origin: true, credentials: true,
    exposedHeaders: "X-Auth-Token"
  })
);



//get result of query
app.get('/getRes/',(req,res)=>{


var result =""


require('fs').readFileSync("./queryResult.txt", 'utf-8').split(/\r?\n/).forEach(function(line){
  result+=line+"%"
})
res.send(result)
 
})



  
  //execute query and save result in txt file
  app.post('/execute/',(req,res)=>{
    fs.writeFile('./queryResult.txt', "", err => {
      if (err) {
        throw(err)
      }
      })
    var cmd=require('node-cmd');
  const processRef=cmd.get('swipl solve.pl');
  let data_line = '';
  
  var query = req.body.query+"\n";
  var i = req.body.numberOfResults;
  
  var zew=`;
  `;
  processRef.stdin.write(query);
  
  processRef.stdout.on(
    'data',
    function(data) {
      
      data_line +=data;
      if (data_line[data_line.length-1] == '\n') {
               //writing the output in  text file
  fs.writeFile('./queryResult.txt', data_line, err => {
  if (err) {
    console.error(err)
    return
  }
  })
    }
     else{
       if(i>0){
        i--;
         processRef.stdin.write(zew);
      }
  else{processRef.stdin.write(".");}
      }
    }
  );
  
    res.send(query)
   
  })






app.listen(8000||env.config.Port,()=>{ console.log("listening on 8000") });









