X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Document git-runstatus
Date: Sat, 18 Nov 2006 15:35:11 +0100
Message-ID: <20061118143511.GM7201@pasky.or.cz>
References: <455F1595.9020009@lsrfire.ath.cx> <20061118092644.a9f15669.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 14:35:24 +0000 (UTC)
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061118092644.a9f15669.seanlkml@sympatico.ca>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31774>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlRHr-0004jb-F5 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 15:35:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754661AbWKROfP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 09:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754743AbWKROfO
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 09:35:14 -0500
Received: from w241.dkm.cz ([62.24.88.241]:39084 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1754661AbWKROfN (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 09:35:13 -0500
Received: (qmail 30763 invoked by uid 2001); 18 Nov 2006 15:35:11 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 03:26:44PM CET, Sean wrote:
> On Sat, 18 Nov 2006 15:15:49 +0100
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> wrote:
> 
> > I copied most of the text from git-status.txt.
> [...]	
> > +git-runstatus - Show working tree status

Don't forget to add it to the list of commands.

> How is git-runstatus different from "git status"?

I have the same question.

> Should this command be viewed simply as plumbing, and if so does it
> deserve a man page or just textual documentation in the source?

All commands deserve a man page.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
