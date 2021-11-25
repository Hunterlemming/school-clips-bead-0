(deftemplate diet
	(slot cel (allowed-symbols nil fogyas tartas noveles))
	(slot sport-mennyiseg (allowed-symbols nil a b c))
	(slot etel-mennyiseg (allowed-symbols nil keves normal sok))
	(slot etel-elkészitesi-ido (allowed-symbols nil keves normal sok))
	(slot etel-ar (allowed-symbols nil keves normal sok))
)

(deffacts d (diet))

(defrule zero ""
	(declare (salience 10))
	(diet (cel fogyas))
=>
	(printout t "asd" crlf)
	(halt))

(defrule first ""
	(declare (salience 10))
	(diet (cel fogyas))
=>
	(printout t "Pizza" crlf)
	(halt))

(defrule question-1 ""
	?d <- (diet (cel nil))
=>
	(printout t "Mi a cel?" crlf)
	(printout t "   fogyas/tartas/noveles " crlf)
	(modify ?d (cel (read)))
)

(defrule question-2 ""
	?d <- (diet (sport-mennyiseg nil))
=>
	(printout t "Mennyit sportolsz hetente?" crlf)
	(printout t "	a (0h-2h)" crlf)
	(printout t "	b (4h-6h)" crlf)
	(printout t "	c (10h +)" crlf)
	(modify ?d (sport-mennyiseg (read)))
)

(defrule noresp ""
                (not (item $?))
=>
         (printout t "A megadott parametereknek egyik dieta sem felel meg!" crlf)
         (halt)
    )