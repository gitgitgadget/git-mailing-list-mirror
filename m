From: Manoj Srivastava <srivasta@ieee.org>
Subject: Re: [PATCH] Documentation: rename "hooks.txt" to "githooks.txt" and make it a man page
Date: Wed, 30 Apr 2008 11:28:31 -0500
Organization: Manoj Srivastava's Home
Message-ID: <87ej8ngvdc.fsf@anzu.internal.golden-gryphon.com>
References: <20080430080820.ef5a4c2a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 30 22:41:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrJ6z-0004pQ-1u
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 22:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932880AbYD3UkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 16:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759748AbYD3UkK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 16:40:10 -0400
Received: from main.gmane.org ([80.91.229.2]:46412 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758162AbYD3UkI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 16:40:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JrJ5u-0005Li-MI
	for git@vger.kernel.org; Wed, 30 Apr 2008 20:40:02 +0000
Received: from tiamat.golden-gryphon.com ([204.117.95.118])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 20:40:02 +0000
Received: from srivasta by tiamat.golden-gryphon.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 30 Apr 2008 20:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: tiamat.golden-gryphon.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux) (x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAACYAAAAwCAMAAABKbPgaAAAAM1BMVEUAAADIjH/0rp1KPz79
	0b+ic2nlpJc2Ly2AY17VlYb4uqi2gHQXFBN2WVXgno5iT02Xa2Nx+jaIAAACVElEQVQ4jeWU23bj
	IAxFLUAggQX6/6+dI9LGTpo+9mlYiXNhc3TnOP50naZE0tqvgEk+soutnNfQ8yPTWMTENhNrjI+Y
	+N7POVt8tAzpn2vJlsmttbyfrdkP7hx5iezteGzsbOts7xT+tC1mcG+LtRP2X/16bEQExuyx1uZW
	vscrAWUT8aE0aDBeBuw8nS5u4WgWyDCllOZUBeyWgbWbGrBsTDpTx0qpphlcYPcgJLvBXFClPMg5
	6WH2JidLIAaDF5aAed7uPTH4bjw0bZvfajp2tHc1F+cBm+Vr9YomGSwNhbmcczYEWUu5MBpYvCLV
	F+ZIKwQfYB+CBXnIRQFvIRhK6l96PemsFLEPFxi+MPxiTYH0Ave1InPsIYes3NJb42ytBSmmysyj
	lIQYHJm6Im1WbQ0kWMesKFRFPKTDzJ3GhWUn2KWKEkWlKthoACLm2eWJQQh2qKbAUgQxa+8TVjn1
	aySm8656ookCfCc5TRzvnZ6YOu3NpHg+uR5YuRkNF/b5IHq5Y7Ve6c2+sR4hqIZ3+5DCt3ukh8Eo
	vFIXVJxqfMdbkd/BF3YaQkB/2RIUHPMS7RLVAHefrYzWZVQ/ei4peBsROFLi90ltQyvF5I05t4Zs
	L4C9DODJ2AZCUf8UitGjCIdfx15QQkfZibTOGT3edxns5fY6F2rstKcTwiiaJnQwvYkdzTlaTqNH
	IkSmGdLrON45tGsMNDoSYr4bxH5emHEFaoFjKBahHXFXfLx9cR9p6ejJXihuxPz57gWHZkWovbPl
	9gsU8eImtBi++3D+f+sfT/Mg79fyEz8AAAAASUVORK5CYII=
X-URL: http://www.golden-gryphon.com/
Mail-Copies-To: never
X-Face: #q.#]5@vq!Jz+E0t_/;Y^gTjR\T^"B'fbeuVGiyKrvbfKJl!^e|e:iu(kJ6c|QYB57LP*|t
 &YlP~HF/=h:GA6o6W@I#deQL-%#.6]!z:6Cj0kd#4]>*D,|0djf'CVlXkI,>aV4\}?d_KEqsN{Nnt7
 78"OsbQ["56/!nisvyB/uA5Q.{)gm6?q.j71ww.>b9b]-sG8zNt%KkIa>xWg&1VcjZk[hBQ>]j~`Wq
 Xl,y1a!(>6`UM{~'X[Y_,Bv+}=L\SS*mA8=s;!=O`ja|@PEzb&i0}Qp,`Z\:6:OmRi*
Cancel-Lock: sha1:Wyj5lM/FfBo71RWZt0HZi/UoTXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80871>

Hi,

        The documentation patch says:
--- /dev/null
+++ b/Documentation/githooks.txt
@@ -0,0 +1,301 @@
 [snip]
+pre-applypatch
+--------------
+
+This hook is invoked by `git-am`.  It takes no parameter,
+and is invoked after the patch is applied, but before a commit
+is made.  Exiting with non-zero status causes the working tree
+after application of the patch not committed.

        I am afraid I can't parse the final sentence: I assume it means
 that the patched working tree is not committed, but the missing verb
 makes it harder for non-native speakers of the english language to
 understand what is meant here.

        manoj
-- 
Backed up the system lately?
Manoj Srivastava <srivasta@acm.org> <http://www.golden-gryphon.com/>  
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C
