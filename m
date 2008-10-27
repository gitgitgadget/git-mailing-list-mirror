From: html-kurs@gmx.de
Subject: Fwd: Can't merge
Date: Mon, 27 Oct 2008 18:03:16 +0100
Message-ID: <20081027170316.217060@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 27 18:06:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuVW2-00046C-33
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 18:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbYJ0RDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Oct 2008 13:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYJ0RDU
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 13:03:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:39645 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246AbYJ0RDS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 13:03:18 -0400
Received: (qmail 7553 invoked by uid 0); 27 Oct 2008 17:03:16 -0000
Received: from 213.83.3.2 by www065.gmx.net with HTTP;
 Mon, 27 Oct 2008 18:03:16 +0100 (CET)
X-Authenticated: #4107867
X-Flags: 0001
X-Mailer: WWW-Mail 6100 (Global Message Exchange)
X-Priority: 3
X-Provags-ID: V01U2FsdGVkX1+rvCVPQ5er9JbaBu7Cb66Q/2GdbfSVwawzNalxbQ
 F9OMDFDx4TShzzQV56FccuwgLVB7TN7Z4IMQ== 
X-GMX-UID: YMY8cfxhYW0tRD/dX2Zpxx98amthc5u+
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99245>

I'm sorry. for the first mail.=20
The changes were all made in master ...
So what I wanted was
> git checkout foo
> git merge master=20

Anyone got a can of perri air for me ? ;-)

-------- Original-Nachricht --------
Datum: Mon, 27 Oct 2008 17:52:47 +0100
Von: html-kurs@gmx.de
An: git@vger.kernel.org
Betreff: Can\'t merge

Hi,

I've run in trouble when trying to merge a branch:
I've got a branch "foo".
I checkout master.
> git diff foo=20
shows many diffs.
But=20
> git merge foo
says:
Already up-to-date.

I'm using version 1.6.0.2

Any idea what I'm doing wrong?

TIA,
Martin

--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger

--=20
"Feel free" - 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
