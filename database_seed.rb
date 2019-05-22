require_relative 'comment'
require_relative 'student'

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


student_seeds = [['W1234', 'Junyao', 'Ren', Date.new(1990, 7, 14), '1921 Maple Ave., Dalls, TX, USA', 'Biology', 'kind', 'hahaha'], 
                 ['W1235', 'Xiaohong', 'Li', Date.new(1988, 5, 6), '5402 Junewood Ave., San Jose, CA, USA', 'Computer Science', 'pretty', 'won a prize'],
                 ['W1239', 'Guo', 'Yang', Date.new(1993, 12, 3), '200 Inwood Ave., San Jose, CA, USA', 'Art', 'humor', 'N/A'],
                 ['W1243', 'Jing', 'Guo', Date.new(1992, 2, 13), '404 Hampton Ave., Santa Clara, CA, USA', 'Socioloty', 'serious', 'N/A'],
                 ['W12333', 'Wantong', 'Lao', Date.new(1993, 12, 3), '2009 Siping Rd., Guang Zhou, Guang Dong, China', 'Math', 'happy', 'N/A'],
                 ['W1231', 'Wuji', 'Zhang', Date.new(1993, 12, 3), '500 Lexi Rd., Shanghai, Shanghai, China', 'Neurology', 'sad', 'great guy '],
                ]

student_seeds.each_with_index do |cur, index|
  student = Student.new
  student.student_id = cur[0]
  student.firstname = cur[1]
  student.lastname = cur[2]
  student.birthday = cur[3]
  student.address = cur[4]
  student.major = cur[5]
  student.personality = cur[6]
  student.notes = cur[7]
  student.save
end