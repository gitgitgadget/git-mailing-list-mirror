X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (amend)] gitweb: Slight visual improvements to commitdiff view
Date: Thu, 26 Oct 2006 18:42:06 -0700
Message-ID: <7vu01qilg1.fsf@assigned-by-dhcp.cox.net>
References: <200610270150.40100.jnareb@gmail.com>
	<780488.44315.qm@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 02:01:01 +0000 (UTC)
Cc: git@vger.kernel.org, ltuikov@yahoo.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <780488.44315.qm@web31803.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Thu, 26 Oct 2006 17:39:14 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30274>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdGjd-0001WZ-Vc for gcvg-git@gmane.org; Fri, 27 Oct
 2006 03:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946097AbWJ0BmK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 21:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946098AbWJ0BmK
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 21:42:10 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40439 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1946097AbWJ0BmH
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 21:42:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061027014206.RKUS13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>; Thu, 26
 Oct 2006 21:42:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id fDho1V00Q1kojtg0000000 Thu, 26 Oct 2006
 21:41:49 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Luben Tuikov <ltuikov@yahoo.com> writes:

> --- Jakub Narebski <jnareb@gmail.com> wrote:
> ...
>> Those changes might wait for proper refactoring of gitweb CSS (having 
>> for example 8px padding in one place only).
>
> Excellent!  I'd like this explanation to be part of the
> commit message if that patchset is committed to git.git.

I'd like that kind of explanation with the patch in a single
message when it is ready to be applied, too.

I'll leave it up to you guys to decide if CSS refactoring should
go in first (I personally feel it probably is the case, in which
case this patch would need to be rebased I suspect).
