From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Tue, 26 Sep 2006 18:34:53 -0700
Message-ID: <7vk63qnlc2.fsf@assigned-by-dhcp.cox.net>
References: <20060926233321.GA17084@coredump.intra.peff.net>
	<20060927002745. 15344.qmail@web51005.mail.yahoo.com>
	<BAYC1-PASMTP084ACE9B12C54DABFE8EB9AE1A0@CEZ.ICE>
	<20060926205632.5d487cc9.seanlkml@sympatico.ca>
	<Pine.LNX.4.63.0609261746160.22495@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 03:35:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSOKB-0007gi-DM
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 03:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWI0Bez (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 21:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWI0Bez
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 21:34:55 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45702 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932226AbWI0Bey (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 21:34:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060927013454.UOJI18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 21:34:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id TDar1V0031kojtg0000000
	Tue, 26 Sep 2006 21:34:51 -0400
To: David Lang <dlang@digitalinsight.com>
In-Reply-To: <Pine.LNX.4.63.0609261746160.22495@qynat.qvtvafvgr.pbz> (David
	Lang's message of "Tue, 26 Sep 2006 17:47:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27846>

David Lang <dlang@digitalinsight.com> writes:

>> You are right that a "Merged Date:" in gitweb would be useful information to
>> show for each commit, but it's not straightforward given the design of git.
>
> would it?
>
> remember that a pach could be merged to many trees in any order. which
> merge date do you want to know about?

The date that repository I am looking at with gitweb first had
that commit, of course.  What other dates did you have in mind?
