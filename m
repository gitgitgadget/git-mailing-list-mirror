From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] detached HEAD -- finishing touches
Date: Thu, 01 Feb 2007 17:30:40 -0800
Message-ID: <7virelmjlr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0701311405430.3021@xanadu.home>
	<20070131231942.GB31145@coredump.intra.peff.net>
	<Pine.LNX.4.64.0701311907500.3021@xanadu.home>
	<20070201030030.GA1979@coredump.intra.peff.net>
	<7vd54ur26u.fsf@assigned-by-dhcp.cox.net>
	<7vlkjip7mu.fsf_-_@assigned-by-dhcp.cox.net>
	<20070201215242.GA1775@thunk.org>
	<7v64alnz2q.fsf@assigned-by-dhcp.cox.net>
	<87ejp99wn7.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Jeff King <peff@peff.net>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 02:30:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCnGH-0006gz-In
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 02:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423060AbXBBBam (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 20:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423061AbXBBBam
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 20:30:42 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:61921 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423060AbXBBBam (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 20:30:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070202013041.QMBF1302.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Feb 2007 20:30:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JRWg1W00g1kojtg0000000; Thu, 01 Feb 2007 20:30:41 -0500
In-Reply-To: <87ejp99wn7.wl%cworth@cworth.org> (Carl Worth's message of "Thu,
	01 Feb 2007 17:27:24 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38446>

Carl Worth <cworth@cworth.org> writes:

> And that's why I proposed a checkout away from detached head just
> printing the name of the commit that was being left.
>
> Is there any other precious information that that solution would not
> address?

I do not think of any offhand, but "did we make commit since we
detached HEAD" was not a suggestion I made, so what I can think
of does not matter much ;-).
