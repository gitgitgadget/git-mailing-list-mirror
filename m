X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug in merge-recursive in virtual commit corner case
Date: Fri, 8 Dec 2006 04:03:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612080401080.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207083531.GA22701@spearce.org>
 <Pine.LNX.4.63.0612071636030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061207192401.GB12143@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 8 Dec 2006 03:03:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061207192401.GB12143@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33653>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsW12-00046Y-7M for gcvg-git@gmane.org; Fri, 08 Dec
 2006 04:03:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760677AbWLHDDI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 22:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760680AbWLHDDI
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 22:03:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:58967 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760677AbWLHDDG
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 22:03:06 -0500
Received: (qmail invoked by alias); 08 Dec 2006 03:03:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp030) with SMTP; 08 Dec 2006 04:03:04 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

can you send me at least the output of 

$ git-rev-list --parents branch1 branch2

preferrably packed? There is nothing you can do legally wrong, since you 
are not sending any data, only metadata.

Ciao,
Dscho
