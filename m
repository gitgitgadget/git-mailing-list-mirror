From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.5.2-rc3
Date: Fri, 11 May 2007 10:10:55 -0700
Message-ID: <7vr6pnb80w.fsf@assigned-by-dhcp.cox.net>
References: <7virb0gqdz.fsf@assigned-by-dhcp.cox.net>
	<200705111023.37676.litvinov2004@gmail.com>
	<7vtzukf0h6.fsf@assigned-by-dhcp.cox.net>
	<20070511090201.GC24971@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Fri May 11 19:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmYdx-0003hG-2V
	for gcvg-git@gmane.org; Fri, 11 May 2007 19:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759792AbXEKRK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 13:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759746AbXEKRK5
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 13:10:57 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:48268 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759602AbXEKRK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 13:10:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511171054.OIZY13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 13:10:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xtAv1W00E1kojtg0000000; Fri, 11 May 2007 13:10:55 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46967>

Martin Waitz <tali@admingilde.org> writes:

> Perhaps we should not advertise submodule support that prominently.
> I think we should wait for nice porcelain support before can put it at
> the top of the release announcements.

I understand your point, but I tend to disagree.

> Otherwise we get much too many expectations and too many questions about
> how to use it.

Actually, that is probably a good thing.

As we (including you, whose initial work was instrumental to
stir the discussion that led to the one by Linus) answer them
here, we will accumulate bodies of text that describe what can
be done today, what are missing, what needs to be recursive and
what approaches we can take in the Porcelains.  Somebody can
summarize and write documentation pages and to-do list out of
that.
