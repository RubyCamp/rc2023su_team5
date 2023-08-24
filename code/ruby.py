#ライブラリをインポート
import networkx as nx

#Gにテキストファイルdij.edgelist.txtのデータを代入
G=nx.read_weighted_edgelist("../dij.edgelist.txt",nodetype=int)

#集合X={0, 1, 2, 3, 4, 5, 6, 7, 8}
X=set(G.nodes)


def shortest_route(G,u):
    
    #各エッジの重みを格納するリストresultsを作成
    results=[float("inf")]*nx.number_of_nodes(G)
    
    
    #始点uの重みを０、それ以外の点の重みを∞とする
    for i in X:
        if i==u:
            results[i]=0
        else:
            results[i]=float("inf")
            
 
    #集合Xが空集合になるまで繰り返す
    while X:
        node=0
        
        #集合Xから、始点uからの重みが一番小さい点を見つけ出し、変数weightに代入
        weight=float("inf")
        for a in X:
            if weight>results[a]:
                node=a
                weight=results[a]
                    
        #点i(node)を集合Xから除く
        X.remove(node)

        #D[w]>D[u]+L(u,v)ならば、D[v]をD[u]+L(u,v)に更新
        for w in G.neighbors(node):
            if results[w]>results[node]+G.edges[node,w]["weight"]:
                results[w]=results[node]+G.edges[node,w]["weight"]
                
    return results 