From: Ben Clifford <benc@hawaga.org.uk>
Subject: why are gitweb 'description' and 'owner' stored in different ways?
Date: Sun, 18 Dec 2005 20:27:41 +0930
Message-ID: <C095FE37-2673-449D-AAB9-ADF042CE8F32@hawaga.org.uk>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=UTF-8;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 02:05:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo9Sr-0004P2-Fa
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 02:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030206AbVLSBFQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 18 Dec 2005 20:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030207AbVLSBFQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 20:05:16 -0500
Received: from mundungus.clifford.ac ([81.187.211.39]:2309 "EHLO
	mundungus.clifford.ac") by vger.kernel.org with ESMTP
	id S1030206AbVLSBFP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Dec 2005 20:05:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mundungus.clifford.ac (8.13.3/8.13.3) with ESMTP id jBJ11hQx026865;
	Mon, 19 Dec 2005 01:02:09 GMT
To: kay.sievers@vrfy.org
X-Mailer: Apple Mail (2.746.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13804>

Just wondering, is there a reason that gitweb stores the =20
'description' in one way (inside .git) and 'owner' in a different way =20
(in index.aux) ?

--=20
Ben =E2=80=A2 =E3=83=99=E3=83=B3 =E2=80=A2 =D0=91=D1=8D=D0=BD =E2=80=A2=
 =EB=B2=A4 =E2=80=A2 =E7=8F=AD=E6=98=8E
http://www.hawaga.org.uk/ben/
My email is high latency but best way to contact me. Alternatively, =20
SMS number(s) at above URL.
