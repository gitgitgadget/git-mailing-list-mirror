From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Fri, 23 Feb 2007 12:08:30 -0800
Message-ID: <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 21:08:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKgib-0004wD-7f
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 21:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188AbXBWUIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 15:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933202AbXBWUIe
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 15:08:34 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41122 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933201AbXBWUIc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 15:08:32 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223200830.GKKN2670.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 15:08:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id T88W1W0121kojtg0000000; Fri, 23 Feb 2007 15:08:31 -0500
In-Reply-To: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Feb 2007 20:03:10 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40466>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	Do you want me to fold that back into the original patch?

The js/fetch-progress topic is now part of 'next' so I won't
rewind it.  Fix-up on top as you did is preferable.
