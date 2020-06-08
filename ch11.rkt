;;Understanding the difference between using different types of reduction rules
;;In the first reduction rule we can see that due to the difference in the grammer there are multiple ways to get to the output
;;However, the way we define 

#lang racket
(require redex)


(define-language bool-any-lang
  [B true
     false
     (V B  B)]
  [C (V C B)
     (V B C)
     hole])

(define B1 (term true))
(define B2 (term  false))
(define B3 (term  (v true false)))
(define B4 (term (V ,B1 ,B2)))
(define B5 (term (V false, B4)))

(define C1 (term hole))
(define C2 (term (V (V false false) hole)))
(define C3 (term (V hole true)))

(redex-match bool-any-lang B B1)
(redex-match bool-any-lang B B4)
(redex-match bool-any-lang B B5)


;;Reduction relations
(define ->
  (reduction-relation
   bool-any-lang
   (-->  (in-hole C (V true B))
         (in-hole C true)
         "true")
   (-->  (in-hole C (V false B))
         (in-hole C B)
         "false")
   ))

;;Tracing
(traces ->  B5)

;;ANother way of representing the  language
(define-language bool2
  [B true
     false
     (V B B)]
  [E (V  E B)
     hole])

(define o->
  (reduction-relation
   bool2
   (--> (in-hole E (V  true B))
        (in-hole E true)
        "true")
   (--> (in-hole E (V false B))
        (in-hole E B)
        "false")
  ) )
  
(traces o->  B5)

   
      
  
     

