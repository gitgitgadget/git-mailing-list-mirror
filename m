From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Darcs
Date: Sun, 24 Jun 2007 15:22:51 -0700
Message-ID: <7vlke9ouv8.fsf@assigned-by-dhcp.cox.net>
References: <cecbdd220706232232w77a609faxf0e6b2dc37f0d1f4@mail.gmail.com>
	<alpine.LFD.0.98.0706241030540.3593@woody.linux-foundation.org>
	<46a038f90706241345m4b5ecb80p9f4ec840993023e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Bu Bacoo" <bubacoo@gmail.com>, git@vger.kernel.org
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 00:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2aTv-0003Wd-An
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 00:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXFXWWy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 18:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXFXWWy
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 18:22:54 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59618 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbXFXWWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 18:22:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070624222253.YRIZ1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Jun 2007 18:22:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id FaNs1X0041kojtg0000000; Sun, 24 Jun 2007 18:22:52 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50832>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

>> "Academic".
>
> OTOH, and from the POV of someone closely following the SCM tools in
> the last few years (and using almost all of them), darcs was the first
> usable DSCM in the camp. I am not sure how much of its commandline
> user interface was borrowed from BK or elsewhere, but darcs was
> _easy_, where Arch was extremely hard to use.

I second this.  Before I started contributing to git in its
early weeks, I staged my own changes to my day-job project in
darcs to trickle them in to the company's central repository (I
was sufficiently faster than other members of the project and I
had to pace myself). 

It would have been much more difficult for me to grasp the basic
concepts of how "distributed development" process works, if I
did not have an exposure to Darcs before I started, especially
because I never used BK.
