From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-gui: Improve the application icon on Windows.
Date: Tue, 27 Nov 2007 16:25:24 +0100
Message-ID: <1196177124-13601-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:26:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix2Jo-0000KG-92
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbXK0PZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbXK0PZ3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:25:29 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59692 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbXK0PZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:25:28 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1Ix2Il-0005KJ-7T; Tue, 27 Nov 2007 16:24:44 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C72276EF; Tue, 27 Nov 2007 16:25:24 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 9F724FA45; Tue, 27 Nov 2007 16:25:24 +0100 (CET)
X-Mailer: git-send-email 1.5.3.6.969.g3cdf46
X-Spam-Score: 2.3 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2, OBSCURED_EMAIL=2.1, UPPERCASE_25_50=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66229>

Previusly, there was only a 16x16 image, which looked very distorted.
Here we add a 32x32 version, and also make the image sharper.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	I'm by far not an artist, but improving the previous version
	was not difficult at all. ;)

	-- Hannes

 git-gui/lib/git-gui.ico |  Bin 318 -> 3638 bytes
 1 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/git-gui/lib/git-gui.ico b/git-gui/lib/git-gui.ico
index 563dd66238c1a5c169438fdb87ab797f6d19d1bc..334cfa5a1a59c320e86789ccf4ed3320584a0215 100644
GIT binary patch
literal 3638
zcmeH~ziSjh6vyA`iH8I(0ZDa`m_kiGRjLaq(go67oo?_yNF(H`v<gCCx)dr}*yJy`
zO2G`4Nn=2`A`k>G*c^D|`FXRq?%pQGAH+tom$y6b`)1zz?CjmnM5HD+WPV=K@v0$m
zpVstr=0Cb6@&WB3?mV`P)dYc~TThn@PF;e?-EMZ_OjCNjp7cKUWbpo_)a!L=G#WBB
zH6=4MGcr3nE3H;b78Vv{adA;PosO)nt;x#DiYzTHN%yhJ`nt+9IS~CE<?X>2IXFI+
zr?1~o$YCA}Sj=39=Fl9PGflHD9^IpRbdT=QZCF4L=m9672XrnH(Ia|9j|dT6@fBZV
zs_ZyB>N^rS202kl<vBSR91IQy2SY-F!NK5Qa4<L+5+)1|1_y(K!NHKwVQ?@w7#s`^
z2B&CnI5?bfsHPb};cB0NMGW0;85U1*Pa#iI4@;T`f}Vzl#lw=O1r85~hr`3+;Yd>j
zhljz#;9;<-^Kf_=JPeUq$~jFTb+QkBnqHe7sHh$2m8P270j5CFK!E^Lpmrb_ND`<W
zsGS~1s*O(lK>a{{dqjcyfw>7V1Q-JIV2_PiNq3LJm9srY<{(lp!WQ9()Ju=nIGBS7
zM>Gy@EIn=pMOY#%5r{~^^c8?5GBDC9B1BmD!^p!kiLgYQkHli%273x<FenTPgTkON
zC=BWA1Ve;DVNe(%45Y#64}-#>FenV9#?WC<7!(EtK&c-|rVLa%d2)Ds4~M4Q*2l{|
zc_AAc8?w2%DcjrIva_=z`}_N{x3?#Uhlg@>bR_+LUrtU=<n;7ZhQpx@zNtLl-Q{=O
zWp?d1U>EWw&+?k9a;G@%7Dpi#ts+XRkn`3=_<V;-xY{9wCsXB~T_?il+)SwU|5HCh
zqSCltb^LF~$G2J@U);brn3XAYG2Pss#Vv4Yyp-#2nyZzgnxhh4z3O<Dk5!~o&0O~X
zUEDI4k8)LOmt)qx>Ufs#qRiz=S0C3;H&uHz)oywvY@Ia+?a|z@J<31LR(q68+GkB^
ztJxDQKhj%e{5rArh)~&n5x0GcZC&QEe4nyh!@2P2vPU7nJ1t!})4blNuqLrYVb}YV
z>wOA)iT`z<k}ZxuUWoZxITnf)G83`|)0WiSr-4)P$HVAjfs}KcuzJbYz+A8T=+%W`
t!ne1#9r^goEBwpG59dS%O_BaP5&n&m{sZi`$XCqvauzc?+sdr!e+Q6k)cF7a

literal 318
zcmZ{aI}XAy5JV>uJ$7MQDAOPcghU60DUcAtknN#y8;J{W6>gFv&{A`PAPRmFV(kqb
zS!;GYZx%@SDW!O~kS0I}K+00A9xL#s+3xo6-ebNzqCY-kQB0do|8gSInpZISaEic)
zJMD~%z0r(_oRhmXtwN+BPw>r1oU&Pn^z+Qx2&}bP<Pz(?ngC@RxSfDI>yiW4F7RUZ
SE~I<%|8o#MxGM)hRp&1`Pe2d=

-- 
1.5.3.6.969.g3cdf46
