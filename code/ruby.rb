#u:ノード(出発ノード) v:隣接ノード(終点ノード)
def weight(u, v)
  $edges[[u, v]]
end




#s:始点 
#g:終点 
#blue:青マス
#b:ボーナスマス
s="a"
g="c"
blue=["b","g","l"]
b="d"



#最終的な最短ルートを格納するリスト
$pass=[]
  
#graph:グラフ 
#dijkstra(グラフ,始点,終点)
def dijkstra(graph, s, g)
  d = {}
  prev = {}
  q = []



  #始点を0,それ以外の点を1としハッシュdに追加
  #d:各ノードのコストを格納  d={始点 => 0 , その他の点 =>1}
  #q:未探索のノードを格納  q=['a', 'b', 'c', 'd', 'e', 'f','g','h','i','j','k','l']
  graph.each do |v|
    if s == v
      d[v] = 0
    else
      d[v] = 1
    end
    q.push(v)
  end


  #リストqに要素がある間(未探索のノードがある間)、while文内の処理を実行
  while !q.empty?
    #リストqから要素を取り出し変数vに代入
    #ハッシュd内の要素のうち最小のノード(コストが最も小さいノード)を、変数uに代入
    u = q.min_by { |v| d[v] }

    #リストqからuを削除
    q.delete(u)
  
    #ハッシュテーブルedgesから、出発ノードがuであるノードを取り出す
    $edges.select { |edge, _| edge[0] == u }.each do |(v1, v), _|

        
      #target_d=始点からノードuまでのコスト(d[u])+ノードuからノードvまでのコスト(weight(u,v))
      target_d = d[u] + weight(u, v)

      #if 始点からノードvまでのコスト(d[v])>始点からノードuまでのコスト(d[u])+ノードuからノードvまでのコスト(weight(u,v)
      if d[v] > target_d
        d[v] = target_d

        #prev={v => u}
        prev[v] = u
      end
    end
  end



  #経路を格納するリストshortest_pathを作成
  shortest_path = []
  
  #g==sを満たさない間,until内の処理を繰り返す
  until g == s
    #リストshortest_pathの先頭にgを追加(終点から始点までのノードを順に追加している)
    shortest_path.unshift(g)
    g = prev[g]
  end

  #リストshortest_pathの先頭に始点を追加
  shortest_path.unshift(s)

  shortest_path.each do |l|
    $pass.push(l)
  end
end

$edges = {
  ['a', 'b'] => 1,
  ['a', 'h'] => 0,
  ['b', 'a'] => 1,
  ['b', 'c'] => 1,
  ['b', 'g'] => 1,
  ['c', 'b'] => 1,
  ['c', 'f'] => 0,
  ['c', 'd'] => 0,
  ['d', 'c'] => 0,
  ['d', 'e'] => 0,
  ['e', 'd'] => 0,
  ['e', 'f'] => 0,
  ['e', 'l'] => 1,
  ['f', 'c'] => 0,
  ['f', 'g'] => 1,
  ['f', 'e'] => 0,
  ['g', 'b'] => 1,
  ['g', 'f'] => 1,
  ['g', 'h'] => 1,
  ['h', 'a'] => 0,
  ['h', 'g'] => 1,
  ['h', 'i'] => 0,
  ['i', 'h'] => 0,
  ['i', 'j'] => 0,
  ['j', 'g'] => 1,
  ['j', 'i'] => 0,
  ['j', 'k'] => 0,
  ['k', 'f'] => 0,
  ['k', 'j'] => 0,
  ['k', 'l'] => 1,
  ['l', 'e'] => 1,
  ['l', 'k'] => 1,
}

graph = ['a', 'b', 'c', 'd', 'e', 'f','g','h','i','j','k','l']


puts dijkstra(graph, 'a', 'c').join(' -> ')