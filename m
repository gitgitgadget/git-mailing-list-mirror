X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git newbie problems
Date: Wed, 6 Dec 2006 11:42:29 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612061140540.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <4574AC9E.3040506@gmail.com> <el55to$952$1@sea.gmane.org>
 <45768FE8.2030202@xs4all.nl> <200612061117.32903.jnareb@gmail.com>
 <457699C1.3060400@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 6 Dec 2006 10:42:44 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <457699C1.3060400@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33431>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GruEU-0004j3-Pt for gcvg-git@gmane.org; Wed, 06 Dec
 2006 11:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760451AbWLFKmb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 05:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760468AbWLFKmb
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 05:42:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:35872 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1760451AbWLFKmb
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006 05:42:31 -0500
Received: (qmail invoked by alias); 06 Dec 2006 10:42:29 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 06 Dec 2006 11:42:29 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 6 Dec 2006, Han-Wen Nienhuys wrote:

> Note that in the beginning I have wrestled to make git update the HEAD , 
> eg. trying --update-head-ok

Ah! That would explain many of the problems! BTW where did you see that 
option mentioned? We should hide this option as deep in the technical 
lores of the documentation, fast.

Ciao,
Dscho
