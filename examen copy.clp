(deffacts factores
    (robot maxCajas 3 cajas)

    (pedido naranjas 2 cajas manzanas 6 cajas uvas 1 cajas)
    (linea naranjas 2 cajas manzanas 6 cajas uvas 1 cajas)

    (palet naranjas 3)
    (palet manzanas 56)
    (palet uvas 5)
    (palet caquis 5)
)


(defrule no_hay_suficientescajas
    (declare (salience 20))
    (pedido $?ini ?tipo ?cuantas cajas $?fin)
    (palet ?tipo ?stock)
    (test (< ?stock ?cuantas))
    =>
    (printout t "No hay suficientes cajas en el stock")
    (halt)
)

(defrule final
    (declare (salience 10))
    (pedido $?pedido)
    (linea $?pedido)
    =>
    (printout t "Pedido listo")
    (halt)
)

(defrule mover_frutas_linea_vacia_no_max
    (pedido $?ini ?tipo ?cuantas cajas $?fin)
    (linea $?linea)
    (robot maxCajas ?maxCajas cajas)
    (test(not (member$ ?tipo $?linea)))
    (test(>= ?maxCajas ?cuantas))
    =>
    (assert (linea $?linea ?tipo ?cuantas cajas))
)

(defrule mover_frutas_linea_vacia_max
    (pedido $?ini ?tipo ?cuantas cajas $?fin)
    (linea $?linea)
    (robot maxCajas ?maxCajas cajas)
    (test(not (member$ ?tipo $?linea)))
    (test(<= ?maxCajas ?cuantas))
    =>
    (assert (linea $?linea ?tipo ?maxCajas cajas))
)

(defrule mover_frutas
    (pedido $?ini ?tipo ?cuantas cajas $?fin)
    ?f <- (linea $?ini2 ?tipo ?cuantas2 cajas $?fin2)
    (robot maxCajas ?maxCajas cajas)
    (test(<= ?maxCajas =(- ?cuantas ?cuantas2)))
    =>
    (retract ?f)
    (assert (linea $?ini2 ?tipo =(- ?cuantas ?cuantas2) cajas $?fin2))
)