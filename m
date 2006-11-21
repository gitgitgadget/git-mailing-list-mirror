X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is there a way to trim old SHAs from a git tree (so it's not so
 large)?
Date: Tue, 21 Nov 2006 17:57:33 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611211756510.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <455B90AD.3060707@freescale.com> <20061117103611.183640@gmx.net>
 <45632957.5070205@freescale.com> <20061121163206.GA22006@spearce.org>
 <45632EC6.5030902@freescale.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 16:58:20 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Thomas Kolejka <Thomas.Kolejka@gmx.at>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45632EC6.5030902@freescale.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32004>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmYwY-0005UW-17 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 17:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030857AbWKUQ5j (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 11:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030712AbWKUQ5j
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 11:57:39 -0500
Received: from mail.gmx.de ([213.165.64.20]:7135 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030857AbWKUQ5i (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 11:57:38 -0500
Received: (qmail invoked by alias); 21 Nov 2006 16:57:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp032) with SMTP; 21 Nov 2006 17:57:36 +0100
To: Timur Tabi <timur@freescale.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 21 Nov 2006, Timur Tabi wrote:

> Shawn Pearce wrote:
> 
> > Shallow clone is a development feature still being working on in
> > Junio's 'pu' branch of git.git.  It has a few issues still to be
> > worked out so it hasn't been made part of one of the more stable
> > branches yet (like 'next', 'master', or 'maint').
> 
> Well, until it's available on an official git release, it doesn't help 
> me.

Well, if you help it, it will be available on an official git release 
soon!

Ciao,
Dscho
