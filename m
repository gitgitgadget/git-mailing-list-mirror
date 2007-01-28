From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Sun, 28 Jan 2007 11:18:08 -0800
Message-ID: <7vveirdkpb.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
	<20070127080126.GC9966@spearce.org>
	<Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org>
	<Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org>
	<7vzm84gmei.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org>
	<7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jan 28 20:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBFXa-0005RZ-Kn
	for gcvg-git@gmane.org; Sun, 28 Jan 2007 20:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932754AbXA1TSL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 Jan 2007 14:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbXA1TSL
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jan 2007 14:18:11 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:36969 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754AbXA1TSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jan 2007 14:18:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070128191809.INSJ19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 28 Jan 2007 14:18:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GjHA1W00h1kojtg0000000; Sun, 28 Jan 2007 14:17:11 -0500
In-Reply-To: <Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 28 Jan 2007 11:08:06 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38041>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 28 Jan 2007, Junio C Hamano wrote:
>> 
>> I think it is sensible to do the attached on top of your patch.
>
> Ack.
>
> I see you committed this, which is nice, but now Shawn's butt-ugly thing 
> doesn't work any more, and my mad perl skillz are sadly lacking.

Do you mean the perl-Gtk one by Jeff King?

I was hoping to take a look at Shawn's git-gui and also perhaps
looking into adding blame --incremental support to gitk myself
when I have time, but unfortunately my day-job deadline is
spilling into this weekend.
