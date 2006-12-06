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
Date: Thu, 7 Dec 2006 00:23:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612070022180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612061207.23437.andyparkins@gmail.com>
 <200612061800.17087.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 23:23:24 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612061800.17087.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33534>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs66Y-0002tO-QR for gcvg-git@gmane.org; Thu, 07 Dec
 2006 00:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937781AbWLFXXH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 18:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937782AbWLFXXH
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 18:23:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:37982 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937781AbWLFXXE
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 18:23:04 -0500
Received: (qmail invoked by alias); 06 Dec 2006 23:23:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 07 Dec 2006 00:23:03 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Josef Weidendorfer wrote:

> On Wednesday 06 December 2006 13:07, Andy Parkins wrote:
> > The [branch "master"] section is such that there is no change to the
> > functionality of git-pull, but that functionality is now explicitly
> > documented.
> 
> Nice. However, changing "git-clone" for this is an adhoc solution and 
> looks wrong.

Not to me. There is _no_ other place to put this, if you want to help 
people graps the concept of branch.*.merge.

Ciao,
Dscho
