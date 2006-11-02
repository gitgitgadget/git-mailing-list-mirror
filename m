X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and "dumb protocols"
Date: Thu, 2 Nov 2006 11:57:16 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021155500.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <vpqu01i16g8.fsf@ecrins.imag.fr> <20061102104848.GH20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 10:57:47 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061102104848.GH20017@pasky.or.cz>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30714>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaGA-00017P-B7 for gcvg-git@gmane.org; Thu, 02 Nov
 2006 11:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752272AbWKBK5T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 05:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbWKBK5T
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 05:57:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:19128 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1752272AbWKBK5S (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 05:57:18 -0500
Received: (qmail invoked by alias); 02 Nov 2006 10:57:16 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp017) with SMTP; 02 Nov 2006 11:57:16 +0100
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 2 Nov 2006, Petr Baudis wrote:

>   If you already have SSH access to the server, why not compile Git
> there and install it to your $HOME, though?

Could be a number of reasons:

- no compiler
- quota issues
- missing support for that particular platform
- time constraints
- etc

Happened to me.

Ciao,
Dscho
