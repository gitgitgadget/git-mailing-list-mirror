X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Thu, 14 Dec 2006 11:47:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141146410.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061214103741.GD1747@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 10:47:27 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214103741.GD1747@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34307>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guo7Z-00005H-6B for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932395AbWLNKrK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWLNKrK
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:47:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:46750 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932395AbWLNKrI
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 05:47:08 -0500
Received: (qmail invoked by alias); 14 Dec 2006 10:47:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 14 Dec 2006 11:47:07 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > +git show master:Makefile master:t/Makefile
> > +	Concatenates the contents of said Makefiles in the head
> > +	of the branch `master`.
> > +
> 
> Uh, isn't that what cat does?  Shouldn't this be "git cat"?  :-)

Shhh! The dogs are sleeping!

Ciao,
Dscho
