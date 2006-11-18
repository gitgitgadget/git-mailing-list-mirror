X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 09:26:44 -0500
Message-ID: <BAYC1-PASMTP03FF5D34586546629C92BBAEEF0@CEZ.ICE>
References: <455F1595.9020009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 18 Nov 2006 14:27:05 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061118092644.a9f15669.seanlkml@sympatico.ca>
In-Reply-To: <455F1595.9020009@lsrfire.ath.cx>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 18 Nov 2006 14:26:46.0702 (UTC) FILETIME=[93EBF4E0:01C70B1D]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlR9l-0003kN-BV for gcvg-git@gmane.org; Sat, 18 Nov
 2006 15:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754709AbWKRO0s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 09:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbWKRO0r
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 09:26:47 -0500
Received: from bayc1-pasmtp03.bayc1.hotmail.com ([65.54.191.163]:55774 "EHLO
 BAYC1-PASMTP03.bayc1.hotmail.com") by vger.kernel.org with ESMTP id
 S1754709AbWKRO0r (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006
 09:26:47 -0500
Received: from linux1.attic.local ([65.93.43.81]) by
 BAYC1-PASMTP03.bayc1.hotmail.com over TLS secured channel with Microsoft
 SMTPSVC(6.0.3790.1830); Sat, 18 Nov 2006 06:26:46 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1GlQDT-0002kc-Un; Sat, 18 Nov 2006 08:26:44 -0500
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org

On Sat, 18 Nov 2006 15:15:49 +0100
Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:

> I copied most of the text from git-status.txt.
[...]	
> +git-runstatus - Show working tree status

How is git-runstatus different from "git status"?  Should this command be
viewed simply as plumbing, and if so does it deserve a man page or just
textual documentation in the source?

