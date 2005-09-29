From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pull from one branch to another?
Date: Thu, 29 Sep 2005 00:06:53 -0700
Message-ID: <7vvf0kl5de.fsf@assigned-by-dhcp.cox.net>
References: <433B84BD.8030003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 09:08:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKsVP-0007AF-AT
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 09:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVI2HG4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 03:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbVI2HG4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 03:06:56 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:31107 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932105AbVI2HG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 03:06:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929070654.HRNB16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 03:06:54 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433B84BD.8030003@pobox.com> (Jeff Garzik's message of "Thu, 29
	Sep 2005 02:07:57 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9471>

Jeff Garzik <jgarzik@pobox.com> writes:

> ... It's been working for me, for months, but...

 ... will stop working as of Oct 1st? ;-)

> git-resolve-script HEAD $1 "`pwd` branch '$1'"

It is planned that we will stop installing *-script
compatibility symbolic links starting as of 0.99.8.
