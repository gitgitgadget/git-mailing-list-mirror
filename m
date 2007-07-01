From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a manual page for git-stash
Date: Sat, 30 Jun 2007 22:20:32 -0700
Message-ID: <7vabug8ztr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706300304480.4438@racer.site>
	<200706300539.l5U5dHLh003989@mi1.bluebottle.com>
	<Pine.LNX.4.64.0706301644190.4438@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 01 07:20:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4rrZ-0007eZ-49
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 07:20:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbXGAFUe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jul 2007 01:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbXGAFUe
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 01:20:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63726 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbXGAFUe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jul 2007 01:20:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701052034.WLO3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 01:20:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J5LY1X00L1kojtg0000000; Sun, 01 Jul 2007 01:20:33 -0400
In-Reply-To: <Pine.LNX.4.64.0706301644190.4438@racer.site> (Johannes
	Schindelin's message of "Sat, 30 Jun 2007 16:44:39 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51274>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Documentation/git-stash.txt |  116 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 116 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/git-stash.txt

By the way, whoever does the documentation needs to list it in
the command list (Documentation/cmd-list.perl).
