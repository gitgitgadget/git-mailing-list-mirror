From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: [PATCH] Add some new icons, and apply them where appropriate
Date: Wed, 13 Aug 2008 21:57:02 +0200
Message-ID: <48A33C8E.6050008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:13:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTMUD-00030i-JX
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 21:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbYHMT5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 15:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYHMT5W
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 15:57:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:9015 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYHMT5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2008 15:57:12 -0400
Received: by ug-out-1314.google.com with SMTP id h2so158851ugf.16
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=3Q5ge91W0WGly9X34/kAEtun68jqh0DX1jGLGxYr9PQ=;
        b=IKU42fvwD1kfOwJrgTmQ03madqGyFiECKz3Z7nf11tq2he7R61LBNQfcClocRYwSjW
         AJl0acUm9lmSCumIwBB3uC/ci5N/EteZyUV6eU/Xrdk7drjae2kJwL7BMfhqnbUih+Db
         12uhtAB/Sdi2vpDoXTZPGMwKUUaEbmjHc1i/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=WGxRuHrNLqPexjHVVvz1AMvhRCqnICfVa/HU2aw3fo4Zb57sFYC+icozoI0ioYp26w
         Gs8dwPO8vbpyihs9rPqkFv+FrYCJgFs0N5Bf2wwvPBnduLNkD4YJ8DLN4kvKLFzy7xmW
         5fhv3VblZmxkg1w7Dvr870UwfGqm0bNseXiLc=
Received: by 10.67.119.8 with SMTP id w8mr17865ugm.20.1218657429350;
        Wed, 13 Aug 2008 12:57:09 -0700 (PDT)
Received: from ?192.168.1.20? ( [84.202.12.123])
        by mx.google.com with ESMTPS id s7sm3563567uge.26.2008.08.13.12.57.06
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 12:57:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92259>

These icons are based on look of the existing CVS and
SVN plugins, only with a Git branding (gray, red, green).

Having the same look and feel as the other team plugins
will probably help us in being distributed as part of
the Eclipse platform.

Signed-off-by: Tor Arne Vestb=F8 <torarnv@gmail.com>
---

Topic branch here:

http://repo.or.cz/w/egit/torarne.git?a=3Dshortlog;h=3Drefs/heads/new-ic=
on-theme


 org.spearce.egit.ui/icons/etool16/checkout.gif     |  Bin 0 -> 569 byt=
es
 org.spearce.egit.ui/icons/etool16/import_wiz.gif   |  Bin 602 -> 0 byt=
es
 .../icons/etool16/newconnect_wiz.gif               |  Bin 0 -> 368 byt=
es
 .../icons/etool16/newlocation_wiz.gif              |  Bin 0 -> 600 byt=
es
 org.spearce.egit.ui/icons/eview16/git_persp.gif    |  Bin 0 -> 578 byt=
es
 org.spearce.egit.ui/icons/obj16/import_obj.gif     |  Bin 0 -> 357 byt=
es
 org.spearce.egit.ui/icons/sharing.gif              |  Bin 564 -> 0 byt=
es
 org.spearce.egit.ui/icons/wizban/import.png        |  Bin 4739 -> 0 by=
tes
 org.spearce.egit.ui/icons/wizban/import_wiz.png    |  Bin 0 -> 6461 by=
tes
 .../icons/wizban/newconnect_wizban.png             |  Bin 0 -> 4918 by=
tes
 .../icons/wizban/newlocation_wizban.png            |  Bin 0 -> 5535 by=
tes
 org.spearce.egit.ui/plugin.xml                     |    4 ++--
 .../src/org/spearce/egit/ui/UIIcons.java           |    6 +++++-
 .../ui/internal/sharing/ExistingOrNewPage.java     |    2 ++
 14 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/etool16/checkout.gif
 delete mode 100644 org.spearce.egit.ui/icons/etool16/import_wiz.gif
 create mode 100644 org.spearce.egit.ui/icons/etool16/newconnect_wiz.gi=
f
 create mode 100644 org.spearce.egit.ui/icons/etool16/newlocation_wiz.g=
if
 create mode 100644 org.spearce.egit.ui/icons/eview16/git_persp.gif
 create mode 100644 org.spearce.egit.ui/icons/obj16/import_obj.gif
 delete mode 100644 org.spearce.egit.ui/icons/sharing.gif
 delete mode 100644 org.spearce.egit.ui/icons/wizban/import.png
 create mode 100644 org.spearce.egit.ui/icons/wizban/import_wiz.png
 create mode 100644 org.spearce.egit.ui/icons/wizban/newconnect_wizban.=
png
 create mode 100644 org.spearce.egit.ui/icons/wizban/newlocation_wizban=
=2Epng

