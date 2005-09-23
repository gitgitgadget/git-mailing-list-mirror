From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT - breaking backward compatibility
Date: Thu, 22 Sep 2005 23:02:59 -0700
Message-ID: <7vfyrwjp7w.fsf@assigned-by-dhcp.cox.net>
References: <7vpsr4cx0f.fsf@assigned-by-dhcp.cox.net>
	<20050922144124.GJ21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 08:04:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIgez-0002JY-Bh
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 08:03:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbVIWGDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 02:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbVIWGDD
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 02:03:03 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59334 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751419AbVIWGDC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 02:03:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923060300.TWJE15799.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 02:03:00 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9158>

Petr Baudis <pasky@suse.cz> writes:

> Actually, could we please keep the old git-ssh-* stuff for a bit
> (perhaps a lot) longer?

Yeah, I think that's very sensible.  Thanks!

Updated the renames plan in the TODO document.
