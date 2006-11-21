X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: remotes/* for "foreign" archives
Date: Tue, 21 Nov 2006 11:33:48 -0800
Message-ID: <7v1wnwy4pv.fsf@assigned-by-dhcp.cox.net>
References: <86y7q6m3zm.fsf@blue.stonehenge.com>
	<86r6vwkfti.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 19:34:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86r6vwkfti.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "21 Nov 2006 06:57:45 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32028>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmbNR-0006R8-4A for gcvg-git@gmane.org; Tue, 21 Nov
 2006 20:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031334AbWKUTdu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 14:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031335AbWKUTdu
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 14:33:50 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50626 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1031334AbWKUTdt
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 14:33:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061121193349.CJXS97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Tue, 21
 Nov 2006 14:33:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id pXZw1V00M1kojtg0000000; Tue, 21 Nov 2006
 14:33:56 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> It occurred to me after posting this, and while still thinking about the
> presentation I'm writing, that it'd be interesting if "get-fetch" could hide
> this from me.

I agree fully, as it was in my earlier "wishlist" ;-)

Anybody?
