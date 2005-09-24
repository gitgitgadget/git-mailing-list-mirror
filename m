From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 15:41:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509241540170.16554@localhost.localdomain>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
 <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
 <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 00:40:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJIgm-0000sM-5P
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 00:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbVIXWjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 18:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbVIXWjA
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 18:39:00 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:16775 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750777AbVIXWjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 18:39:00 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A0F5E> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 24 Sep 2005 15:39:52 -0700
X-X-Sender: davide@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509241524270.3308@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9254>

On Sat, 24 Sep 2005, Linus Torvalds wrote:

>
>
> On Sat, 24 Sep 2005, Davide Libenzi wrote:
>>
>> http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createhardlink.asp
>
> Don't you mean
>
> 	http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createsymboliclink.asp
>
> rather?
>
> It mentions longhorn.

Hah, didn't know this one. Requiring LongHorn is pretty strict though ;)


- Davide
