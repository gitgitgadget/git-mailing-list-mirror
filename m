X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Sat, 16 Dec 2006 11:57:51 -0800
Message-ID: <7vac1nehq8.fsf@assigned-by-dhcp.cox.net>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
	<eluhk3$pv7$1@sea.gmane.org> <7vhcvwomde.fsf@assigned-by-dhcp.cox.net>
	<200612152348.17997.jnareb@gmail.com>
	<Pine.LNX.4.63.0612160023340.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vac1on2oh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612160113090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4prwn0lp.fsf@assigned-by-dhcp.cox.net>
	<4584290E.6080006@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 19:58:06 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4584290E.6080006@midwinter.com> (Steven Grimm's message of "Sat,
	16 Dec 2006 09:12:46 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34637>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvffT-0007bh-FZ for gcvg-git@gmane.org; Sat, 16 Dec
 2006 20:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161440AbWLPT5y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 14:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161441AbWLPT5y
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 14:57:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53473 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1161440AbWLPT5x (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006
 14:57:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061216195752.GHVD9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Sat, 16
 Dec 2006 14:57:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zXy41V00D1kojtg0000000; Sat, 16 Dec 2006
 14:58:04 -0500
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Steven Grimm <koreth@midwinter.com> writes:

> Interesting. I'd actually prefer people *remove* me from the CC list -- 
> I find it annoying to get two copies of every message in threads I
> reply to. I'm already subscribed to the mailing list, so there's no
> point having me on the Cc line too. (Mind you, as annoyances go it's a
> pretty insignificant one.)
>
> I can understand the case of people who aren't on the list wanting to
> get replies, but why does someone who *is* on the list want to be
> CCed? Is it just that there's no good way to tell in advance which
> category a given person falls into, so best to be on the safe side?

There is no cheap and mechanical way to tell that for the
sender, and even when the sender can tell, it is not polite to
do so (see next paragraph), unless the recipient specifically
ask for it.  On the other hand, filtering duplicates at the
recipient's end could be mechanically done without wasting the
human time.  And people's time tend to be a lot more expensive
than machine time and the cost to send extra bits over the wire.

Some people (including me) prioritize e-mails and respond to
messages that are addressed To: them first, then Cc: next, and
finally the rest of the messages that came only through the
mailng list.  Dropping a recipient from the Cc: list, even when
the sender knows that recipient is on the list, breaks this.

People can safely remove *themselves* from the CC: list when the
mailing list they subscribe to are on the CC: list as well.
This would interact with the prioritizing I mentioned above, but
that is done as a choice by them as the recipient of the
replies, so there is no problem in doing so.
