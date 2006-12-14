X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] "master" should be treated no differently from any other branch
Date: Thu, 14 Dec 2006 13:30:30 -0800
Message-ID: <7virge17yh.fsf@assigned-by-dhcp.cox.net>
References: <200612141519.44294.andyparkins@gmail.com>
	<7vejr22ose.fsf@assigned-by-dhcp.cox.net>
	<200612142123.16291.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 21:30:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200612142123.16291.andyparkins@gmail.com> (Andy Parkins's
	message of "Thu, 14 Dec 2006 21:23:15 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34405>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuyA1-0002cd-8J for gcvg-git@gmane.org; Thu, 14 Dec
 2006 22:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932931AbWLNVac (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 16:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932930AbWLNVac
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 16:30:32 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48381 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932928AbWLNVab (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 16:30:31 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061214213031.JCDG9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 14
 Dec 2006 16:30:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ylWi1V00d1kojtg0000000; Thu, 14 Dec 2006
 16:30:43 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> On Thursday 2006, December 14 20:41, Junio C Hamano wrote:
>
>> However, the fmt-merge-message was designed so for a very
>> practical reason --- to keep Merge commit log messages Linus
>> makes in the kernel repository short and readable.
>
> I'm only after consistency; how about the reverse solution: drop the "into" 
> completely?

I guess that question indicates that the part of my message you
did not quote was not written cleanly enough.
