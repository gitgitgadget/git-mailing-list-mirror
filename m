From: Ben Clifford <benc@hawaga.org.uk>
Subject: gitk - ewww
Date: Sun, 4 Dec 2005 12:27:06 +1100
Message-ID: <6CC092B0-101F-4D98-9761-B4E24A7CA35A@hawaga.org.uk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sun Dec 04 04:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eikxp-00088t-ES
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 04:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbVLDDyq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 3 Dec 2005 22:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVLDDyp
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 22:54:45 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:27919 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1751307AbVLDDyp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Dec 2005 22:54:45 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jB43qRQg023927;
	Sun, 4 Dec 2005 03:54:15 GMT
To: Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13173>

Here's a screen shot that surprised me with a really high 'ewwww' =20
factor when I fired up gitk this morning on my local git repo, given =20
that it looks pretty the rest of the time.

This repo tracking git master with just one extra commit that I've =20
added and rebase off origin repeatedly.

The area around where the 'master' green tag is displayed =20
(specifically the two lines below it) are surprisingly poor.

I'm not going to learn tcl/tk and how gitk works to investigate, =20
though, but maybe someone else cares enough and/or can see a trivial =20
fix...

Screen shot is at:
http://www/hawaga.org.uk/ben/tech/gitk-eww-1.png

If trying to recreate, e011472b550b27a4644403c6fa99543ee9004a63 is =20
only on my local machine, but I can supply a copy of my tree too.


$ cg status
Heads:
    >master      e011472b550b27a4644403c6fa99543ee9004a63
   R origin      56b5e946f2ba4fd57bbe14f9e3ec2e0ae314d5e6


--=20
Ben =E2=80=A2 =E3=83=99=E3=83=B3 =E2=80=A2 =D0=91=D1=8D=D0=BD =E2=80=A2=
 =EB=B2=A4 =E2=80=A2 =E7=8F=AD=E6=98=8E
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
