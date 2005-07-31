From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shipping gitk as part of core git.
Date: Sun, 31 Jul 2005 11:48:15 -0700
Message-ID: <7vpssyhkwg.fsf@assigned-by-dhcp.cox.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<7vy87o6htm.fsf@assigned-by-dhcp.cox.net>
	<7vk6j8yo0g.fsf_-_@assigned-by-dhcp.cox.net>
	<17132.48473.276198.835869@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 20:50:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzIsE-0002VP-1n
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 20:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVGaSs4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 14:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVGaSs4
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 14:48:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:42211 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261884AbVGaSsT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 14:48:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731184815.OFED16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 14:48:15 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17132.48473.276198.835869@cargo.ozlabs.ibm.com> (Paul Mackerras's message of "Sun, 31 Jul 2005 07:00:25 -0500")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> Yes, I agree.  I'm happy to send you an email when I have committed
> changes to gitk if that will help.

Please do not waste your time on that doing it regularly, but do
not hesitate to drop me a note if you have something newsworthy.
I always fetch from (not necessarily merge with) a couple of
repositories before starting my git day, in order to sanity
check the status of my private work repository.  Your repository
is among them, so I'll usually notice.

> He did ask me first, and I said he could :).  It makes things easier
> for me, having gitk in the core git, because it means that I don't
> have to worry about making a proper package out of it.  I don't see
> any reason why gitk would grow to be more than just the script.

Understood.  So let's keep the current arrangement.

> I am also thinking of doing a "gitool", somewhat like bk citool, to
> make it easier to create commits.  I guess we can decide later whether
> to make it part of the core git, although it seems more like porcelain
> than gitk.

Sounds like it.

-jc
