X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Change in git-svn dcommit semantics?
Date: Wed, 20 Dec 2006 00:57:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612200053550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <m2mz5jegka.fsf@ziti.local> <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 19 Dec 2006 23:57:33 +0000 (UTC)
Cc: Seth Falcon <sethfalcon@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <94FF72E0-F8BD-4773-803E-F179754BF0ED@silverinsanity.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34866>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwopl-0005VC-No for gcvg-git@gmane.org; Wed, 20 Dec
 2006 00:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752877AbWLSX5S (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 18:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbWLSX5S
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 18:57:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:46362 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752874AbWLSX5S
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 18:57:18 -0500
Received: (qmail invoked by alias); 19 Dec 2006 23:57:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 20 Dec 2006 00:57:16 +0100
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Brian Gernhardt wrote:

> Mine also has a few variables like "COLLISION_CHECK=paranoid" and my own 
> prefix.

Just to wake sleeping tigers: have you done a "grep COLLISION_CHECK *" 
recently (where recently means any date after May 3rd, 2005)?

Ciao,
Dscho
