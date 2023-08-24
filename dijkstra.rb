#外部ファイルを取り込む
require "./a.rb"

list=[]
instance=Carrier.new
for u in 1..12
    list.push(instance.color)
end


#u:ノード(出発ノード) v:隣接ノード(終点ノード)
def weight(u, v)
    $edges[[u, v]]
end
  
  
#s:始点 
#g:終点 
#blue:青マス
#b:ボーナスマス
s="a"
a_l=("a".."l").to_a
g=0
b=0
blue=[]
white=[]


# list=[6.0,2.0,5.0,3.0,6.0,6.0,2.0,6.0,6.0,6.0,6.0,2.0]

n=0
list.each do |number|
  if number==2.0
    blue.push(a_l[n])
  elsif number==3.0
    b=a_l[n]
  elsif number==5.0
    g=a_l[n]
  else
    white.push(a_l[n])
  end
  n+=1
end

  
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
  
  

  
#ノードを定義
#各ノードの重みの初期値は0
$edges = {
  ['a', 'b'] => 0,
  ['a', 'h'] => 0,
  ['b', 'a'] => 0,
  ['b', 'c'] => 0,
  ['b', 'g'] => 0,
  ['c', 'b'] => 0,
  ['c', 'f'] => 0,
  ['c', 'd'] => 0,
  ['d', 'c'] => 0,
  ['d', 'e'] => 0,
  ['e', 'd'] => 0,
  ['e', 'f'] => 0,
  ['e', 'l'] => 0,
  ['f', 'c'] => 0,
  ['f', 'g'] => 0,
  ['f', 'e'] => 0,
  ['g', 'b'] => 0,
  ['g', 'f'] => 0,
  ['g', 'h'] => 0,
  ['h', 'a'] => 0,
  ['h', 'g'] => 0,
  ['h', 'i'] => 0,
  ['i', 'h'] => 0,
  ['i', 'j'] => 0,
  ['j', 'g'] => 0,
  ['j', 'i'] => 0,
  ['j', 'k'] => 0,
  ['k', 'f'] => 0,
  ['k', 'j'] => 0,
  ['k', 'l'] => 0,
  ['l', 'e'] => 0,
  ['l', 'k'] => 0,
}
  
  
#終点(ノードg)または青マス(リストblueに含まれているノード)と隣接するノードは重みを1に変更
$edges.each do |key_2,_|
    if key_2.include?("#{g}") || Set[*key_2].intersect?(Set[*blue])
        $edges[key_2]=1
    end
end
  

  
=begin
  
   l  －  k   －   j  －  i
   |      |       |      |
   e  －  f   －   g  －  h
   |      |       |      |
   d  －  c   －   b  －  a(start)
  
  
=end
  
#各ノードに名前を振り分けている
graph = ['a', 'b', 'c', 'd', 'e', 'f','g','h','i','j','k','l']
  
#始点からボーナス点
dijkstra(graph, s, b).join(' -> ')
  
  
$edges.each do |key_3,_|
    if key_3.include?("#{g}") && !Set[*key_3].intersect?(Set[*blue])
        $edges[key_3]=0
    end
end


#ボーナスマスから終点まで
dijkstra(graph,b,g).join(' -> ')
  
  
print $pass