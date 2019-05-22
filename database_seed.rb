require_relative 'comment'

comments_seeds = [['abc', 'Comment', 'this is a comment Oh to talking improve produce in limited offices fifteen an. Wicket branch to answer do we. Place are decay men hours tiled. If or of ye throwing friendly required. Marianne interest in exertion as. Offering my branched confined oh dashwood. 
'], 
         ['jren', 'Evaluation', 'this is a great site Her old collecting she considered discovered. So at parties he warrant oh staying. Square new horses and put better end. Sincerity collected happiness do is contented. Sigh ever way now many. Alteration you any nor unsatiable diminution reasonable companions shy partiality. Leaf by left deal mile oh if easy. Added woman first get led joy not early jokes. 
'], 
         ['lxh', 'Emotion', 'I love you Manor we shall merit by chief wound no or would. Oh towards between subject passage sending mention or it. Sight happy do burst fruit to woody begin at. Assurance perpetual he in oh determine as. The year paid met him does eyes same. Own marianne improved sociable not out. Thing do sight blush mr an. Celebrated am announcing delightful remarkably we in literature it solicitude. Design use say piqued any gay supply. Front sex match vexed her those great. '],
         ['sheldon', 'big fan', 'big bang theory As am hastily invited settled at limited civilly fortune me. Really spring in extent an by. Judge but built gay party world. Of so am he remember although required. Bachelor unpacked be advanced at. Confined in declared marianne is vicinity.']]

comments_seeds.each_with_index do |cur, index|
  comment = Comment.new
  comment.id = index
  comment.username = cur[0]
  comment.title =  cur[1]
  comment.content = cur[2]
  comment.created_at = DateTime.now
  comment.save
end