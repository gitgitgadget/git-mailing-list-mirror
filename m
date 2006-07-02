From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: add --full-history to history generation optimization
Date: Sat, 01 Jul 2006 22:22:33 -0700
Message-ID: <7vu060bmxy.fsf@assigned-by-dhcp.cox.net>
References: <20060702044206.75887.qmail@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 02 07:22:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwuPl-00010w-ON
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 07:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWGBFWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 01:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWGBFWf
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 01:22:35 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:10689 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932143AbWGBFWe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 01:22:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702052234.CPKO27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 01:22:34 -0400
To: ltuikov@yahoo.com
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23093>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Now that Linus fixed full history generation, we can
> add this to the optimized history generation.

Thanks.  I believe I have the same change in "next" already, but
I had to munge your patches by hand so please holler if there is
any mistake on my part.
