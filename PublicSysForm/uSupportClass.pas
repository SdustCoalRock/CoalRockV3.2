//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
//<<      �ļ�����uSupportClass.pas                          <<
//<<      luleiʹ�õĸ���Delphi�ļ�                            <<
//<<      ���ļ���Ҫ����Ϊ��ѹ���ݷ���ʹ��                     <<
//<<      �������ڣ�2016.5.12                                   <<
//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


unit uSupportClass;
interface

uses
  Windows, SysUtils, Classes, Messages, Controls, Forms, StdCtrls, ExtCtrls,
  ComCtrls,math,IniFiles,Jpeg,Graphics,Dialogs;

type
  TZJ_Class=class
      public
         Zj_Name: WideString;    //֧�ܵ�����
         Zj_BianHao:WideString;  //֧�ܵı��
         Zj_leixing:WideString;   //֧�ܵ��ͺ�
         Zj_Lizhu_count: Integer;  //֧����������
         Zj_toall_F:double;       //֧�������迹��
         zj_toall_P:double;       //֧��֧��ǿ��
         Zj_suoliang:double;      //֧���������
         Zj_Max_h:double;         //֧�����߶�
         Zj_min_h:double;         //֧����С�߶�
         Zj_KongdingJU:double;    //֧�ܿض���
         Zj_zhongxinju:double;    //֧�����ľ�
         Zj_hlzyd:double;        //�������õ�
         Zj_hubang_h:double;      //֧�ܻ���߶�
         Zj_hubang_jishu:integer;  //֧�ܻ��Ｖ��
         zj_hubang_F:double;     //֧�ܻ�������
         zj_hubang_P:double;     //֧�ܻ���ǿ��

   end;

   TSupportStep =Class(TZj_Class)
        Lz_Diameter  :double;//������ֱ��������ʹ�õģ�
        SupportBh:integer;//   ֧�ܵı�� �� Zj_BianHao һ��
        initLoad:double; //    ֧�ܳ�ʼ֧��ǿ�� ����Ҳ�г�����
        EndOpenLoad: double; // ֧��Һѹ������ʱǿ��
   End;


implementation

{ TSupportStep }



end.