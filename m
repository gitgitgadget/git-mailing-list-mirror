From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Bits from git-pb
Date: Sat, 30 Jul 2005 10:33:41 -0700
Message-ID: <7v8xzo42ru.fsf@assigned-by-dhcp.cox.net>
References: <20050729085819.GL24895@pasky.ji.cz>
	<20050730103103.GB26188@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 19:34:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyvEK-0004oc-J7
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 19:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbVG3ReR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 13:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263074AbVG3ReR
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 13:34:17 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14232 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S263075AbVG3Rdn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 13:33:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050730173341.GOLH3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 13:33:41 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050730103103.GB26188@pasky.ji.cz> (Petr Baudis's message of "Sat, 30 Jul 2005 12:31:04 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>>   (iii) Do wild things in the git-pb branch and send you patches.
>
> So I assume (iii) holds?

I have not answered this because I have not made up my mind.
Certainly (iii) is probably the least work for me.

My gut feeling is that I can deal with any of the above, but
even when I pull from your tree, I expect to pull into "pu"
first and after that the patches will go through my regular
reshuffling cycle just like other patches I receive from
e-mails.  This may or may not cause "interesting" troubles when
I merge again from git-pb, but we will see.
