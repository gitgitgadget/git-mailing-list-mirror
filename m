X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 2 Nov 2006 16:01:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611021559430.1670@wbgn013.biozentrum.uni-wuerzburg.de>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org> 
 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org> 
 <4549CE2A.3010808@xs4all.nl> <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
 <454A0538.9000104@iaglans.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 2 Nov 2006 15:02:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <454A0538.9000104@iaglans.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30756>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gfe4Q-0003wD-DQ for gcvg-git@gmane.org; Thu, 02 Nov
 2006 16:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750966AbWKBPBO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 10:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWKBPBO
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 10:01:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:53946 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1750972AbWKBPBN (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 10:01:13 -0500
Received: (qmail invoked by alias); 02 Nov 2006 15:01:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp037) with SMTP; 02 Nov 2006 16:01:12 +0100
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 2 Nov 2006, Nicolas Vilz 'niv' wrote:

> > Use the complete output of describe:
> > $ git show v1.4.3.3-g1e1f76e
> 
> this one doesn't work for me in my repository.

You need at least v1.4.3-rc1^0~69 (v1.4.2.1-g7dd45e1) for this. You 
indicated in your email that your version is older.

Ciao,
Dscho
