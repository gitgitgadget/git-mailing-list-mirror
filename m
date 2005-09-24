From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sat, 24 Sep 2005 14:28:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509241426240.16554@localhost.localdomain>
References: <ud5mznc1x.fsf@peter-b.co.uk>
 <Pine.LNX.4.63.0509231537390.11109@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231647300.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509240305450.26220@wgmdd8.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.58.0509231935360.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509232220330.30718@localhost.localdomain>
 <Pine.LNX.4.58.0509241102450.3308@g5.osdl.org>
 <Pine.LNX.4.63.0509241129300.31327@localhost.localdomain>
 <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 23:27:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJHX1-0003gL-1s
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 23:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbVIXVZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 17:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVIXVZt
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 17:25:49 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:60294 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750762AbVIXVZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2005 17:25:49 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A0F44> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 24 Sep 2005 14:26:57 -0700
X-X-Sender: davide@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr2iw6l3.fsf@assigned-by-dhcp.cox.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9246>

On Sat, 24 Sep 2005, Junio C Hamano wrote:

> Making really really core part usable on Windows would not need
> this, but there is another thing: .git/HEAD symlink.

Starting from Win2k, they *finally* added:

http://msdn.microsoft.com/library/default.asp?url=/library/en-us/fileio/fs/createhardlink.asp



- Davide
