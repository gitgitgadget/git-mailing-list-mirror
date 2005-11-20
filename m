From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Rss produced by git is not valid xml?
Date: Sun, 20 Nov 2005 05:13:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511200512470.12306@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org>
 <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org>
 <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181520390.13959@g5.osdl.org>
 <7vek5deam6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511181653191.13959@g5.osdl.org>
 <7v7jb57wud.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511190950161.13959@g5.osdl.org>
 <Pine.LNX.4.63.0511200215480.11653@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0511191901560.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-1104060811-1132459991=:12306"
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 05:13:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdgZo-0007Z3-Fu
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 05:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVKTENN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 23:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVKTENN
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 23:13:13 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4243 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751176AbVKTENN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 23:13:13 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D2EEF140292; Sun, 20 Nov 2005 05:13:11 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B054E9F381; Sun, 20 Nov 2005 05:13:11 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9BA529D8EA; Sun, 20 Nov 2005 05:13:11 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 90D20140292; Sun, 20 Nov 2005 05:13:11 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511191901560.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12368>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-1104060811-1132459991=:12306
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 19 Nov 2005, Linus Torvalds wrote:

> (In Finnish/Swedish, the letter '=E4' is code \x00E4, which in UTF-8 is=
 the=20
> sequence \xA5\xC3. But you can't know if a text that has that sequence =
is=20
> UTF-8, or if it's a strange two-character latin1 sequence of "=C3=A5"=20
> (character codes \x00A5 and \x00C3).
>=20
> But I can pretty much guarantee that most any _sane_ latin1 text will=20
> obviously not be UTF-8, so in _practice_ you can definitely tell the tw=
o=20
> apart.

Thank you,
Dscho

---1148973799-1104060811-1132459991=:12306--
