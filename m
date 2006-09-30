From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sat, 30 Sep 2006 00:31:18 -0700
Message-ID: <7vzmchhku0.fsf@assigned-by-dhcp.cox.net>
References: <7vodt0zbhc.fsf@assigned-by-dhcp.cox.net>
	<20060928093623.GJ20017@pasky.or.cz>
	<7vhcyrnn1g.fsf@assigned-by-dhcp.cox.net>
	<20060929083208.GL13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 09:31:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTZJj-00059I-LQ
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 09:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWI3HbV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Sep 2006 03:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWI3HbU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Sep 2006 03:31:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47012 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751107AbWI3HbU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Sep 2006 03:31:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930073119.VTXK2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Sep 2006 03:31:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UXXE1V00g1kojtg0000000
	Sat, 30 Sep 2006 03:31:15 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060929083208.GL13132@pasky.or.cz> (Petr Baudis's message of
	"Fri, 29 Sep 2006 10:32:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28142>

Petr Baudis <pasky@suse.cz> writes:

>> - - You can use git after building but without installing if you
>>...
>> -	export GIT_EXEC_PATH PATH GITPERLLIB
>> -
>>   - Git is reasonably self-sufficient, but does depend on a few external
>>     programs and libraries:
>
> The passage should be kept and even GITPERLLIB - just drop the second
> path after the colon.

Thanks.
