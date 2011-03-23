From: "Samy Louis" <Samy.seif@go-eknowledge.com>
Subject: duplicated Working tree
Date: Wed, 23 Mar 2011 13:03:15 +0200
Message-ID: <002701cbe949$e957f050$bc07d0f0$@go-eknowledge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:00:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2LnT-0007JL-LJ
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 12:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453Ab1CWLAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2011 07:00:08 -0400
Received: from out6.tedata.net.eg ([213.158.162.171]:45936 "EHLO
	out.tedata.net.eg" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932413Ab1CWLAH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2011 07:00:07 -0400
Received: (qmail 22519 invoked from network); 23 Mar 2011 11:00:05 -0000
Received: by simscan 1.4.0 ppid: 22485, pid: 22500, t: 5.5455s
         scanners: regex: 1.4.0 clamav: 0.96/m:52/d:11148 spam: 3.2.3
X-Spam-TE-Data-out-Scanned: Yes
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on SMTP-Out6
X-Spam-Status: No, score=3.2 required=10.0 tests=AWL,DNS_FROM_OPENWHOIS,
	RDNS_DYNAMIC autolearn=no version=3.2.3
Received: from host-213.158.171.58.tedata.net (HELO sls) (technology.know@[213.158.171.58])
          (envelope-sender <Samy.seif@go-eknowledge.com>)
          by out6.tedata.net.eg (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 23 Mar 2011 10:59:59 -0000
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AcvpSd/pNJ/9MHV5RIy7nm53Ck7p9g==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169816>


Hi,

I have a strange problem and need your support if possible.

When I clone a=A0 remote GIT repository (LAN) =A0to =A0local machine, =A0=
I get two
working=A0 folder one at the GIT local folder (normal) and the other in
=A0original path of where the remote repository had been created before=
 it was
cloned =A0to remote network.

How can I overcome this issue to only have one local working folder.


Step to =A0reproduce it:

1- Create a local GIT repo.=A0 (D:\repositoies\projectname)
2- Clone the GIT repo. to network path ( \\server\GIT\ projectname) use=
 a
bare flag.
3- Clone the remote repo ( \\server\GIT\ projectname) to other machine =
in
path (C:\GIT\projectname) and create working tree
4- We will fine two working tree one at C:\GIT\projectname and the othe=
r at
D:\repositoies\projectname.

Thanks in advance .

Regards
Samy Louis
