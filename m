From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Thu, 11 Aug 2005 15:21:51 -0700
Message-ID: <7v3bpgglmo.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508110915210.3295@g5.osdl.org>
	<7vfytgl25g.fsf@assigned-by-dhcp.cox.net>
	<200508111745.49128.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 00:23:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3LQy-0002G7-4Z
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 00:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbVHKWVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 18:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVHKWVx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 18:21:53 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:56251 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932498AbVHKWVx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 18:21:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811222150.HHGI3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 18:21:50 -0400
To: Gene Heskett <gene.heskett@verizon.net>
In-Reply-To: <200508111745.49128.gene.heskett@verizon.net> (Gene Heskett's
	message of "Thu, 11 Aug 2005 17:45:48 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> writes:

>>    rank  name            inst    vote     old recent
>>    6591  git              114      24      83      7
>>    25555 git-core           2       1       0      1 (Not in sid)
>>    29939 cogito-scm         1       0       1      0 (Not in sid)
>
> This obviously is not even a fair assesment of the potential
> popularity of this new kernel package admin tool.  By holding to this
> attitude, you will surely alienate linux users away from debian.

> If so far, only 114 people out of the 7147 who were kind enough to
> fill out a questionaire have installed the debian 'git' and 24 report
> that they are using this tool, then obviously once a stable release of
> the Linus version of git has been achieved, the user count of the new
> tool will handily exceed the user count of the older and totally
> different toolkit from gnu.  This will occur within 24 hours of a
> working, stable release of the Linus git.  Possibly aleady has
> occured, I have it (the rpm) here already.

I suspect you are confused.  The entry "git" in above table is
the GNU interactive tools and comment about 114/7147 ratio is
about GNU interactive tools, not our GIT.  Ours are "git-core"
and "cogito-scm", marked as "Not in sid".  I do not understand
why you think my attitude would alienate users away from debian.

As you say, when it is included in the official archive, I
expect our numbers would exceed "the other GIT" very quickly.
