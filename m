From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach mailsplit about Maildir's
Date: Sun, 20 May 2007 11:36:25 -0700
Message-ID: <7v7ir3mjfa.fsf@assigned-by-dhcp.cox.net>
References: <20070520181447.GA10638@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Sun May 20 20:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpqGc-0003v1-ES
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583AbXETSg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759359AbXETSg1
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:36:27 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:56383 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727AbXETSg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:36:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520183625.BJLK13995.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 20 May 2007 14:36:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 1WcR1X00D1kojtg0000000; Sun, 20 May 2007 14:36:25 -0400
In-Reply-To: <20070520181447.GA10638@ferdyx.org> (Fernando J. Pereda's message
	of "Sun, 20 May 2007 20:14:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47882>

"Fernando J. Pereda" <ferdy@gentoo.org> writes:

> Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
> ---
>
> 	I never got ACK or NACK when I sent it the first time, that's why
> 	I'm resending this one with (almost) no changes.

Sorry, I had a (n obviously false) impression that you retracted
this patch due to this:

> ...
> +IMPORTANT: Maildir splitting relies upon filenames being sorted to output
> +patches in the correct order.

I am sure there are many users who uses Maildir layout on this
list.  Happy with this patch?  Please speak out.
