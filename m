X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Make git-commit cleverer - have it figure out whether
 it needs -a automatically
Date: Thu, 30 Nov 2006 16:34:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611301632560.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200611301259.32387.andyparkins@gmail.com> <ekmlar$ask$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 15:34:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <ekmlar$ask$2@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32754>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpnvU-00048u-CW for gcvg-git@gmane.org; Thu, 30 Nov
 2006 16:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030528AbWK3PeJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 10:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030542AbWK3PeJ
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 10:34:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:50586 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030543AbWK3PeG (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 10:34:06 -0500
Received: (qmail invoked by alias); 30 Nov 2006 15:34:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 30 Nov 2006 16:34:04 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Jakub Narebski wrote:

> Could we add suggestion by Andreas Ericsson to print in the "smart 
> commit" case:
> 
>   Nothing to commit but changes in working tree. Assuming 'git commit -a'
> 
> or something like that?

Only that you would not see it (or ignore it, as has been illustrated in 
another thread), because your editor pops up, hiding that message.

Ciao,
Dscho
