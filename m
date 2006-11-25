X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: git-format-patch little gripe
Date: Sat, 25 Nov 2006 10:42:54 -0500
Message-ID: <BAYC1-PASMTP11C557DF59DF29690CDB77AEE00@CEZ.ICE>
References: <376237.14965.qm@web31805.mail.mud.yahoo.com>
	<20061103185026.GA28566@coredump.intra.peff.net>
	<20061125103033.2ea742d3.seanlkml@sympatico.ca>
	<20061125153949.GA11136@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 15:43:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.74]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061125104254.b1a57b60.seanlkml@sympatico.ca>
In-Reply-To: <20061125153949.GA11136@coredump.intra.peff.net>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 25 Nov 2006 15:52:42.0015 (UTC) FILETIME=[BD9E8AF0:01C710A9]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnzgC-0001rm-9s for gcvg-git@gmane.org; Sat, 25 Nov
 2006 16:43:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966643AbWKYPm5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757922AbWKYPm5
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 10:42:57 -0500
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:37375 "EHLO
 BAYC1-PASMTP11.CEZ.ICE") by vger.kernel.org with ESMTP id S1757794AbWKYPm4
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 10:42:56 -0500
Received: from linux1.attic.local ([65.93.43.74]) by BAYC1-PASMTP11.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Sat, 25 Nov
 2006 07:52:41 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gnyk1-0006N5-96; Sat, 25 Nov 2006 09:42:53 -0500
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

On Sat, 25 Nov 2006 10:39:49 -0500
Jeff King <peff@peff.net> wrote:

> On Sat, Nov 25, 2006 at 10:30:33AM -0500, Sean wrote:
> 
> > If your mail setup support imap, the patches can be dumped directly into
> > it rather than having to go through an mbox.  For instance you can have
> > something like this in your ~/.gitconfig:
> 
> Sure, I could. But if you have a client which supports mboxes, it's
> probably better to use the mbox. With your solution, I send the patch to
> the imap server, then fire up the mail client and re-download the
> patch, possibly mark it up, and then send it out by smtp. The latency
> increase can be noticeable, especially for big patches and slow imap
> servers.

Yeah, I didn't mean it as a better replacement for your use, just as
an option that might suit some people better.  It works out well here.

> > To move all the patches into your imap drafts folder to be accessed
> > by whatever email client you use.
> 
> Oh come on, Real Men just edit the mbox in vi. :)

Damn.. caught in my skirt again.. ;o)

