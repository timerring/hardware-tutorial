 AREA Init,CODE,READONLY  ; αָ��AREA������ΪInit,����Ϊֻ����Ĵ���Ƭ��
  ENTRY  ; αָ��ENTRY�����������
  CODE32  ;�������´���Ϊ 32 λ ARM ָ��
x EQU 45
y EQU 64 ;������������ x,y
stack_top EQU 0x1000 ; �����ջ��ַ 0x1000
start MOV SP, #stack_top  ;����ջ����ַ
      MOV R0, #x  ;��x��ֵ����R0
      STR R0, [SP]  ;R0�е�ֵ��x��ֵ����ջ
      MOV R0, #y  ;��y��ֵ����R0
      LDR R1, [SP]  ; ���ݳ�ջ������R1����R1�з�x��ֵ
      ADD R0, R0, R1  ;R0=R0+R1
      STR R0, [SP,#4] ;��ִ��SP+4(ARMΪ32λָ�)���ٽ�R0���ݸ��Ƶ�SPָ��ļĴ���
      B .
  END  ;�������