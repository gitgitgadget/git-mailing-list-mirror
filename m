From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase max-pack-size?
Date: Sat, 12 May 2007 15:57:31 -0700
Message-ID: <7vmz09veec.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510705121325h65c62147h2b633fdddaece0be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 13 00:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn0Ww-0000FV-Rp
	for gcvg-git@gmane.org; Sun, 13 May 2007 00:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbXELW5d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 18:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbXELW5d
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 18:57:33 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43540 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998AbXELW5c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 18:57:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512225732.RZSE6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 18:57:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id yNxW1W00H1kojtg0000000; Sat, 12 May 2007 18:57:31 -0400
In-Reply-To: <56b7f5510705121325h65c62147h2b633fdddaece0be@mail.gmail.com>
	(Dana How's message of "Sat, 12 May 2007 13:25:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47104>

"Dana How" <danahow@gmail.com> writes:

> Since max-pack-size has appeared, and disappeard, in "pu" twice
> and never made it into "next",  I'm guessing I should rebase/merge it on
> top of the other recent pack-objects work.  I may get to this tonight;
> perhaps I'll send the patchset in one email with multiple attachments?

I am still holding onto the series on its own topic branch, but
merging it to 'pu' and resolving conflicts seem pointless while
I am (and hopefully the rest of the list ought to be ;-)
primarily concentrating on last-minute bugfixes in preparation
for v1.5.2.

A rebase to be queued in 'next' would be good, though.

Thanks.
