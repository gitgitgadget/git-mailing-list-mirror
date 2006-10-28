X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Update information about <format> in git-for-each-ref
Date: Sat, 28 Oct 2006 13:42:05 -0700
Message-ID: <7v7iyk6ule.fsf@assigned-by-dhcp.cox.net>
References: <200610281930.05889.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 20:42:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610281930.05889.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 28 Oct 2006 19:30:05 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30397>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdv0O-0006Gf-JJ for gcvg-git@gmane.org; Sat, 28 Oct
 2006 22:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751406AbWJ1UmI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 16:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWJ1UmI
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 16:42:08 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15286 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1751406AbWJ1UmH
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 16:42:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061028204207.EKNR16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Sat, 28
 Oct 2006 16:42:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id fwiA1V00U1kojtg0000000 Sat, 28 Oct 2006
 16:42:11 -0400
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Update information about value of <format> used when it is left
> unspecified.  Add information about `%%` and `%xx` interpolation
> (URL encoding).
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Could any of you review this, fix wording (if needed)?

Looks fine; thanks.
