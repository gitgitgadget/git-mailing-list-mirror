From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Update gitweb README: gitweb is now included with git
Date: Sat, 17 Jun 2006 08:57:02 +0200
Message-ID: <200606170857.02111.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Jun 17 08:57:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrUjt-0007Y9-IY
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 08:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWFQG46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Jun 2006 02:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWFQG46
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 02:56:58 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:4817 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932414AbWFQG45 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jun 2006 02:56:57 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1159108ugf
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 23:56:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=TzdejVjp7guVsH5EhCIqiMq3LRsZiSNlVV7+tabOo/uqP9C593Znu/6TOZAOtw0aq+HLYhuksfvuqs/GbKhcrUHHOR3v4kSe0AAOQMgSvFPMnN0qzacFmOk4M5rreByz6O0oF0+bFeXaSKMKiH96lF8i81iXvH1MUz3nPJd0yrs=
Received: by 10.67.106.3 with SMTP id i3mr91019ugm;
        Fri, 16 Jun 2006 23:56:56 -0700 (PDT)
Received: from roke.d-201 ( [193.0.122.19])
        by mx.gmail.com with ESMTP id q40sm4068478ugc.2006.06.16.23.56.55;
        Fri, 16 Jun 2006 23:56:55 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.6.2
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22006>

---
ftp://ftp.kernel.org/pub/software/scm/gitweb/=A0=A0and
http://www.kernel.org/pub/software/scm/gitweb/=A0are=A0empty.

http://www.kernel.org/git/?p=3Dgit/gitweb.git;a=3Dsummary
does=A0not=A0exist.


=A0gitweb/README=A0|=A0=A0=A0=A09=A0+--------
=A01=A0files=A0changed,=A01=A0insertions(+),=A08=A0deletions(-)

52fffe22be5fc02045ee630c755dab5713afb4fb
diff=A0--git=A0a/gitweb/README=A0b/gitweb/README
index=A03014d73..8d67276=A0100644
---=A0a/gitweb/README
+++=A0b/gitweb/README
@@=A0-3,14=A0+3,7=A0@@=A0GIT=A0web=A0Interface
=A0The=A0one=A0working=A0on:
=A0=A0=A0http://www.kernel.org/git/
=A0
-Get=A0the=A0gitweb.cgi=A0by=A0ftp:
-=A0=A0ftp://ftp.kernel.org/pub/software/scm/gitweb/
-
-It=A0reqires=A0the=A0git-core=A0binaries=A0installed=A0on=A0the=A0syst=
em:
-=A0=A0http://www.kernel.org/git/?p=3Dgit/git.git;a=3Dsummary
-
-The=A0gitweb=A0repository=A0is=A0here:
-=A0=A0http://www.kernel.org/git/?p=3Dgit/gitweb.git;a=3Dsummary
+From=A0the=A0git=A0version=A01.4.0=A0gitweb=A0is=A0bundled=A0with=A0gi=
t.
=A0
=A0Any=A0comment/question/concern=A0to:
=A0=A0=A0Kay=A0Sievers=A0<kay.sievers@vrfy.org>
--=A0
1.3.0
