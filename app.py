from flask import Flask, request,jsonify
app=Flask(__name__)

@app.route('/api',methods=['GET'])
def hello_world():
    d={}
    d["Query"]=str(request.args["Query"])
    return jsonify(d)
if __name__=="__main__":
    app.run(debug=True,port=5000,host="0.0.0.0")

#2Pac, The Notorious B.I.G., Ice Cube, Kendrick Lamar, Snoop Dogg, Eminem