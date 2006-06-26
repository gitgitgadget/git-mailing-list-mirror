From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: Support for perl/ being built by a different compiler
Date: Mon, 26 Jun 2006 02:26:43 -0700
Message-ID: <7vmzc0i7xo.fsf@assigned-by-dhcp.cox.net>
References: <20060625014703.29304.12715.stgit@machine.or.cz>
	<7vk676orjy.fsf@assigned-by-dhcp.cox.net>
	<20060626082428.G52c9608e@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 26 11:27:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FunMm-0004VW-HI
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 11:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWFZJ0p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 05:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWFZJ0p
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 05:26:45 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:21221 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964951AbWFZJ0p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 05:26:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060626092644.ZTJQ19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Jun 2006 05:26:44 -0400
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060626082428.G52c9608e@leonov.stosberg.net> (Dennis Stosberg's
	message of "Mon, 26 Jun 2006 10:24:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22669>

Dennis Stosberg <dennis@stosberg.net> writes:

> Yesterday I could build the next branch with Sun CC 5.8 with a few
> trivial changes.  I will send four patches in reply to this mail.

Thanks.  Next time around please sign off your patches.
