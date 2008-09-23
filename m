From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [EGIT PATCH] Push and fetch icons for the toolbar
Date: Tue, 23 Sep 2008 22:19:19 +0200
Message-ID: <200809232219.20064.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_I9U2IGN8yvS7HeM"
Cc: Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Sep 23 22:21:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiEOP-0008Kb-Ct
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 22:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380AbYIWUUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 16:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752525AbYIWUUc
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 16:20:32 -0400
Received: from av12-2-sn2.hy.skanova.net ([81.228.8.186]:44031 "EHLO
	av12-2-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752380AbYIWUUb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 16:20:31 -0400
Received: by av12-2-sn2.hy.skanova.net (Postfix, from userid 502)
	id 68D9737F5A; Tue, 23 Sep 2008 22:20:28 +0200 (CEST)
Received: from smtp4-2-sn2.hy.skanova.net (smtp4-2-sn2.hy.skanova.net [81.228.8.93])
	by av12-2-sn2.hy.skanova.net (Postfix) with ESMTP
	id 6583E37ED4; Tue, 23 Sep 2008 22:20:20 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-2-sn2.hy.skanova.net (Postfix) with ESMTP id 15B9237E47;
	Tue, 23 Sep 2008 22:20:19 +0200 (CEST)
User-Agent: KMail/1.9.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96590>

--Boundary-00=_I9U2IGN8yvS7HeM
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---

PS. I attached the enabled versions of the icons just in case your email
reader doesn't display images from git binary patches. DS.

 org.spearce.egit.ui/icons/toolbar/fetchd.png |  Bin 0 -> 359 bytes
 org.spearce.egit.ui/icons/toolbar/fetche.png |  Bin 0 -> 393 bytes
 org.spearce.egit.ui/icons/toolbar/pushd.png  |  Bin 0 -> 372 bytes
 org.spearce.egit.ui/icons/toolbar/pushe.png  |  Bin 0 -> 404 bytes
 org.spearce.egit.ui/plugin.xml               |   32 ++++++++++++++-----------
 5 files changed, 18 insertions(+), 14 deletions(-)
 create mode 100644 org.spearce.egit.ui/icons/toolbar/fetchd.png
 create mode 100644 org.spearce.egit.ui/icons/toolbar/fetche.png
 create mode 100644 org.spearce.egit.ui/icons/toolbar/pushd.png
 create mode 100644 org.spearce.egit.ui/icons/toolbar/pushe.png

diff --git a/org.spearce.egit.ui/icons/toolbar/fetchd.png b/org.spearce.egit.ui/icons/toolbar/fetchd.png
new file mode 100644
index 0000000000000000000000000000000000000000..4433c543f2a52b586a3ed5e31b138244107bc239
GIT binary patch
literal 359
zcmV-t0hs=YP)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003lNkl<ZIE|%~
zF{;8q6h+U7BBn4qm_`dxuy6}@!NzsCfLTKp;5yPsN=p|I(rKe&p~M74Bq5ObRRW{%
zje4sYc=ybGk2gYV%`a+{hvjnl6{!Lo4hNJ{A44jDl#(C_K2BmJ09dV7A3>VW2}+n!
zO1rKr0DRxqm&=7b&q>piUayDaIKlvw2}+e_&-3(PFkmzq(Q380-|r+zg6Da9KA(#Q
zPa2QMl^Gz*GK3HmMPby1VQ9_(U^bf>W`H=3+3)uhMZxuY<#al++wJIfyXFi47K?>p
z2GCj~rNp*vI-L&fb{osGh@!|$@ci;S2_arv_(sil1xb<+1Odb0kjLY}`F!ShJaW6;
z>Lr*?r);;|7ihoV2SC*MjhoFzuh;A9KAB9aMXCk(Pk$Loi}X0uxcmSB002ovPDHLk
FV1lxPoI3yj

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/toolbar/fetche.png b/org.spearce.egit.ui/icons/toolbar/fetche.png
new file mode 100644
index 0000000000000000000000000000000000000000..0ffeb419e6ab302caa5e58661854b33853dc43dc
GIT binary patch
literal 393
zcmV;40e1e0P)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003{Nkl<ZIE|%}
z%Su8~6o$WjJd|h&)kLg8qatclklHDbhzOh%4SI>*L3{^aqJcvRqCsRQ6~SndH7ExK
zk=KcyE?#y6(aupYt$(ujUi|ChXYD1Vl>A3Z=W-tL|B2KE=%pm#uoxNA1!yxqxEMW&
zB>{jQO^yT+ogtn_{8Ep$Aq3h-C?o|y>g-6?-!e46K4}{7I2X6^?w$w$wKqXWo#uE<
zlN$@u$mIiCW0N$hIYc2#Jf_L5pe_`875HfeP>nhW1zLv1R!iSvNdTZ7`q(*62#YbV
zQhB;#V#z_Hl;tD;jPm%3!!_Fv=xqj&EpW_lqPo^m>_wFE9KxQ3t1@8v1#@h(gk?2k
zU%h_@BTD_vVB{6b=^Lij^3<ya#!DI7eU*yg9xg#(&qL<HX{n_QH=dOmU|OU>Dkk>j
n^=YB|UiI3T3toz$0fY1nZ1068v8@+b00000NkvXXu0mjfWwNMg

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/toolbar/pushd.png b/org.spearce.egit.ui/icons/toolbar/pushd.png
new file mode 100644
index 0000000000000000000000000000000000000000..22c3f7bf17b8b5a931c7527d768af13607b03bce
GIT binary patch
literal 372
zcmV-)0gL{LP)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV0003yNkl<ZIE|%~
zF{%PF6h%)&8w)Kgg)~~o6c%=-wG$iH;R0NP3veAG$Sh>A(?&%>K?5S92zkHxGyeyN
zQSnxRymxZ%OQJ-CZ<LQ0VHnEcaNzNHaJ${8)oOIRUG)l}M1;v?B8^6aVzEe}P~dX8
zV6A1h+tKg$Ga)&E`~8km3g?`+IiJs8M#ur2PA68Y70x-1$0OVAmgRCusZ@FoAR=h3
zDVNJsDix~LD)oBZD;$r<sngD7(Utm(zh18y4u?;WOu&C>t%;)O$w?l-T1yl~1VO;{
zdS$=gv)ODopU<8HfZ1#YAcMg`B@Q~B4vWRYJJDL}%|UCO8Yd6XZnu?)$aFeQidwCf
z_mE--u|}hjN&o=H7-fukIg4hqnKXNVchu|kh_lCf`xbzwX88RJ-{>O;Y5D>6^@Sy#
SDlMe|0000<MNUMnLSTZnn4{zX

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/icons/toolbar/pushe.png b/org.spearce.egit.ui/icons/toolbar/pushe.png
new file mode 100644
index 0000000000000000000000000000000000000000..1f99f0a702983d674f15eedae5f1218f0a30b5a0
GIT binary patch
literal 404
zcmV;F0c-w=P)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV00047Nkl<ZIE|%~
z%Su8~6o$WjJO~|4C>w|sG%6%VHSk(UL<B+v4SI>*L41dvA&3Z?G>L*BB*n0rWDTl8
zL8Pb?Jzc!)CSJ}#$rF8}#a?Uu`(JCbg_M&2pmu`H$+oP&=V*R^(bPY1%&ibu+ZV$G
zgp`tt<A@B;jw3Z6E&C{q>NBF4=c=f%6i@vsq5!CR9fSfc-IT0lZ>^0`E2vbS?r{1v
z8l^m+g%^~^H#FDePyq!%wm_SSqPmu`yJKk6QAXzdroz+R(7<gg074jZz1Vo3Dy2y#
zMW2W=)MJ~7I|%3fPE-KBpis_UGqzZuUe(cG%h>L#RCJHY0YK_74TR+C&ZX!&h^>3c
zJvdA^W^@l;f6eS*z&I*^D|{frVpE>&7273F76LY=;y1$BWF(Q0qALI}5jqkZAq&fh
y^_oorR)}l`>CE22@+$y+&Cvb}|KU##2Jr)k?t0Dap2#Es0000<MNUMnLSTZgH?cGT

literal 0
HcmV?d00001

diff --git a/org.spearce.egit.ui/plugin.xml b/org.spearce.egit.ui/plugin.xml
index 7c98688..ee8a5a0 100644
--- a/org.spearce.egit.ui/plugin.xml
+++ b/org.spearce.egit.ui/plugin.xml
@@ -272,22 +272,26 @@
         </separator>
 	    </menu>
 		<action
-		       class="org.spearce.egit.ui.internal.actions.FetchAction"
-		       id="org.spearce.egit.ui.actionfetch"
-		       label="%FetchAction_label"
-		       style="push"
-		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath="org.spearce.egit.ui"
-		       tooltip="%FetchAction_tooltip">
+        class="org.spearce.egit.ui.internal.actions.FetchAction"
+        disabledIcon="icons/toolbar/fetchd.png"
+        icon="icons/toolbar/fetche.png"
+        id="org.spearce.egit.ui.actionfetch"
+        label="%FetchAction_label"
+        menubarPath="org.spearce.egit.ui.gitmenu/repo"
+        style="push"
+        toolbarPath="org.spearce.egit.ui"
+        tooltip="%FetchAction_tooltip">
 		</action>
 		<action
-		       class="org.spearce.egit.ui.internal.actions.PushAction"
-		       id="org.spearce.egit.ui.actionpush"
-		       label="%PushAction_label"
-		       style="push"
-		       menubarPath="org.spearce.egit.ui.gitmenu/repo"
-		       toolbarPath="org.spearce.egit.ui"
-		       tooltip="%PushAction_tooltip">
+        class="org.spearce.egit.ui.internal.actions.PushAction"
+        disabledIcon="icons/toolbar/pushd.png"
+        icon="icons/toolbar/pushe.png"
+        id="org.spearce.egit.ui.actionpush"
+        label="%PushAction_label"
+        menubarPath="org.spearce.egit.ui.gitmenu/repo"
+        style="push"
+        toolbarPath="org.spearce.egit.ui"
+        tooltip="%PushAction_tooltip">
 		</action>
 		<action
 		       class="org.spearce.egit.ui.internal.actions.BranchAction"
-- 
1.6.0.1.310.gf789d0

--Boundary-00=_I9U2IGN8yvS7HeM
Content-Type: image/png;
  name="fetche.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="fetche.png"

iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABUElEQVQ4jaWSy0pCURSGv308lGgJ
1USsQaMialSQ2imQiAicFA16id5BfAdfooFDCaJBZCcVwWiSNSgHBZHXiZ4uXnYD0c5RMK1/svde
/OvjZ+0lpJT8R0rnch7x/4nUBeilJOGwGBnSBWgzPrgYPYklAYAeTY4EEZ0hnkf8Uo+2IQTaRygk
BUDq7EjW3zI0vz5pGu84F7fx7p4IALU3QUed5nhMkxsL08jlA1pjkzSqOUQhSzymya2gLhR6Ffhp
BlCNOggFWobFVkvfYkkAoB362DlOCIsxr1J5umNiyUGjlOUj/4zy+IrDNdsP6G0GkC1wzG+iutZR
7EWU8RzCnoWrMmD6BXNss4RlNWRfvX8GI0r9zWDkFcrpG6bW8tSrBsZLGdt9lYrhHi5BYM9D5sFp
qaUMN56VGmBapEEqJvbl9Wmh+1712pgLXoqhAYP0DWzvhSaxrRdZAAAAAElFTkSuQmCC

--Boundary-00=_I9U2IGN8yvS7HeM
Content-Type: image/png;
  name="pushe.png"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="pushe.png"

iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABW0lEQVQ4jaWTy0pCURSGv308CB1N
KBuIFTQqJEc18FpIRARCBA16id5BfIeeIYgImjSJgiAkxbCaZA2qQUGkqBM9XbzsJl7OQckTfaPF
Xmv9+19rs4WUkv+gdoLMybasv+dofn/R1D9wzK0QWNsXwwSElJKL44gMz44jNR8t+yiN6jOimOeq
qLAUT/0qogCoeh2EAi3dlKxlb62NUCuoVJ7ucPo0GqU8n4UXlMc3NNfkUAEFQLZAm4miupaxu2No
01FG5v2mwtPd0MBtKwBCGHO92HieKqVJJkWfiDLUY5uIOwjn/U5UAL2gUM5eM7ZYoF7V0V/L2O6r
VHSPyQFA6jANhOTqzqXoOoite8k9OEw3ZnQPXn/N7GDAOCqAK3wgwmJTnu0V2yVOFgI2puI3wthk
JJGQoisAMBE6EhshC8uI9ZpNAlaIbAXpzN7B8isAfc3Q/gv/4U8OBvEDiO56zeyeyCQAAAAASUVO
RK5CYII=

--Boundary-00=_I9U2IGN8yvS7HeM--
