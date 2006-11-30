X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git blame [was: git and bzr]
Date: Thu, 30 Nov 2006 23:17:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611302314320.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <20061021130111.GL75501@over-yonder.net>
 <453F2FF8.2080903@op5.se> <200610251146.06116.jnareb@gmail.com>
 <a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>
 <87slhcz8zh.wl%cworth@cworth.org> <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <Pine.LNX.4.64.0611271834090.30076@woody.osdl.org> <456CEF31.8080600@webdrake.net>
 <Pine.LNX.4.64.0611281906520.3395@woody.osdl.org> <456D7A76.3080605@webdrake.net>
 <Pine.LNX.4.64.0611290830010.3395@woody.osdl.org> <456F21D6.1060200@webdrake.net>
 <Pine.LNX.4.64.0611301034420.3513@woody.osdl.org> <87d574u2tl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:17:37 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Joseph Wakeling <joseph.wakeling@webdrake.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87d574u2tl.wl%cworth@cworth.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32811>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuDW-0003Jq-0V for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031557AbWK3WRP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031558AbWK3WRP
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:17:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:18142 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031557AbWK3WRO (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:17:14 -0500
Received: (qmail invoked by alias); 30 Nov 2006 22:17:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 30 Nov 2006 23:17:12 +0100
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Carl Worth wrote:

> Here's a crazy idea. How about a "git tutorial" builtin or "git example" 
> or something that would create a repository into some useful state for 
> demonstrating something.

That sounds fine! Actually, it should be very simple to turn the tutorial 
into such a script, displaying the command with an explanation, and 
executing the command. It could even call gitk from time to time, so the 
user can form a mental model of the ancestor graph.

Ciao,
Dscho
