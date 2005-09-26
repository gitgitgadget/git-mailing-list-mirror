From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git 0.99.7b doesn't build on Cygwin
Date: Sun, 25 Sep 2005 22:05:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0509252203510.817@localhost.localdomain>
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
 <Pine.LNX.4.63.0509241540170.16554@localhost.localdomain>
 <1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 07:04:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJl8z-0001T2-D4
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 07:03:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVIZFC6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 01:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVIZFC6
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 01:02:58 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:48015 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S932377AbVIZFC6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 01:02:58 -0400
X-AuthUser: davidel@xmailserver.org
Received: from debstar.dev.mdolabs.com
	by xmailserver.org with [XMail 1.22 ESMTP Server]
	id <S1A124E> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sun, 25 Sep 2005 22:03:59 -0700
X-X-Sender: davide@localhost.localdomain
To: Giuseppe Bilotta <bilotta78@hotpop.com>
In-Reply-To: <1o29so2d1zd0i$.1d0cf386vluxi.dlg@40tude.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9302>

On Sun, 25 Sep 2005, Giuseppe Bilotta wrote:

> However, it might be possible to use .lnk files, which would work on
> both NTFS and FAT32, and even under Win9x.

The .lnk files are a shell thing, not an OS one. Try to open()+read() a 
.lnk file and look at what you get ...


- Davide
