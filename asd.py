from flask import Flask, request,jsonify

app=Flask(__name__)

@app.route('/api')
def hello_world():
    
    return {"asd":"Hello World"}
#if __name__=="__main__":
app.run(debug=True,port=5001,host="0.0.0.0")
