From: Junio C Hamano <junkio@cox.net>
Subject: Re: trivial: retval of waitpid is not errno
Date: Fri, 06 Jan 2006 18:27:27 -0800
Message-ID: <7vzmm8pyb4.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0601050056p3b51ff7bt5c75802f6ba07092@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 07 03:27:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev3no-0004zw-Cy
	for gcvg-git@gmane.org; Sat, 07 Jan 2006 03:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965406AbWAGC13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 21:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965407AbWAGC13
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 21:27:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:24791 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965406AbWAGC12 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 21:27:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060107022624.WQGB6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 21:26:24 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601050056p3b51ff7bt5c75802f6ba07092@mail.gmail.com>
	(Alex Riesen's message of "Thu, 5 Jan 2006 09:56:37 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14236>

Thanks for all the trivial series.  Most of them applied as they
are, others I have already sent out comments.
