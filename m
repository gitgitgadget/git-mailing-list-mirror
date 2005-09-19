From: Junio C Hamano <junkio@cox.net>
Subject: Re: Ugly merge messages
Date: Sun, 18 Sep 2005 17:12:57 -0700
Message-ID: <7vd5n5zzhy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509181649390.9106@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 02:13:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH9HO-00011o-Gp
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 02:13:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVISAM7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 20:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVISAM7
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 20:12:59 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:11990 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932276AbVISAM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2005 20:12:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919001258.JOFG29184.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 18 Sep 2005 20:12:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509181649390.9106@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 18 Sep 2005 17:05:18 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8823>

Linus Torvalds <torvalds@osdl.org> writes:

>  your merge messages are pretty ugly.

Sorry, I've been using what have been in "pu" branch for some
time but this time around I used what is in the master (and
0.99.7).   Post-0.99.7 one produces a single liner for an
Octopus.  I think it makes sense as you suggest to say just
branch names of what are merged when we know they come from
local.
