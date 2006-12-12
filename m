X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT - releases workflow
Date: Tue, 12 Dec 2006 23:54:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612122353320.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 22:54:22 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <89b129c60612121444t18ba94ecv57eea4c72be1663a@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34161>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuGVw-00008z-MY for gcvg-git@gmane.org; Tue, 12 Dec
 2006 23:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932551AbWLLWyR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 17:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWLLWyR
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 17:54:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:43540 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932553AbWLLWyR
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 17:54:17 -0500
Received: (qmail invoked by alias); 12 Dec 2006 22:54:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp048) with SMTP; 12 Dec 2006 23:54:15 +0100
To: Sean Kelley <sean.v.kelley@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Sean Kelley wrote:

> I was wondering if anyone could share ideas on how best to use GIT to 
> handle releases for those working with a remote GIT repository?  Do you 
> create a branch and push it to the remote?  Thus you have a new branch 
> referencing the particular release?

Why not just tag the release, and push the tag?

Hth,
Dscho