diff --git a/org.spearce.egit.ui/icons/etool16/checkout.gif b/org.spear=
ce.egit.ui/icons/etool16/checkout.gif
new file mode 100644
index 0000000000000000000000000000000000000000..16872a90cea9a8f0fb3732b=
353db2c61294fc077
GIT binary patch
literal 569
zcmZ?wbhEHb6krfwc*Xz%|NsC0{^QToh1<S<|JBvgH+A~VxhvMMShafL;w3MC{Qvmt
zU)H*;ift9```RZQp0H~5ij5oB@7g)*_t&1kzxMw9weQdttKT1{{rS53&zCiSzO4QJ
zDB{G<u%9nWf4*w?`Ks~ftES)Yr+vMb`1!ii*Lz97A7%f3QhIo~_OVr_e{T8wx$XD$
zX2O9vvab)S9$ut!c(MA?Ju|<ZwD@+?a_=3DOO*E?1AO*7j!-E8kvvprMH_f50dJ=3DtR4
zG^^cHEO$+^++NRps897^uiD#rJO?5pk7Z__sjR%v+zj*%*jqz`Q2fcl$iU#npaXI)
zC{7sIr!}}WHMg`j%jl`=3D>ln+lHHm4eiAX6Z8H)95XsJ$_W@y)MV<IgqtE}tj&~K|P
zK5zQ!Hmh|alJe8-`z^E;MJ41^jCQq|8yr7z@}!%Y5Yzb!7tag1nVvh(!NKCn!hetD
zilrb63n%w;m*;%kEP`&<0?*mFKRZ9?eJ;?%&h?j-m8<1T@`d*Y_SJC+E16`ZG#qXh
KP-J6bum%87Qo@x0

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/etool16/import_wiz.gif b/org.spe=
arce.egit.ui/icons/etool16/import_wiz.gif
deleted file mode 100644
index 57878582d7daad0d2ca76ccb9192b75d6587b1a4..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 602
zcmZ?wbhEHb6krfwI2Opj8#9Zcfq}Q3*SKJ@alsOiE)j?F<?<8c6(=3Da3$zn5}Y5cU3
z?QX5u{W{TW%{-S{l>L_bU2apl+^!tDDl}$Y%$>=3DCNgI>WHm7B7$(*`y+oL(ckLHNx
zZp(czSG-_HLGjMwM~fuqu2^5TyX?_2kyWc#JX@jAe6V@r#`T>?IzMfczrS61*UniJ
zPE0tuXXeZ^Ghgnve0x;&!wKu(Cv{d|UH$vC?uYX>pRby3zrFqERhOSPe81iIJ@V+t
zw+E5m9z^|oS#aa^jazST{rr%6=3Dk1-l@9zG7-~Ic2&!dlzo_~J+`s?dIKNi0I_V)ev
z_n&@z`u6MF_ut=3Dt{Q2?w@9+PE2`K&(bS_FwEJ;mKD9<d(P;mG34Pa3G$->CRP|u*l
z00f|jVqjm?P~X(t(%P&qtspDPr{C73Wn}5;YHO;g)vsz|F=3Dd)2XTOk?nWL3~GB-~@
zzoFf{>8slW*Lk|wOy}*_-LrS!z9#L!!-xI6j~v!Mcp^}bE6_>YJ@8b$dVrdYu(_O=3D
zmjt7{uX>Y;2cr_By#{Nb^{c>UMIR0UMspD+^Y=3DRb^=3D$P{E;Ah;GE7i(?y+$E(SKk*
XkASk5NJ;}kgL^9v4+DdO0E0CEz8Ygu

diff --git a/org.spearce.egit.ui/icons/etool16/newconnect_wiz.gif b/org=
=2Espearce.egit.ui/icons/etool16/newconnect_wiz.gif
new file mode 100644
index 0000000000000000000000000000000000000000..d698b00f31441f4c689cae0=
3979fcceea38f6c0b
GIT binary patch
literal 368
zcmZ?wbhEHb6krfwxXJ(m|NsC0{^QToh1<S<|JBvgH+A~VxhvMMShafL;w3MC{Qvmt
zU)H*;ift9```RZQo^bKm#Z{|U+_`&e_MFbyb7b=3DKMgISP_y7N&jT_fboRG6?=3Dd9T?
zO8@<RzjJN*-!JE1Jh^go&&<D{&u^WmymgZDuIXxjo-dwPDYmRpYFU%i(k7{OUGfK(
z1pL0+{PW4GnI*!{_UC-RSbiWf@>pi(naauw&CNi!f!&CcQ2fcl$iQIApaW6?@)HAF
z?}1qb9wL*vPAGO3`v|!zpUVhgj$D83{He#Btu|V{2|jAegH*4qT&Bn&z`@k}p~AsO
zXR^R%51oI;^?dbu&Vt-*9o$Csy!ArP>|9)|tXzhZc_y<@oIG#-Y-i@hOO`J26j`~_
xQ&?JBQiPFFTtsr6u(Q7GZV@ptU6I|g`p#?DiyG+bi*A$N;URkQqNgK+H2}lap6LJp

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/etool16/newlocation_wiz.gif b/or=
g.spearce.egit.ui/icons/etool16/newlocation_wiz.gif
new file mode 100644
index 0000000000000000000000000000000000000000..768901b590fa8d1dc6b4b71=
2216065c9b87a1f62
GIT binary patch
literal 600
zcmZ?wbhEHb6krfwc*Xz%|NsC0{^QToh1<S<|JBvgH+A~VxhvMMShafL;w3MC{Qvmt
zU)H*;ift9```RZQp0H~5ij5oB@7g)*_t&1kzxMw9weR2G_lLGv{r)iR&)3y|zO4E4
zW$pJz5hr$r{d`&a^HsyoSB*bkHT`}+?d!e7&)1#4-b?!ZDEs%5(!<NOkF7HObIa$?
zZNINK6aIcV|KiD&19N0wA5=3DZONagTi^`m=3Dc{{4J@>qO<PlazN&SNnF-;@e5fKhGEM
zog^}^Qtb6km1T`m%bKK?Hc74PlK*|Td1i_5zG-Irrkm}ZYPM&J`MzluyC+-hn`X6p
zisi0JmWTRO|J_~q?bfm{*H;~gj69Z^d8V@RLUS|F@8B>PFhcPs3nK$VD1#2j1)w-#
zVBgvh+SJ_A+AM3RVWe*@+icz<uB9#_t*C4v9%?Q&p-EF)ZR&Ije^WCtGqWadTNz<F
z6$3v<U0o9sUB^%#9f`#=3D0vsHy?CqL7_lZa;%<v7hak6Q4*HIFclvlMpAL`uVX8h>!
z6TQcwu0l+&-@JV-6zcNoH3tVv2n+u&mJc3+EG$Ag5*Dconps(tLIRl*7c{c+FXhQ;
m5NKM!%w;5|u|UDgjZKn2=3D8VTC70-#GY%5|;PD)i^um%7hCFmgl

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/eview16/git_persp.gif b/org.spea=
rce.egit.ui/icons/eview16/git_persp.gif
new file mode 100644
index 0000000000000000000000000000000000000000..f556a64ab9b6f0a32520a66=
7646509205399ece4
GIT binary patch
literal 578
zcmZ?wbhEHb6krfwc*Xz%|NsBbNKF3v?f3T|e_R97{GtoKe*g99>rZ<}=3DeIxpnOj-~
z28Ve0_&)yj|K*SWAAkK*k5Jc5(lyOBwJx>(`62bskA;7JEc*SS>-YQa-|u^Vz9{(l
zvf$f&-)|2hzCDQi_8@BK0)@|4O-u8<-yT){aNg$7a+9A|U4Gv1{cyti_eq`Kr*)4n
zx7t5h_R%ttU0tGk`o#Bi3V+%t-&^MNXpZpqMuAPm+?&efHkQe4sg&PRsj$9Oetn6;
z`Z9%`dBQvLM4nc%t%_wUP*ki^Q)|)H?J+ivii!gI2<)>VKq&rXVPs%%XV3w;6%;27
z?DHGk-PH^Y^i9pwn!39cwKT+}6jY5Ad%AVC)hA9ia-7~|Yoa77tD@&%zrfu_Q)bST
zRST@wiAl;&v0H7SDJ?D`w{x|*@zG<)kGmgXK6Ccm8Dn=3D#Wo8Z*9v*gAc9FXr%I;Rm
z92~p?&t0Ai3*3Lm#Kpxa@X7hPkN_8xyN(+lA3wL4jlib|jxFqbJsd_4)-OEV#>OH#
Q!((I8(NKwg7A6L30E7Rpk^lez

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/obj16/import_obj.gif b/org.spear=
ce.egit.ui/icons/obj16/import_obj.gif
new file mode 100644
index 0000000000000000000000000000000000000000..9035f0be3936598516b0cf8=
b8235fcdbe85e0825
GIT binary patch
literal 357
zcmZ?wbhEHb6krfwxXJ(m|NsC0{^QToh1<S<|JBvgH+A|<<ANo|1&bZZm-EKVn!95C
zidCx@E?)BT$N!JN{$;Jps@PW1zOQ}4;R&l&ub4fjbM_pW{CtuB|KHuYbM62CKN~l$
zpEx0B*Uni753HI!qjcxm@}qlZ{(Q3P+5VjG7t24~SaKjT@>pi(naauw&CNio!A>Bb
zQ2fcl$iSe*paU`j<R=3DEUCWom79y(mkCzcplzTud6Va0;WDjX6#PF)5sg;pFoyZEEV
z;!~48rFm3J-02Ut3|ht`&gZ`Hfx%P7O78N?mexjR=3DFYC}E;lW)2^0E6<>h6>7#XF+
zWTuKbD=3DRD#laNpnTcn_>#i=3D!Anz)LxviMv%NltcG@jZK-cXIW)a&mATJk;mNU=3D0A=
*
C--hx4

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/sharing.gif b/org.spearce.egit.u=
i/icons/sharing.gif
deleted file mode 100644
index 07b60c873d5811b0b8dd6204670c903f84ac51a2..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 564
zcmZ?wbhEHb6krfwc*el+?fb8<-~W96`s>yEUv-mq)`QUYmT9~4+t!!$Y%cHF+%j>+
zz2`sfJ^%jj<&T%|f4%?w>+bXK4_^Lw`sT-{ufHC?`tk79_a|?DbWB-t_r>?m-+q1i
z_Up&5KYcS6PMbY@+U!|#7fzeIaO%ZNdzLPp@b}lAzrXgLKezYy=3DlXwtp8fy#e)D4K
zLz{JeyomVyaoXBd-OHBr|NHae`{Te9JKVoLN!YT!<L}Q~e}CTo^P=3D?6tJ-&`l@71g
z+p@M}{mP!d-)|mXB7ba!#@BNuzpq*SzG1U#L(A_^XAUorKD<Eo>p9c6yA}5K2<)Dq
z^JX#6ksgU7-I9m9qz|^sY%gPfJB@2+9_Ro6{}~1WQ2fcl$iNWHpaXIXC{7sICpH8(
zHMg|3H5s|uxp^A3H)%UssOTCyX!qMYnX6892<Z3n&`~$E^!D#pvo+AvFm?B9b>6ad
zi>ZU}W|=3D*Eoy{D4TCEw_S-3bDO%5Dt(UW3gl9m>+aS04+)fZrA<Kz%fzOL1(!2Fz_
vpIK4Ks!d*;o%MvUT)(WS7@w%9kZiw%l*@?&3QjCM{bCw1D>eiuFjxZsIo#tf

diff --git a/org.spearce.egit.ui/icons/wizban/import.png b/org.spearce.=
egit.ui/icons/wizban/import.png
deleted file mode 100644
index 8f9fc202ca7c8870da720b5983d42cbc8a9edc16..00000000000000000000000=
00000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 4739
zcmV-}5`686P)<h;3K|Lk000e1NJLTq002t>002S=3D1^@s6A3-Z300001b5ch_0Itp)
z=3D>Px#24YJ`L;wH)0002_L%V+f000SaNLh0L01FcU01FcV0GgZ_00007bV*G`2iO7%
z6D%Ut^{|Bi000?uMObu0Z*6U5Zgc=3Dca%Ew3Wn>_CX>@2HM@dakSAh-}000r*Nkl<Z
zc-rlpdyr&TS-^kaIrq`s(>=3D30v#-39(gczvA(4kM#sEf1EU5&LM~D<)QAMFrf=3DCr&
zsaW!lT8JfDfU$y>1`LlPyyQ^`1_D7MhLsQ!2qb~*CcCq{^Vpf5>Av@z@AHq_^X{IR
zO=3DdTdaH?+Ie%yQd+~56P=3Deyr&;is){`>UG|cr$8dHeyB#sLM~WtN@e(bu)&|Y{-oI
z^6#JYu>R(w4|_9))TpUi-PDHE$od_dJXs<A-7SyQRcV-6X5cYvVV19V&XWq(`#yQl
zsgavm%M339W;8HsZbr+VG_Y>?^r4oTH3Xa)P)XCUK(<+1^b-&3#?Kt8t5Hc3V3i2f
z4O#+X$I;hMEUbV2{CL*$YN=3DQSsprvJ2#w{RoiJGAUw!4-z{S1oEa2?kSI^zx)G1(J
z@AW=3Dl8n_kMx9jqornU;wO<y?d)oj>|+A0_#!Zsi?dvtwoN?i|q<@y&QTnoHVaN7WI
z87>>e`4*D4s*jQ(#JAR*ujK@$MfJLS1hWF|99;a~(0#zI7=3DOF_iVr^cXhD78KMoI>
z(KIus25MktsF468rk1FIs-fE3_uj|e-g@U9H>^Wnx&C6{7T|30L-^VreB(@9wiA~O
z0S>`E%4p4@#U!yjN^Czsn7e;bgMi=3DPeZ>biEo~qA&m(D1nliIx5Gq&+FlvS@hqI-y
z4t@Fh*8u+{*>=3D+5i*Q3{_D*oCI;da?4iUE@AVh!!TkNOWn-+xWeH7Dof_C-+FWUW_
zjiu}(w;mZ%qiKdy>s@RQf>jbVYG$Ig63&*vI(X}KXA3+)x`%An6}TjaO@NREXf9cD
zGva%2k{+y;kX8>Nw8trqd=3Df1W@7wd-n=3DcvkYahGqs8eOTVVNmCNm_zskO++GYKeLb
zu=3D*1)USkGHYcDR%acK>gW{aE8YWTc{&l@DQ21#Rxv^hjJJVL%>C$-(X2w{?<JxS<B
zLQphP4KRYL!xYQ}t0Z7)Q*ilSFfKm$rRy&4H@uI3^=3DJ*)DbjyhA|i=3D%GTIa4Eo=3DR=
~
zp(&D&Al{*K<49u+m$z^}?P*daA>w+QPjHDxe1aLo2+7C}ii6*!IC?kYhLCgwN$QBN
zfy)r_AW2Vk9U3}lcLobxKr3pnZS~MT@wJIzgCQ~N>-q%}ag~iSwzl<!Wmc(^%S(tu
zXfcD8vuIkw=3DR-(ZN0JPm<%mxZ=3DP)YCS#ZlPZIX<f4$c$XM~HI|BEEt6AtcEw77At&
z3&o;}`n*Ltaw_HY$}#=3D>e@!?wwl5g*0X8LZPDa&i%R#LpSv~1WJd!Dx2g?vZi#8VK
zk#0hCg17`+1_mY$@oA+_v5UrHS$8FIem`2Y5tsKQEJa)m#N)Ci`Sx>2x1C9xA72qM
ze&!pKsTre!xj_&_@XpDo8N!JmHCVEAX%NmKNrFo<gvwZBpdnQI7$Agde6}Q6rV;J7
z(HJX(pX4|VfMVr57E6-a9+Ji=3DerPAYz60@%HDmbP9g}r~ZR-Y-f_P!uiBP?bB}?f$
z7my^ur8UIoxFkcPVnNXuu&6yyu4kwNF3T%0VHhjt5lOH(k2qiXK*<oFR#Mhy429d-
z5ZM3}ka!t2BQZOXs0L1VY=3Dv|U3>JKXIS|XMxXHk*GT5eyg)SE6dixHPT`VTm>-GBY
ziD~It^$jn;$uN+dSWN4w;Q+}3D34AfKF2p2i{8&naE&Gaac+JUtPU2sxXgigbiP}8
zJX1^~Xb15n$yj~u7&f?H-bq8m>Z+WSHbAm;!zsBHB}QBZYq&adz6%JZR>6v02wljV
z6|7Eyg|ea{g7{>B9a!g%0nU**p`|BQq@<_b2_OT#;h-_3qoY^^>l9lu8sBW<YOOxr
zc%3T{ycgNFr6$S{HBwbe%t(7vCE27J+Q5;zJjV^SmW;VAdFym+3{23n=3D*3TUEEc_B
z6Oys9MK!Dpd;-q(i(CepwbaWtGn2;x%c$UlXsN2DQArl2ON07-)M~g<;zyFS3KL@a
zC_CwIv{Em_2+5-XWrmMR8lz<~k}b>yH`~{7g$^gR^<m|m<jzq)9y?`*L?w^W@~D>T
zalqM}H$<@ku1GOL=3DrC6t1019Ev9-sT(k|Lq>{1u$o7y-!e-tF6Roh0sFjrhNhNY`=3D
zf=3D|4R=3Dq9f;Dp>_cbJeZ6_s1<+lk*c*Q0mil?xqp6#A3jFvTkm0ww$FM17nR{D~;Bw
zF{FvxW@fUH9SYIvL9M2W+iFiac)DYo3to=3DS9mPx-ZR}i<7z8uJEHc%Z#bTGyw7GPA
z>~2DRbTKeay)<PVJ7wU@XpI;xS37YgBw0U-UfZ_UM+pXVx;3FgGi{P*t%1Moon+q2
zP`|)ajkFBbh)QZF!Nv|$!_EHqSYvEO=3DrC3vBdT(&GmVL-S=3D)xwuoyawHLB3z=3D-lD=
;
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
Rl+^$L002ovPDHLkV1g)i1z-RG

diff --git a/org.spearce.egit.ui/icons/wizban/import_wiz.png b/org.spea=
rce.egit.ui/icons/wizban/import_wiz.png
new file mode 100644
index 0000000000000000000000000000000000000000..b3207b35fcc71643ba2500d=
f2875a23b69541274
GIT binary patch
literal 6461
zcmV-D8N%j?P)<h;3K|Lk000e1NJLTq002t>002S=3D1^@s6A3-Z300009a7bBm000XU
z000XU0RWnu7ytkYPiaF#P*7-ZbZ>KLZ*U+<Lqi~Na&Km7Y-Iodc-oy)XH-+^7Crag
z^g>IBfRsybQWXdwQbLP>6p<z>Aqfylh#{fb6;Z(vMMVS~$e@S=3Dj*ftg6;Uh<iVD~V
z<RPMtgQJLw%KPDaqifc@_vX$1wbwr9tn;0-&j-K=3D43<bUQ8j=3DJsX`tR;Dg7+#^K~H
zK!FM*Z~zbpvt%K2{UZSY_<lS*D<Z%Lz5oGu(+dayz)hRLFdT>f59&ghTmgWD0l;*T
zI7<kC6aYYajzXpYKt=3D(8otP$50H6c_V9R4-;{Z@C0AMG7=3DF<Rxo%or10RUT+Ar%3j
zkpLhQWr#!oXgdI`&sK^>09Y^p6lP1rIRMx#05C~cW=3DH_Aw*bJ-5DT&Z2n+x)QHX^p
z00esgV8|mQcmRZ%02D^@S3L16t`O%c004NIvOKvYIYoh62rY33S640`D9%Y2D-<?i
z0%4j!F2Z@488U%158(66005wo6%pWr^Zj_v4zAA5HjcIqUoGmt2LB>rV&neh&#Q1i
z007~1e$oCcFS8neI|hJl{-P!B1ZZ9hpmq0)X0i`JwE&>$+E?>%_<lS*MWK+n+1cgf
z<k(8YLR(?VSAG6x!e78w{cQPuJpA|d;J)G{fihizM+Erb!p!tcr5w+a34~(Y=3D8s4G
zw+sLL9n&JjNn*KJDiq^U5^;`1nvC-@r6P$!k}1U{(*I=3DQ-z@tBKHoI}uxdU5dyy@u
zU1J0GOD7Ombim^G008p4Z^6_k2m^p<gW=3DD2|L;HjN1!DDfM!XOaR2~bL?kX$%CkSm
z2mk;?pn)o|K^yeJ7%adB9Ki+L!3+FgHiSYX#KJ-lLJDMn9CBbOtb#%)hRv`YDqt_v
zKpix|QD}yfa1JiQRk#j4a1Z)n2%f<xynzV>LC6RbVIkUx0b+_+BaR3cnT7Zv!AJxW
zizFb)h!jyGOOZ85F;a?DAXP{m@;!0_Ifq<Ex{*7`05XF7hP+2Hl!3BQJ=3D6@fL%FCo
z8iYoo3(#bAF`ADSpqtQgv>H8(HlgRxt7s3}k3K`kFu>>-2Q$QMFfPW!La{h336o>X
zu_CMttHv6zR;&ZNiS=3DX8v3CR#fknUxHUxJ<AYmRsNLWl*PS{AOARHt#5!wki2?K;t
z!Y3k=3Ds7tgax)J%r7-BLphge7~Bi0g+6E6^Zh(p9TBoc{3GAFr^0!gu?RMHaCM$&Fl
zBk3%un>0uoBa_M6WNWeqIg~6QE69c9o#eyhGvpiOA@W-aonk<7r1(?fC{oI5N*U!4
z<uv66WtcKSRim0x-Ke2d5jBrmLam{;Qm;{ms1r1GnmNsb7D-E`t)i9F8fX`2_i3-_
zbh;7Ul^#x)&{xvS=3D|||7=3DmYe33=3DM`AgU5(xC>fg=3D2N-7=3DcNnjjOr{yriy6mM=
=46gG#l
znCF=3DfnQv8CDz++o6_Lscl}eQ+l^ZHARH>?_s@|##Rr6KLRFA1%Q+=3D*RRWnoLsR`7U
zt5vF<Q0r40Q)j6=3DsE4X&sBct1q<&fbi3VB2Ov6t@q*0);U*o*SAPZv|vv@2aYYnT0
zb%8a+Cb7-ge0D0knEf5Qi#@8Tp*ce{N;6lpQuCB%KL_KOarm5cP6_8Ir<e17iry6O
zDdH&`rZh~sF=3Dbq9s+O0QSgS~@QL9Jmy*94xr=3D6y~MY~!1fet~(N+(<=3DM`w@D1)b+=
p
z*;C!83a1uLJv#NSE~;y#8=3D<>IcfW3@?wFpwUVxrVZ>QdQz32KIeJ}k~{cZZE^+ya?
z2D1z#2HOnI7(B%_ac?{wFUQ;QQA1tBKtrWrm0_3Rgps+?Jfqb{jYbcQX~taRB;#$y
zZN{S}1|}gUOHJxc?wV3fxuz+mJ4`!F$IZ;mqRrNsHJd##*D~ju=3DbP7?-?v~|cv>vB
zsJ6IeNwVZxrdjT`yl#bBIa#GxRa#xMMy;K#CDyyGyQdMSxlWT#tDe?p!?5wT$+oGt
z8L;Kp2HUQ-ZMJ=3D3XJQv;x5ci*?vuTfeY$;({XGW_huIFR9a<fJbF^|4I#xQ~n$Dc=3D
zKYhjYmgz5NSkDm8*fZm{6U!;YX`NG>(?@3)XSs8O^N5RyOM=3DTTmp(3=3D8^+zpz2r)C
z^>JO{deZfso3oq3?Wo(Y?l$ge?uXo;%ru`Vo>?<<(8I_>;8Eq#KMS9gFl*neeosSB
zfoHYnBQIkwkyowPu(zdms`p{<7e4kra-ZWq<2*OsGTvEV%s0Td$hXT+!*8Bnh2KMe
zBmZRodjHV?r+_5^X9J0WL4jKW`}lf%A-|44I@@LTvf1rHjG(ze6+w@Jt%Bvjts!X0
z?2xS?_ve_-k<Mujg;0Lz*3buG=3D3$G&ehepthlN*$KaOySSQ^nWmo<0M+(UEUMEXRQ
zMBbZcF;6+KElM>iKB_KiJlZ$9G`c^=3DE@oNG)mWWaNo-3TIW8)$Hg0Ub-~8?KhvJ>$
z3*&nim@mj(aCxE5!t{lw7O5^0EIO7zOo&c6l<+|iDySBWCGrz@C5{St!X3hAA}`T4
z(TLbXTq+(;@<=3DL8dXnssyft|w#WSTW<++3>sgS%(4NTpeI-VAqb|7ssJvzNHgOZVu
zaYCvgO_R1~>SyL=3DcFU|~g|hy|Zi}}s9+d~lYqOB71z9Z$wnC=3DpR9Yz4DhIM>Wmjgu
z&56o6maCpC&F##y%G;1PobR9i?GnNg;gYtchD%p19a!eQtZF&3JaKv33gZ<8D~47E
ztUS1iwkmDaPpj=3D$m#%)jCVEY4fnLGNg2A-`YwHVD3gv};>)hAvT~AmqS>Lr``i7kw
zJ{5_It`yrBmlc25DBO7E8;5VoznR>Ww5hAaxn$2~(q`%A-YuS64wkBy=3D9dm`4cXeX
z4c}I@?e+FW+b@^RDBHV(wnMq2zdX3SWv9u`%{xC-q*U}&`cyXV(%rRT*Z6MH?i+i&
z_B8C(+grT%{XWUQ+f@NoP1R=3DAW&26{v-dx)iK^-Nmiuj8txj!m?Z*Ss1N{dh4z}01
z)YTo*JycSU)+_5r4#yw9{+;i4Ee$peRgIj+;v;ZGdF1K$3E%e~4LaI(jC-u%2h$&R
z9cLXcYC@Xwnns&bn)_Q~Te?roKGD|d-g^8;+aC{{G(1^(O7m37Y1-+6)01cN&y1aw
zoqc{T`P^XJqPBbIW6s}d4{z_f5Om?vMgNQEJG?v2T=3DKYd^0M3I6IZxbny)%vZR&LD
zJpPl@Psh8QyPB@KTx+@RdcC!KX7}kEo;S|j^u2lU7XQ}Oo;f|;z4Ll+_r>@1-xl3|
zawq-H%e&ckC+@AhPrP6BK<z=3D<L*0kfKU@CX*zeqbYQT4(^U>T#_XdT7&;F71j}Joy
zkC~6lh7E@6o;W@^IpRNZ{ptLtL(gQ-CY~4mqW;US7Zxvm_|@yz&e53Bp_lTPlfP|z
zrTyx_>lv@x#=3D^!PzR7qqF<$gm`|ZJZ+;<)Cqu&ot<a{81DF0~rvGr5Xr~8u`lav1h
z1DNytV>2z=3D0000WV@Og>004R=3D004l4008;_004mL004C`008P>0026e000+nl3&F}
z000hXNkl<Zc-rh+Ta2C8SzX`W|K*%BXRf|GN$tcgNgb3#Y2#FcKuM_|N<kGADj^ZU
z144o)1eW@M1Uw)C66FCTA|%8`jYvh*0;;0sLX#+v6o`{rsoVMz+Zo&A#B;M}=3DFB<&
zzxVzY5C6H&#h%NtJ2>5=3D(fRL}b=3DJ4``o6u7;74u6_UF%BvLs3*he-?qC`Uhnr3auG
zK$*mlDhEiEyZ3+S!TQT*CoG8pB}%F+Q#qhSveL01TCo1=3D>zB)_sE|wuSdfDt)9an{
zp#tlve}CU7k&+xFVMPEE6_8Z`a-;J<G+_PhH$E6tvLb*X0TgT+5+IQ^UgNe0>+hcX
zpsYl}BmgWZR3<PefN&kxx^2Pwhv%;(B!)=3DF!U7}|Kn+4r>E8CC1?wv>PFf|0NR*a<
zAtD$7kdPa@_H6~$(=3DSa9kf;h^dhifLMlei8#7$iPwgBs^FHglyHYEVCggKEBjFIcp
zr`r;&e|cqUK#8hA440^o0Fj7{k=3D!&;|F6ON+H2EB6{7@`mBd<#&>K@i$o|}Otri25
zul>cR0KB}F0emrkaxV#xh#(lFLX?Cmp+xVe_O6HKCkZGw$t<q~2JS$7@bgF$i`W{7
ztpA0`=3D7W-0{vzyr5@35<=3DXkb`CyQ$li0YRyGWE?)=3D$Za#)Y4|wdSK=3DW7ZlbAjL=
3$7
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
1*q
ze1LNS&MTY?$bD#T)Aqh~Gpn8jt3(yxrWw`ND(T-(*w*v~MWZhm!x!QNunMHq6+GMW
zUxl^ivtF06OV&pK*nR*d0*S1YaT~QZSdBcC0i;Ff$);=3DbEmqxjVC7DYKt}q(sN0oQ
z9cBqe32cM(XS64>lK!yV`b`DP2Q2~E(=3DVW!sZ9m9VKV^kmOlQlJT{Vuh`AlX`o94H
X23FBd?&h!>00000NkvXXu0mjf0}CoN

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/wizban/newconnect_wizban.png b/o=
rg.spearce.egit.ui/icons/wizban/newconnect_wizban.png
new file mode 100644
index 0000000000000000000000000000000000000000..ec9a393fb8085d619f325c5=
2dcdd20535bbd6cbe
GIT binary patch
literal 4918
zcmV-66Upp}P)<h;3K|Lk000e1NJLTq002t>002S=3D1^@s6A3-Z300009a7bBm000XU
z000XU0RWnu7ytkYO=3D&|zP*7-ZbZ>KLZ*U+<Lqi~Na&Km7Y-Iodc-oy)cUY767Czti
zWe-+D*zmEJY=3DHnGBdiF>5Lu!Sk^o_Z5E4Meg@_7P6crJiNL9pw)e1<Rh~l6qxMx9%
zh+2zPTsZC@+^4mDdhhM+``7!t=3DbY#K&Uw!dfDsZVk>;Xm069{HJUZAPk55R%$-RIA
z6-eL&AQ0xu!e<4=3D008g<d3b(wus{3(uWtYX0C3eVBofEr|AV?vCRYF;kpSQ#66Xs6
zkWv81E>y@A0LT~suv4>S3ILP<0Bm`DLLvaF4FK%)Nj?Pt*r}7;7Xa9z9H|HZjR63e
zC`Tj$K)V27Re@400>HumpsYY5E(E}?0f1SyGDiY{y#)Yvj#!WnKwtoXnL;eg03bL5
z07D)V%>y7z1E4U{zu>7~aD})?0RX_umCct+(lZpemCzb@^6=3Do|A>zVpu|i=3DNDG+7}
z<RYAxn<EoQ=3DL1a63;+Nc`O(4tI6si*=3DH%h#X6J10^u?n7Yw&L(J|Xen{=3DAF=3D1O=
O0D
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
~y|
zolZYJ)S29Q_e}hmYh6)Yy=3DOzuo<A3K?o78|_sR3#=3DZ{_Rym0g)_hQ>6w@a-(u02P7
zaQ)#(uUl{HW%tYNS3ItC^iAtK(eKlL`f9+{bJzISE?u8_z3;~C8@FyI-5j_jy7l;W
z_U#vU3hqqYU3!mrul&B+{ptt$59)uk{;_4iZQ%G|z+lhASr6|H35TBkl>gI*;nGLU
zN7W-nBaM%pA0HbH8olyl&XeJ%vZoWz%6?Y=3DdFykl=3DimL}`%BMQ{Mhgd`HRoLu6e2R
za__6DuR6yg#~-}Tc|Gx_{H@O0eebyMy5GmWADJlpK>kqk(fVV@r_fLLKIeS?{4e)}
z^ZO;zpECde03c&XQcVB=3DdL;k=3DfP(-4`Tqa_faw4Lbua(`>R<o>I+y?e7jKeZ#YO-C
z2xCb^K~#9!?3>$fTt^+pKXWd7apFtdIL^%w$w4ha!WFnF)P)uhLWD~NDdO_b2Y5m7
z1pEP|k368hfPg0`qKZ^1P|5>srKZ;;MKWq!Qc4m#X>)6Y(>SqX@18j`^W)*n+Pm?_
zvDbFGNN1$g*|R%mcII<_zwdl!j;%z5yezK-If5Kk4l9S1!^&ahuyO=3DBtQ=3DMjD~FZC
z%3<XQa#-t9qUBapN&ztW>Mwr|Jle)%da3U-Kl|Kj8)>$66|J<9)Cp?C4&vS4pi~Hm
z!T`^4Ma7BWoZtk1TsW87xd_hH*A=3D9`zGQ=3DPF8jQE?F~9+j<ru3Y9pl95e8YbwE`-;
zb-n|t@f;DvpNfExfvCUZLS0>{T`pJ=3Dw2?M~WgV$qn+^qaq=3DP`Mx;^W%{(az@RV#@R
zVz)N1+!}9b8z<OxjI5QzvI4d}_wB6{tZgS)#u414LrP_-r4|X<f>76q4}~~HM2I7W
zv4XLVQZXV76p7Xp;v#}jttNzFL=3D;7cfOQsU9o9Nh7cezb^^pbIv{@QPP0}z76jN8P
zaq;3s-oJ7sQ)dsYR4j7u-eH_ws2>+1&OZG#sZMbs4D5e6>rklp>+yq`ko(zgUc_ZV
z;A`Ul)jRhsM3x9iJEftvj=3D~L*6$XkECr@(j-1&ydt`=3DV%<ubC^$e?FtaL(Zb3Wb=3D=
&
zXtdU(X^O!>{cI?;8Pd;&0;Q;fC@ui$d>Xc$z}LeH1I3wl-eG*=3DGzy5Kh+VsO(c9aL
zF)7p2GnC6^q{$en)6;}u*pQxK81t>WA4VyKh@iFR_oGh`M=3D^r%$R{4bi4cY%)k?zk
zxuikh+bXiE#!;$+rPGwR{{1#-ni9t`d-vW$Pj@#?1O;sE??=3DdtWW&s5Eu<+{YeXPP
zGys*vWJcAS%}rfJs%ZtM?7SJ9yqe6L(fVeM%lg+=3DkyZ0qVW>Dg@eZ@IvjBW#_ilQ+
zyRm)*QWKhHGnaL!G{qRxXf$uM1IA!U(YBV0vgB--w3l^oXeWeWK%f*CFTO{bricie
zH*aoOQw2fY%qTJsF%$g)vr|(<ag2yiEJUOgvv`I@alJA_x!i#uL{S7JH}zSGZPUn7
zN>Qm)&{}&QjUClmbLh~E0QB~5;@-V`8-Ru4aMcPT5CqK^6HyeQO+sYDEcz7xN0DV5
zslR(dCbVgqqLiXqO)|USqpMUZa`xQ0`E<&xMD|^xHI?ZZ3WY4Pj4{n!zH?Y*(Js3o
z)oOJK2cPw?ZPtc~5ww*|XB_nRZ^0Ntnx>46jV&^y#+XcZti8c*gmjimIIVFy_3712
z+YDhGU|dS-H04t11B<K`!>XEWA?;k|xbM32E}|&H7{j|~&+_`~{~!tj!a#vQ7=3D~DD
z7r_bwg-H^e)<~)sec!OJ6bQx{tTVS<8@AVMXvNP=3DSt%Ba+&?nHbI(7IQi>x-k8)~!
zoZW+i^O`d^H-~esL2i^%OkKWA$wx{UhQMNA#bS{tj;QM7)(dHoZ0*`!nk99i@A%lB
zJ=3DqrJ%P*s~=3DJMssOioVD8_VXFz~Y>%OE-IyG_<^b<qD-@aY6f**rG|=3D)o0xZZ1><=
G
z;}a81Pfv6H{CSGSB7J>*baizxuybdFQ&)lFvritNR4Sr%N}4twWTl$&t8e}m5kV=3DK
zOU#mK*me$HHwks?98nyzXU|7bWIL#}HJsqxcAaf-4pb15XoImePq4V%N-E4wRWipe
zvS=3DmH-kRmNm2bMC=3DcMVNZ`XcSTg`^aO(LruifK2^sv22SShcirYp_-AH7giBJXTmu
zmxf1%%$m)H;}<UQ=3D<j}wQi@ieGt@oIS@2WT>zrRBG;Xf?bwhofh0mv^ui_*q0t2;y
zFQEy|zSBTDdU)(wGas|^=3DZ04PaBX((rLpnx6<t?|;;?sPXGd2@$A*qVu~dlSQjdP>
zHxGXC$IMK<#VfD9deU_7f1LUCpHhKRfy&CV<l>I<20BaS8K8e90qMacKoyw1Sw*$n
ze;QCNJ|G-DJQe_DpbO}F;kh6FB1x`3wA3}5dha~&>H8o1^X-s1|Ed6Uz%}3!F#XB<
zJ}#?{tQCSP0-Zp&e|09w)rY?Dz}M*C@}b3v=3D~B*2yus09qu&KyS;wx4hm?3w2`~ek
z8y*>&tCxj!hc$Y5ECe<Jn|ws|cxW2|`nL|UYw$i)5HIMJoy8@Sn93wakBtIsT_;e^
z!@2H{bHFL!!tltDThrO_@yB-E4LrV7o!1WSkCh5Tr6PX}B7Y2P8+t14Mui<-3oI^4
z8-XAB(f3;+(bs?f$qx^H@6-}$H|vj8U;;QkJTf%1F4o~I`##@O?AY~StGD%uKOR_C
zy)W<k(m*Ti&sO^9=3D8^`HuBDvz(KH2|295ydZxv0eg0-P@8yoNV)GD%Id9Zr6wDueJ
zzq)fSVS62@ijSsRy1fdF4UY^}*4>mo`}c#u!PP6Qxem6jztU)Hp8nHMTWWX9wy$s8
zHt_BKx|Eyt>GlF}cz9%J^0qnnAN=3DI_OWq-G2DW=3D4-U9S_f79z<U0&2Tc<T@Xg$vJo
zXNx$ER4+Ao@VWqOXz!D{#W9t9L|q2Pf#-l{fp>>ThE}yqSP?AmnR+~=3D0bnPv!yjw!
zw|h8|Uwa1J@R;Gf3vc7})h4^5j!T!$&HLCE$E1N1z~6ws04Ih=3DhU{%!8;%|xi+$wm
zr~|YE*yi8YjvJS1r+@1`ym;i$lE1Zc;DJ`gk^*OdXMm@GH-|@t64tOR+rj_y$eSH?
zsn!SF;f-dOkE9|Hv*g37b@NTrz<+>$0TZo=3D_u?p*)?wu(|I_XqRt_tNmBY$m<t2xe
o!^&ahuyR;Ati0r~R#g5s0M+}*_n7-H)Bpeg07*qoM6N<$f`vqY6951J

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/wizban/newlocation_wizban.png b/=
org.spearce.egit.ui/icons/wizban/newlocation_wizban.png
new file mode 100644
index 0000000000000000000000000000000000000000..769973fe14776daf7a20644=
89e5a97b25cc50a6a
GIT binary patch
literal 5535
zcmV;Q6=3D3R#P)<h;3K|Lk000e1NJLTq002t>002S=3D1^@s6A3-Z300009a7bBm000XU
z000XU0RWnu7ytkYO=3D&|zP*7-ZbZ>KLZ*U+<Lqi~Na&Km7Y-Iodc-oy)cUY767Czti
zWe-+D*zmEJY=3DHnGBdiF>5Lu!Sk^o_Z5E4Meg@_7P6crJiNL9pw)e1<Rh~l6qxMx9%
zh+2zPTsZC@+^4mDdhhM+``7!t=3DbY#K&Uw!dfDsZVk>;Xm069{HJUZAPk55R%$-RIA
z6-eL&AQ0xu!e<4=3D008g<d3b(wus{3(uWtYX0C3eVBofEr|AV?vCRYF;kpSQ#66Xs6
zkWv81E>y@A0LT~suv4>S3ILP<0Bm`DLLvaF4FK%)Nj?Pt*r}7;7Xa9z9H|HZjR63e
zC`Tj$K)V27Re@400>HumpsYY5E(E}?0f1SyGDiY{y#)Yvj#!WnKwtoXnL;eg03bL5
z07D)V%>y7z1E4U{zu>7~aD})?0RX_umCct+(lZpemCzb@^6=3Do|A>zVpu|i=3DNDG+7}
z<RYAxn<EoQ=3DL1a63;+Nc`O(4tI6si*=3DH%h#X6J10^u?n7Yw&L(J|Xen{=3DAF=3D1O=
O0D
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
~y|
zolZYJ)S29Q_e}hmYh6)Yy=3DOzuo<A3K?o78|_sR3#=3DZ{_Rym0g)_hQ>6w@a-(u02P7
zaQ)#(uUl{HW%tYNS3ItC^iAtK(eKlL`f9+{bJzISE?u8_z3;~C8@FyI-5j_jy7l;W
z_U#vU3hqqYU3!mrul&B+{ptt$59)uk{;_4iZQ%G|z+lhASr6|H35TBkl>gI*;nGLU
zN7W-nBaM%pA0HbH8olyl&XeJ%vZoWz%6?Y=3DdFykl=3DimL}`%BMQ{Mhgd`HRoLu6e2R
za__6DuR6yg#~-}Tc|Gx_{H@O0eebyMy5GmWADJlpK>kqk(fVV@r_fLLKIeS?{4e)}
z^ZO;zpECde03c&XQcVB=3DdL;k=3DfP(-4`Tqa_faw4Lbua(`>R<o>I+y?e7jKeZ#YO-C
z3d~7FK~#9!?3>$f9Y-C<KfjsXvwIxdvE3LWNE)YYT1bIJ;HDH8QFuf=3D6j6Ar!bLm)
z5+Hb|`~|!Kk5GhoK}9V>LV|}jRVghfK*P1ot<I%}G<KZ$_+0if^W$OnIOjOWm!zp<
z!x?Ekd*<vOjX(4KU1oMxRF!_&STTJBeOP^1eOP^1eOUkZC0N-YB0Vp>^ozZdsvH72
zq{=3D~5MiiMunFK*qKm~=3DO*5Y?M+K(2syn@PElvnON^7o_L1(d2HEAy;QSaVPBnMC=3D=
z
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

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugi=
n.xml
index b809300..393121f 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -9,7 +9,7 @@
       <category name=3D"%Git_clone_category"
 	    id=3D"org.spearce.egit.ui.internal.clone.gitclonecategory"/>
       <wizard name=3D"%Git_clone_wizard"
-	    icon=3D"icons/etool16/import_wiz.gif"
+	    icon=3D"icons/obj16/import_obj.gif"
 	    class=3D"org.spearce.egit.ui.internal.clone.GitCloneWizard"
 	    id=3D"org.spearce.egit.ui.internal.clone.GitCloneWizard"
 	    category=3D"org.spearce.egit.ui.internal.clone.gitclonecategory">
@@ -19,7 +19,7 @@
=20
    <extension point=3D"org.eclipse.team.ui.configurationWizards">
       <wizard name=3D"%SharingWizard_name"
-            icon=3D"icons/sharing.gif"
+            icon=3D"icons/etool16/newconnect_wiz.gif"
             class=3D"org.spearce.egit.ui.internal.sharing.SharingWizar=
d"
             id=3D"org.spearce.egit.ui.internal.sharing.SharingWizard">
       </wizard>
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java b=
/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
index edeffaa..a906750 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/UIIcons.java
@@ -51,6 +51,9 @@ public class UIIcons {
 	/** Import Wizard banner */
 	public static final ImageDescriptor WIZBAN_IMPORT_REPO;
=20
+	/** Connect Wizard banner */
+	public static final ImageDescriptor WIZBAN_CONNECT_REPO;
+
 	private static final URL base;
=20
 	static {
@@ -63,7 +66,8 @@ public class UIIcons {
 		ELCL16_FIND =3D map("elcl16/find.gif");
 		ELCL16_NEXT =3D map("elcl16/next.gif");
 		ELCL16_PREVIOUS =3D map("elcl16/previous.gif");
-		WIZBAN_IMPORT_REPO =3D map("wizban/import.png");
+		WIZBAN_IMPORT_REPO =3D map("wizban/import_wiz.png");
+		WIZBAN_CONNECT_REPO =3D map("wizban/newconnect_wizban.png");
 		ELCL16_COMMIT =3D map("elcl16/commit.gif");
 		ELCL16_COMMENTS =3D map("elcl16/comment.gif");
 		ELCL16_AUTHOR =3D map("elcl16/author.gif");
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/shari=
ng/ExistingOrNewPage.java b/org.spearce.egit.ui/src/org/spearce/egit/ui=
/internal/sharing/ExistingOrNewPage.java
index d0ddcb7..b3ea769 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/Exis=
tingOrNewPage.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/sharing/Exis=
tingOrNewPage.java
@@ -15,6 +15,7 @@ import org.eclipse.swt.layout.RowLayout;
 import org.eclipse.swt.widgets.Button;
 import org.eclipse.swt.widgets.Composite;
 import org.eclipse.swt.widgets.Group;
+import org.spearce.egit.ui.UIIcons;
 import org.spearce.egit.ui.UIText;
=20
 class ExistingOrNewPage extends WizardPage {
@@ -25,6 +26,7 @@ class ExistingOrNewPage extends WizardPage {
 		super(ExistingOrNewPage.class.getName());
 		setTitle(UIText.ExistingOrNewPage_title);
 		setDescription(UIText.ExistingOrNewPage_description);
+		setImageDescriptor(UIIcons.WIZBAN_CONNECT_REPO);
 		myWizard =3D w;
 	}
=20
--=20
1.5.6.5
