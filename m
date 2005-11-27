From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in master and pu (aka when will 1.0rc4 be out)
Date: Sun, 27 Nov 2005 13:08:38 -0800
Message-ID: <7v8xv9dcix.fsf@assigned-by-dhcp.cox.net>
References: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
	<7vek52e4ve.fsf@assigned-by-dhcp.cox.net>
	<20051127151134.0eac7019.tihirvon@gmail.com>
	<Pine.LNX.4.64.0511271106360.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 27 22:09:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgTlP-0001Oh-U7
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 22:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVK0VIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 16:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbVK0VIo
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 16:08:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:31994 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751154AbVK0VIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 16:08:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127210803.QRDK6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 16:08:03 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511271106360.13959@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 27 Nov 2005 11:32:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12824>

Linus Torvalds <torvalds@osdl.org> writes:

> The syntax is
>
> 	git bisect start <pathspec>
>
> followed by all the normal "git bisect good/bad" stuff.

I love how I can just say "this might be interesting" and 
find your message in my mailbox next morning [*1*] ;-).

This would be useful to cut down the number of bisection needed
to reach the culprit if the initial guess is correct as to which
part of the tree is involved.

[Reference]
*1* http://marc.theaimsgroup.com/?l=git&m=111669620826189
