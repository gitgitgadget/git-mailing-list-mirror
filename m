From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Improved three-way blob merging code
Date: Thu, 29 Jun 2006 11:21:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291118110.8615@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0606282157210.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 29 20:21:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw18V-0007jk-KR
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 20:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWF2SVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 14:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWF2SVD
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 14:21:03 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:26763 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751241AbWF2SVC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 14:21:02 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1DACF9> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 29 Jun 2006 11:21:01 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606282157210.12404@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22881>

On Wed, 28 Jun 2006, Linus Torvalds wrote:

> It would be lovely if libxdiff did a 3-way merge on its own, but this
> basically approximates it within that three_way_filemerge() function
> using external functionality.

This is my todo-list, that unfortunately is pretty crowded nowadays. I'll 
come graveling you main window once I have it ;)



- Davide
