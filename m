From: Junio C Hamano <junkio@cox.net>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 14:39:34 -0800
Message-ID: <7vu0b1pntl.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	<87k6bxvmj6.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602141026570.3691@g5.osdl.org>
	<87fymlvgzv.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0602141224110.3691@g5.osdl.org>
	<87d5hpvc8p.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:39:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F98ph-0003Yt-3V
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 23:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422824AbWBNWjh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422849AbWBNWjh
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 17:39:37 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41119 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1422824AbWBNWjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 17:39:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214223758.ITSD20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 17:37:58 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87d5hpvc8p.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	14 Feb 2006 13:53:10 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16189>

Carl Worth <cworth@cworth.org> writes:

> You've pointed out that branches are free in terms of what git has to
> do. I'm saying that they're not free for the user who bears the cost
> of inventing a name. And in the case of any commit-while-seeking, it's
> at the time of the commit itself that the user has enough information
> to invent a useful name, not prior to seeking, (when the user is still
> trying to figure things out).

I think this is a very valid point and I am happy to accept a
workable proposal (does not have to be a working patch, but a
general semantics that covers most of if not all the corner
cases).
