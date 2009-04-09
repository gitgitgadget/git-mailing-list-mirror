From: "streamlake@tiscali.it" <streamlake@tiscali.it>
Subject: gitk error on cygwin
Date: Thu, 9 Apr 2009 09:29:14 +0200 (CEST)
Message-ID: <4019929.147451239262154071.JavaMail.defaultUser@defaultHost>
Reply-To: "streamlake@tiscali.it" <streamlake@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 09 10:14:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrpP4-0001Vo-48
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 10:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbZDIIM4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2009 04:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752701AbZDIIMz
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 04:12:55 -0400
Received: from mrqout3.tiscali.it ([195.130.225.13]:59144 "EHLO
	mrqout3.tiscali.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751853AbZDIIMy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2009 04:12:54 -0400
X-Greylist: delayed 2618 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2009 04:12:53 EDT
Received: from [10.39.115.27] 
	by mrq-3 with esmtp (Exim)
	id 1LrohG-0001xT-7K; Thu, 09 Apr 2009 09:29:14 +0200
Received: from ps22 (10.39.75.92) by mail-7-it.mail.tiscali.sys (8.0.022)
        id 49BE276A0007B47D for git@vger.kernel.org; Thu, 9 Apr 2009 09:29:14 +0200
xOriginalSenderIP: 79.38.58.205
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116146>

Hi,
While browsing revisions in gitk on a windows xp machine and cygwin=20
version (I tried both the packaged and a compiled one) I always find=20
tis error:

fatal: write failure on stdout: No such file or directory

fatal: write failure on stdout: No such file or directory
    while=20
executing
"close $bdf"
    (procedure "getblobdiffline" line 12)
   =20
invoked from within
"getblobdiffline file102f41f0=20
5978405b2bdf0c43c3b49427b0167eb31d433fe4"
    ("eval" body line 1)
   =20
invoked from within
"eval $script"
    (procedure "dorunq" line 11)
   =20
invoked from within
"dorunq"
    ("after" script)

After this gitk=20
becomes unstable and doesn't show diffs,
Thanks,
=46rank


Con Tutto Incluso chiami e navighi senza limiti e hai 4 mesi GRATIS.

L'attivazione del servizio =C3=A8 gratis e non paghi pi=C3=B9 Telecom!=20

L'offerta =C3=A8 valida solo se attivi entro il 09/04/09 http://abbonat=
i.tiscali.it/promo/tuttoincluso/
