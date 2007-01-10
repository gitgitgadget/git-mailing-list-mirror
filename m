From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 00:02:51 -0800
Message-ID: <7vodp7e2c4.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<87ps9xgkjo.wl%cworth@cworth.org>
	<7virfprquo.fsf@assigned-by-dhcp.cox.net>
	<87odphgfzz.wl%cworth@cworth.org>
	<7vbql9ydd7.fsf@assigned-by-dhcp.cox.net>
	<20070108131735.GA2647@coredump.intra.peff.net>
	<7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
	<20070109142130.GA10633@coredump.intra.peff.net>
	<7virffkick.fsf@assigned-by-dhcp.cox.net>
	<20070109213117.GB25012@fieldses.org>
	<7vy7obj07k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701091539050.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 09:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4YQB-0005YA-Ou
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 09:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbXAJICx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 03:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbXAJICx
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 03:02:53 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:35552 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932619AbXAJICw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 03:02:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110080252.IDYO97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 03:02:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9L211W0041kojtg0000000; Wed, 10 Jan 2007 03:02:01 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701091539050.3594@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 9 Jan 2007 15:46:32 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36486>

Linus Torvalds <torvalds@osdl.org> writes:

> I'd love to see the detached HEAD series move into "master", but I do 
> think we should make sure that people can't drop their work easily by 
> mistake, and I think the above suggestion is both simple and workable.

I've done this, also added one fix and merged the topic to
"next".  I am hoping I can move this to "master" by the weekend.
