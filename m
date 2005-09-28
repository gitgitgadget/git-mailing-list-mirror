From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use git-update-ref in scripts.
Date: Wed, 28 Sep 2005 11:28:29 -0700
Message-ID: <7vfyrprqr6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509251134480.3308@g5.osdl.org>
	<Pine.LNX.4.58.0509251153090.3308@g5.osdl.org>
	<7vpsqtykor.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509280819000.3308@g5.osdl.org>
	<7vek79w2ps.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509281007200.3308@g5.osdl.org>
	<7v3bnpt81e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509281106370.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 28 20:31:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKgfh-0005lq-VX
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 20:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVI1S2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Sep 2005 14:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbVI1S2b
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Sep 2005 14:28:31 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:26523 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750718AbVI1S2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2005 14:28:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050928182827.VQLB29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 28 Sep 2005 14:28:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509281106370.3308@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 28 Sep 2005 11:14:31 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9446>

Linus Torvalds <torvalds@osdl.org> writes:

> In many ways, the most irritating part for me about that is that an email 
> that wants to give a publically accessible part has to be something like
>
>    "Please pull from
>
>       rsync://rsync.kernel.org/path
>
>     to get the xyz updates"
>
> and then I cut-and-paste it but have to delete the "rsync://", and replace 
> the "rsync.kernel.org/" with "master.kernel.org:/". 
>
> Sad.

Hopefully that would be rectified when git-daemon goes on-line,
now I've merged updates from HPA ;-).
