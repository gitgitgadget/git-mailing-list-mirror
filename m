From: rjtaylor@havocinspired.co.uk
Subject: Different Versions
Date: Thu, 24 Apr 2008 15:18:20 +0200
Message-ID: <899199.2868131209043100219.JavaMail.servlet@kundenserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 24 15:19:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jp1Lw-00006Q-D4
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 15:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbYDXNSW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Apr 2008 09:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbYDXNSV
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Apr 2008 09:18:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65030 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbYDXNSV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Apr 2008 09:18:21 -0400
Received: from pustefix160.kundenserver.de (pustefix160.kundenserver.de [172.23.4.27])
	by mrelayeu.kundenserver.de (node=mrelayeu6) with ESMTP (Nemesis)
	id 0ML29c-1Jp1LA0zK5-0008JN; Thu, 24 Apr 2008 15:18:20 +0200
X-Priority: 3
X-Binford: 6100 (more power)
X-Mailer: Webmail
X-Originating-From: 31900890
X-Routing: UK
X-Message-Id: <31900890$1209043100150172.23.4.2723296444@pustefix160.kundenserver.de--271784428>
X-Received: from pustefix160.kundenserver.de by 195.195.165.253 with HTTP id 31900890 for [git@vger.kernel.org]; Thu, 24 Apr 2008 15:18:20 CEST
X-Provags-ID: V01U2FsdGVkX1+mVjA8gmveR2kF5I9d3hEiJWJbQ17npJ9vQmo
 jM4hz3mla2BxdQrls+JwMq5lBxW/f9Kdaf1S9uL7p6tf243/zB
 luKkDmdm1ikvDttxvqzDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80304>

Hi,

=46irst post, hope this is going to the right place.

I=E2=80=99m in a fairly restricted situation were I have a Live Web Ser=
ver and a Dev Web Server. Now the Live box is running Ubuntu 7.04, and =
installs git version 1.4.* through apt-get. On the Dev box I=E2=80=99ve=
 got Ubuntu 7.10, and this installs git version 1.5.*.

Each seem to use slightly different commands, e.g. to initialise a repo=
sitory.=20

My question is am I ok to use git versions 1.4.* and 1.5.* together, or=
 am I going to have problems? Should I down great my Dev box to Ubuntu =
7.04 to get git version 1.4* so they are the same?

I can=E2=80=99t take down the Live box, or upgrade git on it, hence the=
 fairly restricted situation.

Any advice would be appreciated.

Regards

Ryan
