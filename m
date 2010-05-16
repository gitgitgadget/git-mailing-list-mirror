From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [ANNOUNCE] diffit - A git plugin for vim
Date: Sun, 16 May 2010 11:12:37 +0200
Message-ID: <514EDDA1-E8A4-45CD-ACF5-F7FE18CABD4F@wincent.com>
References: <20100515105009.GA10517@localhost>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun May 16 12:13:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODar4-0001J6-Px
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 12:13:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218Ab0EPKNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 06:13:48 -0400
Received: from outmail148099.authsmtp.net ([62.13.148.99]:52189 "EHLO
	outmail148099.authsmtp.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754214Ab0EPKNq convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 06:13:46 -0400
X-Greylist: delayed 3657 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2010 06:13:46 EDT
Received: from mail-c194.authsmtp.com (mail-c194.authsmtp.com [62.13.128.121])
	by punt2.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id o4G9Ch5o010422;
	Sun, 16 May 2010 09:12:43 GMT
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id o4G9Cfpj077950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 16 May 2010 10:12:42 +0100 (BST)
Received: from [192.168.1.6] (175.Red-88-3-72.dynamicIP.rima-tde.net [88.3.72.175])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id o4G9CcWw017517
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 16 May 2010 05:12:40 -0400
In-Reply-To: <20100515105009.GA10517@localhost>
X-Mailer: Apple Mail (2.1078)
X-Server-Quench: 2f4c0348-60cb-11df-80b9-0022640b883e
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH axgdC1NCdwdEHAkR AmYBWlZeVF4/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwNEHJhckpB XB4ZVRB3d0tCeHtw K0Q0WiNbX0ByaEB9 ERxJFGxSM3poaDIW TUBYdQFSdAMYdhdG Px4dAXkdChR5GAUF OSQeCng9PDtRKTgd B0kkZV0TXQ4TGiMz RhZKEzI1VVMEQk0A 
X-Authentic-SMTP: 61633436303433.1015:706/Kp
X-AuthFastPath: 0 (Was 255)
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147180>

El 15/05/2010, a las 12:50, Clemens Buchacher escribi=F3:

> Hi,
>=20
> I am currently working on a git plugin for vim. My aim is for it to i=
mitate
> much of git-gui's functionality. Right now, it is still closer to "ad=
d -p".
>=20
> But I believe it's already useful. And since I'm new to vim scripting=
, it
> can use some testing.

Clemens, were you aware that there are already a couple of Git plug-ins=
 for Vim? Of these, the most advanced one currently is almost certainly=
 Fugitive:

http://github.com/tpope/vim-fugitive

Cheers,
Wincent
