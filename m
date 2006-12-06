X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to
 .git/config on clone
Date: Wed, 6 Dec 2006 13:20:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061320360.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612061207.23437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 12:21:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612061207.23437.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33438>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grvlp-0000TR-8x for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:21:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760546AbWLFMVA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760543AbWLFMVA
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:21:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:44381 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760546AbWLFMVA
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 07:21:00 -0500
Received: (qmail invoked by alias); 06 Dec 2006 12:20:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp049) with SMTP; 06 Dec 2006 13:20:58 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Andy Parkins wrote:

> This is really to help newbies.  By explicitly documenting the default 
> behaviour, it makes it clearer what is going on.  It also means no 
> routing through documentation to find out what config option needs 
> changing.

Melikes.

Ciao,
