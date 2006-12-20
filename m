X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
Date: Wed, 20 Dec 2006 14:17:16 -0800
Message-ID: <7vvek66wlv.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 22:17:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86vek6z0k2.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 14:04:29 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34969>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx9kq-0001ow-0l for gcvg-git@gmane.org; Wed, 20 Dec
 2006 23:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030383AbWLTWRV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 17:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030379AbWLTWRU
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 17:17:20 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:65078 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030383AbWLTWRS (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 17:17:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220221717.YQZY97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Wed, 20
 Dec 2006 17:17:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 1AGb1W00N1kojtg0000000; Wed, 20 Dec 2006
 17:16:36 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Is this really in master?  I'm still seeing one-hour times on
> my Mac, using 8336afa563fbeff35e531396273065161181f04c.

I think you are behind rsync mirroring lag.

Look for X-master-at: header in my message to see if you have
that commit, please.

