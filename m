X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 16:30:42 -0800
Message-ID: <7v4prwn0lp.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<eluhk3$pv7$1@sea.gmane.org> <7vhcvwomde.fsf@assigned-by-dhcp.cox.net>
	<200612152348.17997.jnareb@gmail.com>
	<Pine.LNX.4.63.0612160023340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac1on2oh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612160113090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 00:30:54 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612160113090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 16 Dec 2006 01:14:02 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34580>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvNRx-0007cH-GZ for gcvg-git@gmane.org; Sat, 16 Dec
 2006 01:30:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030485AbWLPAao (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 19:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030486AbWLPAao
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 19:30:44 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46079 "EHLO
 fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030485AbWLPAan (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 19:30:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216003042.NZAU18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 19:30:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zCWu1V00A1kojtg0000000; Fri, 15 Dec 2006
 19:30:54 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> FWIW, I also read the list traffic through gmane news gateway.
>
> So, how do you tackle the problem Jakub evidently has, namely to reply to 
> all the people who your reply refers to?

I do not "tackle".

I just tell Gnus to follow-up, which does not always do the
right thing [*1*], and I just try to be careful and fix up To:
and Cc: fields by hand as necessary.  The time spent on that on
my part is _worth_ spending than inconveniencing others.

It's just a common courtesy, not "tackling".


[Footnote]

*1* ... most likely because I haven't configured it to do the
right thing, and/or the sender or the gateway puts a wrong
Reply-To: or Mail-Followup-To: header and it ends up honoring
them.
