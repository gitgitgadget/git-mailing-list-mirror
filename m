X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git-add update with all-0 object
Date: Thu, 30 Nov 2006 23:32:01 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611302328570.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 22:32:50 +0000 (UTC)
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32818>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpuS6-0006Zn-Vt for gcvg-git@gmane.org; Thu, 30 Nov
 2006 23:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031578AbWK3WcG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 17:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031580AbWK3WcF
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 17:32:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:44947 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031578AbWK3WcD (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 17:32:03 -0500
Received: (qmail invoked by alias); 30 Nov 2006 22:32:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 30 Nov 2006 23:32:01 +0100
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 30 Nov 2006, Daniel Barkalow wrote:

> I think the more obvious behavior is to have it record the fact that you 
> want to have the path tracked, but require one of the usual updating 
> mechanisms to get a particular content into the index.

I fear that this is just your being used to the CVS mindset. Please see 
http://article.gmane.org/gmane.comp.version-control.git/32792 for details.

Hth,
Dscho
