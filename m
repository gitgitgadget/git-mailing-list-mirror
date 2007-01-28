From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] user-manual: set user.name and user.email with repo-config
Date: Sat, 27 Jan 2007 18:04:35 -0800
Message-ID: <7vodojhpos.fsf@assigned-by-dhcp.cox.net>
References: <20070127062826.GE14205@fieldses.org>
	<20070128002246.GA10179@moooo.ath.cx>
	<Pine.LNX.4.64.0701271625120.25027@woody.linux-foundation.org>
	<20070128013452.GA11244@moooo.ath.cx>
	<Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 03:04:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAzPT-0002so-K0
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 03:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbXA1CEi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 21:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbXA1CEi
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 21:04:38 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:37561 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112AbXA1CEh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 21:04:37 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128020436.RRWV25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 21:04:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GS3e1W0011kojtg0000000; Sat, 27 Jan 2007 21:03:38 -0500
In-Reply-To: <Pine.LNX.4.64.0701271745000.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 27 Jan 2007 17:47:49 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38011>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> What would also mean that we'd have the man-page with a simple
>
> 	man git-config
>
> which makes tons of sense if it documents both the config file *and* the 
> "git config" program.
>
> Or is that too sneaky?

I like that.

If the solution can help us deprecate and eventually remove
git-var that would be ultra-nice.
