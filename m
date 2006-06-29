From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: xdiff: generate "anti-diffs" aka what is common to two files
Date: Thu, 29 Jun 2006 11:18:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291117030.8615@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0606282149060.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 20:18:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw15y-0007Hx-D7
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:18:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWF2SSZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWF2SSZ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:18:25 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:25995 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751241AbWF2SSY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 14:18:24 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1DACF6> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 29 Jun 2006 11:18:03 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606282149060.12404@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22880>

On Wed, 28 Jun 2006, Linus Torvalds wrote:

> Davide, I say it's a "fairly trivial patch", but quite frankly, I'm
> winging it. I'm not that comfortable with the libxdiff internal workings,
> so while this seems to work for me and make sense, can you please take a
> quick look.

Looks fine to me.



- Davide
