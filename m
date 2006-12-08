X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add branch.*.localmerge and documentation update
Date: Fri, 08 Dec 2006 15:41:13 -0800
Message-ID: <7vu006ez1i.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590612052051r62111c4cgfd7ee893cb00f84a@mail.gmail.com>
	<200612082301.57037.Josef.Weidendorfer@gmx.de>
	<7v1wnaggp7.fsf@assigned-by-dhcp.cox.net>
	<200612090017.44105.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 23:41:23 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612090017.44105.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sat, 9 Dec 2006 00:17:43 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33770>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GspLB-0006yE-RB for gcvg-git@gmane.org; Sat, 09 Dec
 2006 00:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761280AbWLHXlP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 18:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761283AbWLHXlP
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 18:41:15 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:55288 "EHLO
 fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761280AbWLHXlO (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 18:41:14 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208234113.CMCS29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 18:41:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wPgd1V0091kojtg0000000; Fri, 08 Dec 2006
 18:40:37 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> But the previous documentation simply was way to short.

Yes, your documentation updates seems to make it much clearer.

> Should I send a "simplified" patch?

Thanks, appreciated.
