From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff: --abbrev option
Date: Sun, 18 Dec 2005 10:35:01 -0800
Message-ID: <7v4q56qmne.fsf@assigned-by-dhcp.cox.net>
References: <7v3bks12n6.fsf@assigned-by-dhcp.cox.net>
	<20051218001756.GS22159@pasky.or.cz>
	<7vek4byuwg.fsf@assigned-by-dhcp.cox.net>
	<20051218114522.GW22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 18 19:36:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eo3NS-0002mX-7n
	for gcvg-git@gmane.org; Sun, 18 Dec 2005 19:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbVLRSfE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Dec 2005 13:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVLRSfE
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Dec 2005 13:35:04 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:24282 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932700AbVLRSfC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2005 13:35:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051218183335.RLGW17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Dec 2005 13:33:35 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051218114522.GW22159@pasky.or.cz> (Petr Baudis's message of
	"Sun, 18 Dec 2005 12:45:22 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13798>

Petr Baudis <pasky@suse.cz> writes:

> Ok, that's nice! :-) And if I'm going to machine-process this later,
> I can just trim the trailing dots anyway. And it seems that I can give
> --abbrev a number argument to specify the minimal abbreviation, even
> cooler! :-)

Well, it is not for machine consumption to begin with anyway.
It is an optional toy ;-).
