PGDMP                  
    |            PETS_FRIENDS    16.1    16.1 =    .           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            /           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            0           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            1           1262    25018    PETS_FRIENDS    DATABASE     �   CREATE DATABASE "PETS_FRIENDS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Portuguese_Brazil.1252';
    DROP DATABASE "PETS_FRIENDS";
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            2           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    25067    abandono    TABLE        CREATE TABLE public.abandono (
    numero integer NOT NULL,
    descricao character varying(500) NOT NULL,
    foto character varying(500),
    lugar character varying(200) NOT NULL,
    data_abandono timestamp without time zone,
    status_adm character varying(100) NOT NULL,
    fk_cpf_usuario character varying(11),
    fk_email_administrador character varying(150),
    nome_denunciante character varying(255),
    telefone_denunciante character varying(15),
    email_denunciante character varying(255)
);
    DROP TABLE public.abandono;
       public         heap    postgres    false    4            �            1259    25066    abandono_numero_seq    SEQUENCE     �   CREATE SEQUENCE public.abandono_numero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.abandono_numero_seq;
       public          postgres    false    219    4            3           0    0    abandono_numero_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.abandono_numero_seq OWNED BY public.abandono.numero;
          public          postgres    false    218            �            1259    25139 
   administra    TABLE     �   CREATE TABLE public.administra (
    id integer NOT NULL,
    fk_cpf_usuario character varying(11),
    fk_veterinario_crmv character varying(14),
    fk_email_administrador character varying(150)
);
    DROP TABLE public.administra;
       public         heap    postgres    false    4            �            1259    25138    administra_id_seq    SEQUENCE     �   CREATE SEQUENCE public.administra_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.administra_id_seq;
       public          postgres    false    227    4            4           0    0    administra_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.administra_id_seq OWNED BY public.administra.id;
          public          postgres    false    226            �            1259    25061    administrador    TABLE     �   CREATE TABLE public.administrador (
    email character varying(150) NOT NULL,
    nome character varying(200) NOT NULL,
    senha character varying(100) NOT NULL
);
 !   DROP TABLE public.administrador;
       public         heap    postgres    false    4            �            1259    25086    animais    TABLE     �  CREATE TABLE public.animais (
    codigo integer NOT NULL,
    diagnostico character varying(1000) NOT NULL,
    nome character varying(50) NOT NULL,
    raca character varying(50) NOT NULL,
    idade character varying(2) NOT NULL,
    status character varying(10) NOT NULL,
    estado_de_saude character varying(200),
    fk_cpf_usuario character varying(11),
    fk_email_administrador character varying(150),
    img character varying(500)
);
    DROP TABLE public.animais;
       public         heap    postgres    false    4            �            1259    25085    animais_codigo_seq    SEQUENCE     �   CREATE SEQUENCE public.animais_codigo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.animais_codigo_seq;
       public          postgres    false    221    4            5           0    0    animais_codigo_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.animais_codigo_seq OWNED BY public.animais.codigo;
          public          postgres    false    220            �            1259    25122    atende    TABLE     �   CREATE TABLE public.atende (
    id integer NOT NULL,
    fk_animais_codigo integer,
    fk_veterinario_crmv character varying(14)
);
    DROP TABLE public.atende;
       public         heap    postgres    false    4            �            1259    25121    atende_id_seq    SEQUENCE     �   CREATE SEQUENCE public.atende_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.atende_id_seq;
       public          postgres    false    4    225            6           0    0    atende_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.atende_id_seq OWNED BY public.atende.id;
          public          postgres    false    224            �            1259    25105    consulta    TABLE     <  CREATE TABLE public.consulta (
    numero integer NOT NULL,
    status character varying(10) NOT NULL,
    horario timestamp without time zone NOT NULL,
    data date NOT NULL,
    prontuario character varying(250) NOT NULL,
    fk_cpf_usuario character varying(11),
    fk_veterinario_crmv character varying(14)
);
    DROP TABLE public.consulta;
       public         heap    postgres    false    4            �            1259    25104    consulta_numero_seq    SEQUENCE     �   CREATE SEQUENCE public.consulta_numero_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.consulta_numero_seq;
       public          postgres    false    223    4            7           0    0    consulta_numero_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.consulta_numero_seq OWNED BY public.consulta.numero;
          public          postgres    false    222            �            1259    25047    usuario    TABLE     +  CREATE TABLE public.usuario (
    cpf character varying(11) NOT NULL,
    nome character varying(200) NOT NULL,
    data_de_nascimento date NOT NULL,
    telefone character varying(14) NOT NULL,
    senha character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    foto bytea
);
    DROP TABLE public.usuario;
       public         heap    postgres    false    4            �            1259    25054    veterinario    TABLE     N  CREATE TABLE public.veterinario (
    crmv character varying(14) NOT NULL,
    nome character varying(200) NOT NULL,
    telefone character varying(14),
    email character varying(150) NOT NULL,
    senha character varying(100) NOT NULL,
    endereco character varying(200),
    foto bytea,
    cpf character varying(11) NOT NULL
);
    DROP TABLE public.veterinario;
       public         heap    postgres    false    4            p           2604    25070    abandono numero    DEFAULT     r   ALTER TABLE ONLY public.abandono ALTER COLUMN numero SET DEFAULT nextval('public.abandono_numero_seq'::regclass);
 >   ALTER TABLE public.abandono ALTER COLUMN numero DROP DEFAULT;
       public          postgres    false    218    219    219            t           2604    25142    administra id    DEFAULT     n   ALTER TABLE ONLY public.administra ALTER COLUMN id SET DEFAULT nextval('public.administra_id_seq'::regclass);
 <   ALTER TABLE public.administra ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            q           2604    25089    animais codigo    DEFAULT     p   ALTER TABLE ONLY public.animais ALTER COLUMN codigo SET DEFAULT nextval('public.animais_codigo_seq'::regclass);
 =   ALTER TABLE public.animais ALTER COLUMN codigo DROP DEFAULT;
       public          postgres    false    220    221    221            s           2604    25125 	   atende id    DEFAULT     f   ALTER TABLE ONLY public.atende ALTER COLUMN id SET DEFAULT nextval('public.atende_id_seq'::regclass);
 8   ALTER TABLE public.atende ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    224    225            r           2604    25108    consulta numero    DEFAULT     r   ALTER TABLE ONLY public.consulta ALTER COLUMN numero SET DEFAULT nextval('public.consulta_numero_seq'::regclass);
 >   ALTER TABLE public.consulta ALTER COLUMN numero DROP DEFAULT;
       public          postgres    false    223    222    223            #          0    25067    abandono 
   TABLE DATA                 public          postgres    false    219   �I       +          0    25139 
   administra 
   TABLE DATA                 public          postgres    false    227   �I       !          0    25061    administrador 
   TABLE DATA                 public          postgres    false    217   �I       %          0    25086    animais 
   TABLE DATA                 public          postgres    false    221   �J       )          0    25122    atende 
   TABLE DATA                 public          postgres    false    225   'L       '          0    25105    consulta 
   TABLE DATA                 public          postgres    false    223   AL                 0    25047    usuario 
   TABLE DATA                 public          postgres    false    215   [L                  0    25054    veterinario 
   TABLE DATA                 public          postgres    false    216   �M       8           0    0    abandono_numero_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.abandono_numero_seq', 15, true);
          public          postgres    false    218            9           0    0    administra_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.administra_id_seq', 1, false);
          public          postgres    false    226            :           0    0    animais_codigo_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.animais_codigo_seq', 17, true);
          public          postgres    false    220            ;           0    0    atende_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.atende_id_seq', 1, false);
          public          postgres    false    224            <           0    0    consulta_numero_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.consulta_numero_seq', 1, false);
          public          postgres    false    222            |           2606    25074    abandono abandono_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.abandono
    ADD CONSTRAINT abandono_pkey PRIMARY KEY (numero);
 @   ALTER TABLE ONLY public.abandono DROP CONSTRAINT abandono_pkey;
       public            postgres    false    219            �           2606    25144    administra administra_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.administra
    ADD CONSTRAINT administra_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.administra DROP CONSTRAINT administra_pkey;
       public            postgres    false    227            z           2606    25065     administrador administrador_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public.administrador
    ADD CONSTRAINT administrador_pkey PRIMARY KEY (email);
 J   ALTER TABLE ONLY public.administrador DROP CONSTRAINT administrador_pkey;
       public            postgres    false    217            ~           2606    25093    animais animais_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.animais
    ADD CONSTRAINT animais_pkey PRIMARY KEY (codigo);
 >   ALTER TABLE ONLY public.animais DROP CONSTRAINT animais_pkey;
       public            postgres    false    221            �           2606    25127    atende atende_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.atende
    ADD CONSTRAINT atende_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.atende DROP CONSTRAINT atende_pkey;
       public            postgres    false    225            �           2606    25110    consulta consulta_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_pkey PRIMARY KEY (numero);
 @   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_pkey;
       public            postgres    false    223            v           2606    25053    usuario usuario_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (cpf);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public            postgres    false    215            x           2606    25060    veterinario veterinario_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.veterinario
    ADD CONSTRAINT veterinario_pkey PRIMARY KEY (crmv);
 F   ALTER TABLE ONLY public.veterinario DROP CONSTRAINT veterinario_pkey;
       public            postgres    false    216            �           2606    25075 %   abandono abandono_fk_cpf_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.abandono
    ADD CONSTRAINT abandono_fk_cpf_usuario_fkey FOREIGN KEY (fk_cpf_usuario) REFERENCES public.usuario(cpf);
 O   ALTER TABLE ONLY public.abandono DROP CONSTRAINT abandono_fk_cpf_usuario_fkey;
       public          postgres    false    4726    219    215            �           2606    25080 -   abandono abandono_fk_email_administrador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.abandono
    ADD CONSTRAINT abandono_fk_email_administrador_fkey FOREIGN KEY (fk_email_administrador) REFERENCES public.administrador(email);
 W   ALTER TABLE ONLY public.abandono DROP CONSTRAINT abandono_fk_email_administrador_fkey;
       public          postgres    false    217    4730    219            �           2606    25145 )   administra administra_fk_cpf_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.administra
    ADD CONSTRAINT administra_fk_cpf_usuario_fkey FOREIGN KEY (fk_cpf_usuario) REFERENCES public.usuario(cpf);
 S   ALTER TABLE ONLY public.administra DROP CONSTRAINT administra_fk_cpf_usuario_fkey;
       public          postgres    false    215    4726    227            �           2606    25155 1   administra administra_fk_email_administrador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.administra
    ADD CONSTRAINT administra_fk_email_administrador_fkey FOREIGN KEY (fk_email_administrador) REFERENCES public.administrador(email);
 [   ALTER TABLE ONLY public.administra DROP CONSTRAINT administra_fk_email_administrador_fkey;
       public          postgres    false    227    4730    217            �           2606    25150 .   administra administra_fk_veterinario_crmv_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.administra
    ADD CONSTRAINT administra_fk_veterinario_crmv_fkey FOREIGN KEY (fk_veterinario_crmv) REFERENCES public.veterinario(crmv);
 X   ALTER TABLE ONLY public.administra DROP CONSTRAINT administra_fk_veterinario_crmv_fkey;
       public          postgres    false    216    227    4728            �           2606    25094 #   animais animais_fk_cpf_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.animais
    ADD CONSTRAINT animais_fk_cpf_usuario_fkey FOREIGN KEY (fk_cpf_usuario) REFERENCES public.usuario(cpf);
 M   ALTER TABLE ONLY public.animais DROP CONSTRAINT animais_fk_cpf_usuario_fkey;
       public          postgres    false    215    221    4726            �           2606    25099 +   animais animais_fk_email_administrador_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.animais
    ADD CONSTRAINT animais_fk_email_administrador_fkey FOREIGN KEY (fk_email_administrador) REFERENCES public.administrador(email);
 U   ALTER TABLE ONLY public.animais DROP CONSTRAINT animais_fk_email_administrador_fkey;
       public          postgres    false    4730    221    217            �           2606    25128 $   atende atende_fk_animais_codigo_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.atende
    ADD CONSTRAINT atende_fk_animais_codigo_fkey FOREIGN KEY (fk_animais_codigo) REFERENCES public.animais(codigo);
 N   ALTER TABLE ONLY public.atende DROP CONSTRAINT atende_fk_animais_codigo_fkey;
       public          postgres    false    4734    221    225            �           2606    25133 &   atende atende_fk_veterinario_crmv_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.atende
    ADD CONSTRAINT atende_fk_veterinario_crmv_fkey FOREIGN KEY (fk_veterinario_crmv) REFERENCES public.veterinario(crmv);
 P   ALTER TABLE ONLY public.atende DROP CONSTRAINT atende_fk_veterinario_crmv_fkey;
       public          postgres    false    4728    225    216            �           2606    25111 %   consulta consulta_fk_cpf_usuario_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_fk_cpf_usuario_fkey FOREIGN KEY (fk_cpf_usuario) REFERENCES public.usuario(cpf);
 O   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_fk_cpf_usuario_fkey;
       public          postgres    false    223    4726    215            �           2606    25116 *   consulta consulta_fk_veterinario_crmv_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.consulta
    ADD CONSTRAINT consulta_fk_veterinario_crmv_fkey FOREIGN KEY (fk_veterinario_crmv) REFERENCES public.veterinario(crmv);
 T   ALTER TABLE ONLY public.consulta DROP CONSTRAINT consulta_fk_veterinario_crmv_fkey;
       public          postgres    false    223    216    4728            #   
   x���          +   
   x���          !   �   x�����0�w��[51$��R��DP�SnS()���9(��"��7�2N�C�d��Y��,���;g!7����c��	�ZcS9ӈ~f��3������`�|���U ��_�FPʢ�(�P�5$��8*v��֑P�b�'[>{���8>]�f`o���O
>	�ƷzR      %   �  x����N�0��y�ݡ�뺎-ި��D�[ӭ])�_֕��+���ހ�k�����5�x2�έ�d�bU*�Db�B�DH��>Z�f��7V���-ʬ�Եय#�%a93j*�Xe���d#v_���f �lt7rû��dE:�R� q\�2w\���M�H�99��z{B�"�\��A�$�$U4(g�u\8�! ��vCa�eqտ��O���O�
�Y{`Y7O7Sp�eF�}nXf��C�0p��?m!��R,���g�#}zT�d�L�F���[e�d��|1�:�����V٫��J��cS��O���Db���l��f�BVe!~�������0D���|꡹I�Ǘ�u��l⢫�����_p*�.�!����@���0�      )   
   x���          '   
   x���             J  x���_k� ���)|���'��^2F�ҍ�ݞmkS��L�ƾ��	�}�^�����Gg���uf��3h���[��N:m���|=]��q���s��w`\K#�2�
�P�!��c!� 9�4��8�ѩt�E�V��Ӫ�y��5ܸ�[�������o(�E�E25֩F�80�(8�`,G��$4?1в��6i�u�1N�1�z�U2�;;�3D2t��s,���a�\�ѕ�M�-��+�)A�9���"ke�O��.A���M(���u��u�W^�ZW]�2�`��(xr~�����m��t��~�(?��:i�vЖ��ǧ�\��\�L          �   x���M�@�����YPK�Q(]���"�Ϋ-��G�j?w�6���w�� ��[A�\��e��Q/�hd�Y���~;��1��^���V	�`��S�Qi�3��DYc��ԭ��[0�{p�4��cw�qv���[��L����E!���+8�����$J.Ϩ�3p#�x;%�B)eL�X���Q�     