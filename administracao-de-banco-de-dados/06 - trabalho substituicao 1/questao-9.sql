/*
ALTERAÇÕES
- TIPO DE DADO DOS PARÂMETROS DE NUMBER PARA INT
- CORREÇÃO NA CLÁUSULA WHERE DO CURSOR C_ESTOQUE (PRODUTOS COM MAIS DE x UNIDADES)
- REMOÇÃO DA CLÁUSULA IF/ENDIF DENTRO DO FOR LOOP, VISTO QUE ESSA VERIFICAÇÃO 
    (AUX.QTDE_ESTOQUE > P_QUANTIDADE) JÁ ESTÁ SENDO FEITA PELA CLÁUSULA WHERE DO CURSOR
- CORREÇÃO DO CÁLCULO DO DESCONTO DENTRO DO FOR LOOP
*/

CREATE OR REPLACE PROCEDURE PROC_QUEIMA_ESTOQUE (P_QUANTIDADE IN INT, P_PERCENTUAL IN INT) IS
    
CURSOR C_ESTOQUE IS
    SELECT ID_PRODUTO, QTDE_ESTOQUE
    FROM ESTOQUE
    WHERE QTDE_ESTOQUE > P_QUANTIDADE;
    
V_CONTADOR INT := 0;

BEGIN
    /* PRODUTOS QUE ESTÃO ENCALHADOS E RECEBERÃO DESCONTO */
    FOR AUX IN C_ESTOQUE LOOP
        UPDATE PRODUTO 
        SET VL_PRECO = VL_PRECO * (1 - (P_PERCENTUAL / 100)) 
        WHERE ID_PRODUTO = AUX.ID_PRODUTO;
    END LOOP;

    /*INCREMENTO DO CONTADOR*/
    V_CONTADOR := V_CONTADOR + 1;

    /* MENSAGEM COM TOTAL DE PRODUTOS COM DESCONTO */
    DBMS_OUTPUT.PUT_LINE('QUANTIDADE DE PRODUTOS COM DESCONTO: ' || TO_CHAR(V_CONTADOR));

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO INESPERADO: ' || SQLERRM);
END PROC_FAZ_PROMOCAO;

