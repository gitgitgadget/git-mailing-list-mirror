X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Wed, 01 Nov 2006 07:30:03 -0800
Message-ID: <7vac3b5gn8.fsf@assigned-by-dhcp.cox.net>
References: <200610281930.05889.jnareb@gmail.com>
	<7vslh86uz9.fsf@assigned-by-dhcp.cox.net>
	<200610282323.57797.jnareb@gmail.com> <45485A0F.3040807@op5.se>
	<7vd5877duh.fsf@assigned-by-dhcp.cox.net> <454875AC.6060300@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 15:31:28 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <454875AC.6060300@op5.se> (Andreas Ericsson's message of "Wed, 01
	Nov 2006 11:23:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30642>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfI2x-0005US-9G for gcvg-git@gmane.org; Wed, 01 Nov
 2006 16:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992616AbWKAPaJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 10:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992614AbWKAPaH
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 10:30:07 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15033 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S2992616AbWKAPaF
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 10:30:05 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101153004.QIHV18180.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 10:30:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hTW81V00e1kojtg0000000 Wed, 01 Nov 2006
 10:30:09 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> ... For me it's the other
> way around, so I think of the above as "if it doesn't compare to this
> or that, then do this", but the "are equal to" meaning of "compare"
> isn't intuitive to me as I spent the first several years of my
> english-speaking life using "compare" exclusively as a verb.

<offtopic>

I think I should have said that "I force me to pronounce" and I
am trying to say the same thing as you said.

xxxcmp(a, b) literally is "compare a and b and give me the
result"; the result coming back as "true" when a and b are
different is counter-intuitive and I think it is so to
everybody, not limited to non-English speaking people.  That's
why I force me to ignore the etymology of the "cmp" in the
function name and call that "a and b differs" or "subtract b
from a" depending on the context.

By the way, I think "a compares to b" is also a verb, not just
"i compare a and b and found these differences".

</offtopic>
