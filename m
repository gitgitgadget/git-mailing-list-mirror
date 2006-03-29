From: =?ISO-8859-1?B?U+liYXN0aWVu?= Pierre <sebastien@xprima.com>
Subject: Git terminology
Date: Wed, 29 Mar 2006 05:21:13 -0500
Organization: XPRima Corp.
Message-ID: <20060329052113.6a773480.sebastien@xprima.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Wed Mar 29 17:22:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOcUf-0004b8-95
	for gcvg-git@gmane.org; Wed, 29 Mar 2006 17:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWC2PVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Mar 2006 10:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWC2PVp
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 10:21:45 -0500
Received: from ritalin.autolinq.com ([207.96.225.42]:13549 "HELO
	ritalin.autolinq.com") by vger.kernel.org with SMTP
	id S1751171AbWC2PVo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Mar 2006 10:21:44 -0500
Received: (qmail-ldap/ctrl 5710 invoked from network); 29 Mar 2006 15:21:43 -0000
Received: from unknown (HELO localhost.localdomain) ([207.96.159.2]) (envelope-sender <sebastien@xprima.com>)
          by ritalin.autolinq.com (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 29 Mar 2006 15:21:43 -0000
To: Git ML <git@vger.kernel.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.16; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18173>

Hi all,

In the process of learning git, and browsing the docs, I realized that =
many particular terms are used, but I had difficulties finding their de=
finitions.=20

Among those I found a bit arcane, there are (in no particular order) "r=
efspec", "rebase", "rewound", "pickaxe", "refnames", "objectnames" ,"re=
fnames", "fast-forward update".

Also, doing a "grep -rohE '<[a-z\-]+>' * | sort | uniq" in git source t=
ree gave me the list of "parameter types" for git commands, where some =
would benefit from a formal definition : <base>, <blob>, <branch>, <bra=
nchname>, <comitish>, <tree>, <tree-ish>, <head>, <headsha>, <refspec>,=
 and so on. Of course, some of these terms are already explained in the=
 man pages, but it would be nice to have a "git terminlogy reference".

If some of you are willing to detail/explain/define those terms (and so=
me others not mentioned here), I would be glad to collect the definitio=
ns and make a "git terminology" document.

 -- S=E9bastien
