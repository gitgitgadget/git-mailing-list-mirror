From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix snapshot link in tree view
Date: Fri, 22 Sep 2006 17:44:34 -0700
Message-ID: <7virjfxvgt.fsf@assigned-by-dhcp.cox.net>
References: <20060922232120.596.63045.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 02:44:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQvdI-0005Iz-Am
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 02:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbWIWAoi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 20:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWIWAoh
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 20:44:37 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:64209 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964984AbWIWAof (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 20:44:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923004434.GCHK21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 20:44:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Rckc1V00A1kojtg0000000
	Fri, 22 Sep 2006 20:44:36 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27547>

Petr Baudis <pasky@suse.cz> writes:

> It would just give HEAD snapshot instead of one of the particular tree.
>
> Perhaps we should also include snapshot in the global navbar? And perhaps
> stgit should have a way to edit the mail before sending it so that I could
> note this below the three dashes? ;-)

Personally, I do not mind having the first "Perhaps" in the log
message.

Will apply.
