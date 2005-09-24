From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 15:26:02 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
 <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 00:26:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJITf-0005qJ-6I
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 00:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVIXW0K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 18:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbVIXW0K
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 18:26:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15330 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750772AbVIXW0J (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 18:26:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8OMQ34s028212
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Sep 2005 15:26:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8OMQ2Pl027390;
	Sat, 24 Sep 2005 15:26:03 -0700
To: Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.118 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9252>



On Sat, 24 Sep 2005, Davide Libenzi wrote:
> 
> http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createhardlink.asp

Don't you mean

	http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createsymboliclink.asp

rather?

It mentions longhorn.

		Linus
