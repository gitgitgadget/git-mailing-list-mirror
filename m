X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: amendment to "remove merge-recursive-old"
Date: Mon, 20 Nov 2006 16:13:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611201613030.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 20 Nov 2006 15:14:20 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31915>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmAqb-0003tC-OT for gcvg-git@gmane.org; Mon, 20 Nov
 2006 16:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934224AbWKTPOE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 10:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934225AbWKTPOE
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 10:14:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:29123 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S934224AbWKTPOB (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 10:14:01 -0500
Received: (qmail invoked by alias); 20 Nov 2006 15:14:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 20 Nov 2006 16:14:00 +0100
To: junkio@cox.net, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

if git-merge-recursive-old.py is removed, gitMergeCommon.py should be 
removed, too.

Ciao,
Dscho
