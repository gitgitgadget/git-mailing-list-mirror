X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Adding spell checker to GIT
Date: Tue, 5 Dec 2006 17:13:46 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612051713100.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 16:13:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <b5a19cd20612050805x309d667eq649ba7ef1b8109b7@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33353>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrcvY-0007FW-Mz for gcvg-git@gmane.org; Tue, 05 Dec
 2006 17:13:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968419AbWLEQNt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 11:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968417AbWLEQNt
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 11:13:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:38508 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S968414AbWLEQNs
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 11:13:48 -0500
Received: (qmail invoked by alias); 05 Dec 2006 16:13:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp018) with SMTP; 05 Dec 2006 17:13:46 +0100
To: Deepak Barua <dbbarua@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 5 Dec 2006, Deepak Barua wrote:

> I am just thought of a idea to integrate a spell checker with git so 
> that when we check in the code the code comments are spell checked 
> before being put into the tree,maybe have a optimized dictionary search.

I think the best idea would be to put this into the pre-commit hook.

Hth,
Dscho
