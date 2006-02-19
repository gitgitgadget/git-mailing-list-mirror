From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add a Documentation/git-tools.txt
Date: Sun, 19 Feb 2006 02:59:12 -0800
Message-ID: <7vlkw7iphb.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 19 11:59:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAmHi-0001B4-2U
	for gcvg-git@gmane.org; Sun, 19 Feb 2006 11:59:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWBSK7P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Feb 2006 05:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWBSK7P
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Feb 2006 05:59:15 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:663 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932293AbWBSK7O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Feb 2006 05:59:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060219105626.FBCA26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 19 Feb 2006 05:56:26 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550602190200j1ef3858as6a1564064dc81fef@mail.gmail.com>
	(Marco Costalba's message of "Sun, 19 Feb 2006 11:00:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16429>

"Marco Costalba" <mcostalba@gmail.com> writes:

> A brief survey of useful git tools, including third-party
> and external projects.
>
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>
> Please consider this more of a RFC  then a finished patch.
>
> Where possible, for each tool, the author's description is used as a summary.
> I found http://git.or.cz/ a good source.

Thanks for starting this.

Briefly mentioning tool's strength and weakness without being
too subjective would be very helpful to potential users.  We
would encourage competition without making other tools sound
inferiour on subjective terms.  So "this is similar to foobar
tool, but runs much faster, but has these limitations" would be
a good style, but "this draws much nicer picture than barboz"
without substantiating why it is nicer may be suboptimal.  Also
I am a bit afraid that the summary can become stale unless
maintained actively.  Hopefully the respective authors of tools
can keep us updated.

I am of two minds about mentioning things available from the git
repository, but I think it makes the survey more complete and
more useful in general to include them in the list.  The private
draft I sent out to you earlier forgot to include the foreign
SCM interfaces.
