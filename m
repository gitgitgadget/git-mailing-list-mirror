From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] git-pb git tree
Date: Tue, 10 May 2005 21:11:05 -0700
Message-ID: <7vfywuv1uu.fsf@assigned-by-dhcp.cox.net>
References: <20050511031613.GO26384@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed May 11 06:03:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DViRv-0004Uq-2C
	for gcvg-git@gmane.org; Wed, 11 May 2005 06:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVEKELM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 00:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVEKELM
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 00:11:12 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41372 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261742AbVEKELJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 00:11:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050511041106.KQFB26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 00:11:06 -0400
To: git@vger.kernel.org
In-Reply-To: <20050511031613.GO26384@pasky.ji.cz> (Petr Baudis's message of
 "Wed, 11 May 2005 05:16:13 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB>   Hello,
PB>   I've published the git-pb git tree. This is a purely "core GIT" tree,
PB>   ...
PB>   You get it as a Git tree at

PB> 	rsync://rsync.kernel.org/pub/scm/cogito/git-pb.git
PB> 	http://www.kernel.org/pub/scm/cogito/git-pb.git

Good, this is what I was waiting for.

Just in case people are wondering, all of what's there in the
current git-jc tree, except for one two liner documentation fix,
is already included in the git-pb tree, so there is no reason
for people other than Petr to pull from git-jc at this moment.


