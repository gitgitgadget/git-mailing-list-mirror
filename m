X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: merge-recursive, was Re: What's in git.git
Date: Thu, 26 Oct 2006 11:18:23 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610261114520.3286@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 26 Oct 2006 09:18:40 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vk62npipb.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30160>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd1Nd-0008UD-5a for gcvg-git@gmane.org; Thu, 26 Oct
 2006 11:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752136AbWJZJS0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 05:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbWJZJS0
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 05:18:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:37846 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752136AbWJZJSZ (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 05:18:25 -0400
Received: (qmail invoked by alias); 26 Oct 2006 09:18:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp013) with SMTP; 26 Oct 2006 11:18:23 +0200
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 26 Oct 2006, Junio C Hamano wrote:

>   We'd still need more work on merge-recursive to fix the
>   overcautious "working file will be overwritten by merge" --
>   this is really needed for usability.

I am sorry, but I do not have the time to wrap my head around this for at 
least another week. It seems to be a complicated problem (not the fix, 
mind you, but the side effects you have to think of!), and I stupidly 
started to play with shallow clones when I knew I had no time already.

BTW what happened to the builtin shortlog? It is the last Perl script I 
use regularly... (should make people happy who are stuck with Activision 
Perl...)

Ciao,
Dscho
