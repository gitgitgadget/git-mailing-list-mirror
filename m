From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Enable tree (directory) history display
Date: Fri, 30 Jun 2006 19:10:25 -0700
Message-ID: <7vy7vef52m.fsf@assigned-by-dhcp.cox.net>
References: <20060701010012.1559.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 04:10:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwUwT-0005cw-BZ
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 04:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbWGACK1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 22:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWGACK1
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 22:10:27 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:61614 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751192AbWGACK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 22:10:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701021026.XOOB19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 22:10:26 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060701010012.1559.qmail@web31809.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 30 Jun 2006 18:00:12 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23030>

Luben Tuikov <ltuikov@yahoo.com> writes:

> This patch allows history display of whole trees/directories a la
> "git-rev-list HEAD -- <dir or file>".  I find this useful especially
> when a project lives in its own subdirectory, as opposed to being all
> of the GIT repository (i.e. when a sub-project is merged into a
> super-project).

Both patches from you were seriously damaged.  Check your MUA
before sending further patches, please.

They were trivial for me to apply by hand, so no need to resend
them.  I like the effect of this one I am replying to very much.
