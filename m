From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] documentation about exclude/ignore files
Date: Wed, 12 Jul 2006 21:40:57 -0700
Message-ID: <7vy7uyw206.fsf@assigned-by-dhcp.cox.net>
References: <E1G0knL-0007PL-86@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 06:41:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0t0l-0004Mo-AM
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 06:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932497AbWGMElA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 00:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbWGMElA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 00:41:00 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37511 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932497AbWGMEk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 00:40:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713044058.WUZH8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 00:40:58 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G0knL-0007PL-86@moooo.ath.cx> (Matthias Lederhofer's message
	of "Wed, 12 Jul 2006 21:54:51 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23811>

Matthias Lederhofer <matled@gmx.net> writes:

> ---
> Use .git/info/exclude in the example in git-ls-files.txt as .gitignore
> is used there and update the list of commands looking at
> .git/info/exclude in repository-layout.txt.
>
> ---
>  Documentation/git-ls-files.txt      |    4 ++--
>  Documentation/repository-layout.txt |    8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)

Why do you start the message with three dashes that says "the
below will _not_ go to the commit log message"?

The changes look good.  Please sign your patches.
