From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Sun, 06 Nov 2005 12:33:18 -0800
Message-ID: <7vr79twm7l.fsf@assigned-by-dhcp.cox.net>
References: <20051103014307.GA1988@pe.Belkin>
	<1131043869.10979.17.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 06 21:35:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYrCe-0000de-1f
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 21:33:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKFUdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 15:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVKFUdU
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 15:33:20 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:40364 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751199AbVKFUdT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 15:33:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051106203231.WRFL776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 6 Nov 2005 15:32:31 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1131043869.10979.17.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Thu, 03 Nov 2005 12:51:10 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11227>

Jon Loeliger <jdl@freescale.com> writes:

> On Wed, 2005-11-02 at 19:43, Chris Shoemaker wrote:
>
> ....  Also,
> I was annoyed that "git revert -n commit-name" created
> conflicts and the reversal and merges didn't happen
> for me cleanly even though they did for Junio.
>
> So either I don't get it, or it isn't working quite
> right these days.  Not sure.  Advice sought.

It's been a while since I used git-revert the last time.  I
should find time to run the examples myself.

> Reversing Commits
> -----------------
> While a goal of a revision control system is to record
> ...

The flow-chart based recipe is wonderful.
