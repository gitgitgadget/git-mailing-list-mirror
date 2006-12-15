X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 15:45:50 -0800
Message-ID: <7vac1on2oh.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<eluhk3$pv7$1@sea.gmane.org> <7vhcvwomde.fsf@assigned-by-dhcp.cox.net>
	<200612152348.17997.jnareb@gmail.com>
	<Pine.LNX.4.63.0612160023340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 23:45:59 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612160023340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 16 Dec 2006 00:25:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34577>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvMkV-0003HM-RI for gcvg-git@gmane.org; Sat, 16 Dec
 2006 00:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965292AbWLOXpx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 18:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWLOXpx
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 18:45:53 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45231 "EHLO
 fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965292AbWLOXpw (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 18:45:52 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215234551.ZAUQ25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 18:45:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zBm31V0011kojtg0000000; Fri, 15 Dec 2006
 18:46:03 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 15 Dec 2006, Jakub Narebski wrote:
>
>> Junio C Hamano wrote:
>>
>> > (Jakub, please do not drop people from cc: list; you were asked
>> > more than once).
>> 
>> The problem is that I'm not subscribed to git mailing list;
>
> So subscribe. I am sure I lost quite some of your responses to my emails, 
> _just_ because you happen to kill me from the Cc: list.
>
> IOW if you expect answers, _please_ adher to net standards.

FWIW, I also read the list traffic through gmane news gateway.

I am subscribed and my mail filter drops the mails from the list
into a dedicated mailbox, but that is purely for my own backup
and I usually do not look at it otherwise.
