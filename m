X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-merge-recursive segmentation error
Date: Wed, 20 Dec 2006 02:18:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612200217300.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <693577.67723.qm@web31813.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 01:19:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <693577.67723.qm@web31813.mail.mud.yahoo.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34885>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwq6l-0001AG-ME for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932821AbWLTBS5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932849AbWLTBS5
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:18:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:36524 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932821AbWLTBS4
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 20:18:56 -0500
Received: (qmail invoked by alias); 20 Dec 2006 01:18:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 20 Dec 2006 02:18:54 +0100
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Luben Tuikov wrote:

> Auto-merging init/version.c
> /home/luben/bin/git-merge: line 394: 12030 
> Segmentation fault git-merge-$strategy $common -- "$head_arg" "$@"

Do you have any pointers how to get the two branches you try to merge? I'd 
be most grateful to have the sha1's of both heads, too...

Ciao,
Dscho
