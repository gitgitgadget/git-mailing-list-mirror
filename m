X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [DRAFT 2] Branching and merging with git
Date: Mon, 4 Dec 2006 11:56:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612041153330.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vslghftix.fsf@assigned-by-dhcp.cox.net>
 <20061120235136.4841.qmail@science.horizon.com> <20061204011958.GB28043@fieldses.org>
 <20061204072350.GC28043@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 4 Dec 2006 10:56:40 +0000 (UTC)
Cc: linux@horizon.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061204072350.GC28043@fieldses.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33187>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrBV0-00021m-Mx for gcvg-git@gmane.org; Mon, 04 Dec
 2006 11:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935885AbWLDK4g (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 05:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935889AbWLDK4g
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 05:56:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:32439 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935885AbWLDK4f (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 05:56:35 -0500
Received: (qmail invoked by alias); 04 Dec 2006 10:56:33 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 04 Dec 2006 11:56:33 +0100
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

Hi,

On Mon, 4 Dec 2006, J. Bruce Fields wrote:

> So I'm trying to split out an extremely concise "quick-start" guide 
> (modelled partly on Mercurial's) that doesn't even pretend to explain 
> anything,

you might want to look at the QuickStart page in Git's wiki...

> 	  	1. clone
> 		2. checking out old versions, basic branch management
> 		3. keeping up-to-date with fetch
> 		4. bisect
> 		5. archaeology (commits DAG, git-log, ...)
> 		6. creating commits, index file
> 		7. resolving merges, pull
> 		8. publishing a public repository, push

Another approach would be to illustrate short stories of a failed merge, 
or "how I put up a public repository", etc. Like, more example-based (and 
of course short enough that people actually read through it).

Ciao,
Dscho
