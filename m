X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-pull from git.git - no remote ref for pu or next?
Date: Tue, 12 Dec 2006 19:09:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121908100.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <863b7l83o9.fsf@blue.stonehenge.com> <86y7pd6oz7.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 18:10:30 +0000 (UTC)
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0612120949230.3535@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34117>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuC55-0006La-JM for gcvg-git@gmane.org; Tue, 12 Dec
 2006 19:10:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932320AbWLLSKP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 13:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWLLSKP
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 13:10:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:47020 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932320AbWLLSKN
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 13:10:13 -0500
Received: (qmail invoked by alias); 12 Dec 2006 18:09:43 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp035) with SMTP; 12 Dec 2006 19:09:43 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Linus Torvalds wrote:

> But since the thing needs mirroring for non-git uses too, and since 
> rsync generally _works_ apart from the slight race-condition issue, 

... and git would probably change the pack structure (i.e. which objects 
are in which packs, or even loose) which would be too bad for all those 
HTTP leechers ...

> that's what it just uses.

Ciao,
Dscho
