From: Junio C Hamano <junkio@cox.net>
Subject: Re: [patch] list shortlog items in commit order
Date: Tue, 02 Aug 2005 15:34:53 -0700
Message-ID: <7vvf2oklwy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508021713230.15300@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 00:36:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E05MC-0007lp-Ey
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 00:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVHBWfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Aug 2005 18:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVHBWfW
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Aug 2005 18:35:22 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:8635 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261457AbVHBWfU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2005 18:35:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050802223453.LVQS3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 Aug 2005 18:34:53 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.63.0508021713230.15300@localhost.localdomain>
	(Nicolas Pitre's message of "Tue, 02 Aug 2005 17:18:57 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
cc: Linus Torvalds <torvalds@ppc970.osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> The current shortlog list is backward making it look odd.
> This reverses it so things appear more logically.

Sorry, I do not know how the shortlog looked like in BK days,
but it would be nice to match that order.  I do not have
preference either way myself.

I'll let it simmer and let the list decide, but I think the
kernel folks care the most about this one, so I am asking the
original authors, Linus and Jeff, if they want to go for it, or
veto it.
