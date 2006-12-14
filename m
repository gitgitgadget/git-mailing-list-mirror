X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "master" should be treated no differently from any other
     branch
Date: Thu, 14 Dec 2006 17:14:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612141710400.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612141519.44294.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612141627090.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <4581721B.4050102@xs4all.nl> <458174C9.2050401@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 16:14:54 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <458174C9.2050401@xs4all.nl>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34360>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GutEN-0004om-VC for gcvg-git@gmane.org; Thu, 14 Dec
 2006 17:14:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932851AbWLNQOp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 11:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932852AbWLNQOp
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 11:14:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:51104 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932851AbWLNQOo
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 11:14:44 -0500
Received: (qmail invoked by alias); 14 Dec 2006 16:14:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp019) with SMTP; 14 Dec 2006 17:14:39 +0100
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Han-Wen Nienhuys wrote:

> Wouldn't it be better to mention the id of the local repository too? 
> 
>   Merge branch 'master' of ssh+git://git.sv.gnu.org/srv/git/lilypond into 
>   'master' of 'hanwen@xs4all.nl'
> 
> this would give more information when these commit messages get pushed 
> to someone else.

And why not put your address and birthday in there, too?

Frankly, it does not matter. In my private git repository I see that I 
often merged from this machine to that machine, criss-crossing often. It 
does not buy me anything to even know _where_ I got it from.

Besides, the information you are most likely looking for is the committer, 
which is recorded anyway.

The single most useful information in the Merge message is the name of the 
branch I merged, since it is more often than not a topic branch, which is 
aptly named.

Ciao,
Dscho
