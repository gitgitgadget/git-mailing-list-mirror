X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git tag: don't complain of empty messages
Date: Wed, 15 Nov 2006 17:19:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611151718220.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ejfc1t$6am$1@sea.gmane.org>
 <Pine.LNX.4.63.0611151657570.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <455B3AC2.10107@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 15 Nov 2006 16:19:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <455B3AC2.10107@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31450>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkNUG-0001vc-N9 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 17:19:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030644AbWKOQTj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 11:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030643AbWKOQTi
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 11:19:38 -0500
Received: from mail.gmx.de ([213.165.64.20]:50130 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1030632AbWKOQTh (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 11:19:37 -0500
Received: (qmail invoked by alias); 15 Nov 2006 16:19:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 15 Nov 2006 17:19:35 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 15 Nov 2006, Han-Wen Nienhuys wrote:

> Without a message, the tag can still be identified by its name, which is 
> in the tag object contents.

You are correct. Acked-by: me.

Ciao,
Dscho
