From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 05 Feb 2006 17:32:52 -0800
Message-ID: <7vzml5b7az.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<20060205225116.GC24561@blinkenlights.visv.net>
	<7vwtg9cq0k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 06 02:33:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5vFb-0004i5-33
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 02:33:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWBFBcy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 20:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWBFBcy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 20:32:54 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6325 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750735AbWBFBcx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 20:32:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206013035.VGAH17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 20:30:35 -0500
To: git@vger.kernel.org
In-Reply-To: <7vwtg9cq0k.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 05 Feb 2006 16:03:23 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15648>

Junio C Hamano <junkio@cox.net> writes:

> To keep yourself up to date:
>
> 	$ git clone git://git.kernel.org/pub/scm/git master.git

Silly me.  This URL is wrong.

	$ git clone git://git.kernel.org/pub/scm/git/git master.git
