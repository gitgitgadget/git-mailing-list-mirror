X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 22:30:56 -0800
Message-ID: <7vpsbpp6fz.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
	<7virhhy76h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142048350.2591@xanadu.home>
	<7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
	<20061115061833.GA6294@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 06:31:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061115061833.GA6294@spearce.org> (Shawn Pearce's message of
	"Wed, 15 Nov 2006 01:18:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31423>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkEIY-0003sI-HK for gcvg-git@gmane.org; Wed, 15 Nov
 2006 07:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966548AbWKOGa6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 01:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966549AbWKOGa6
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 01:30:58 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:11514 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S966548AbWKOGa6
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 01:30:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115063057.RYCD9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 01:30:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id muX31V00X1kojtg0000000; Wed, 15 Nov 2006
 01:31:04 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Or even better, have "gh init".
>
> Why gh?  Is Git just Mercurial backwards?  :)
>
> I'm all in favor of this discussion, and in particular of just
> breaking the entire UI in 2.0 by using a new frontend command.
> I'm just not sure that "Mercurial backwards" describes Git well.

I do not have any obsession to any name as long as it is
different from "git" to avoid confusion coming from older
documents that would be found by googling.  gh was just
shorthand for "git for humans" (and easy to type with index
fingers).  I think I listed a few other possibilities in my
previous message.
