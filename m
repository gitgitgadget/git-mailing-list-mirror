From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove unused WITH_OWN_SUBPROCESS_PY from RPM spec
Date: Thu, 29 Mar 2007 13:21:12 -0700
Message-ID: <7vslbn3io7.fsf@assigned-by-dhcp.cox.net>
References: <20070329143703.GA17854@170.242.249.10.in-addr.arpa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 22:21:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX17U-0000wC-LN
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 22:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030673AbXC2UVO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 16:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030678AbXC2UVN
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 16:21:13 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:46544 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030673AbXC2UVN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 16:21:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329202112.KEQP28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 16:21:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gkMC1W0021kojtg0000000; Thu, 29 Mar 2007 16:21:12 -0400
In-Reply-To: <20070329143703.GA17854@170.242.249.10.in-addr.arpa> (Brian
	Gernhardt's message of "Thu, 29 Mar 2007 10:37:03 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43468>

Brian Gernhardt <benji@silverinsanity.com> writes:

> We don't have a copy of subprocess.py anymore, so we removed that
> option from the Makefile.  Let's not leave that cruft around the RPM
> spec file either.
> ---
>
> Resend of earlier patch, this time on top of 'master' instead of a
> random patch from the list.

Queued as a post-1.5.1 item, in 'pu' already.
