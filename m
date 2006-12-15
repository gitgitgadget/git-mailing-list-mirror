X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Ignoring local changes
Date: Fri, 15 Dec 2006 01:15:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612150114030.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <loom.20061214T171948-279@post.gmane.org> <45817F8A.3050701@op5.se>
  <9e7ab7380612140855p1f4ee6c1l5ef24c4d1d169da6@mail.gmail.com> 
 <4581C1D4.7080102@dawes.za.net> <9e7ab7380612141336p3b930047l3a4a76947239162f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 15 Dec 2006 00:16:31 +0000 (UTC)
Cc: Rogan Dawes <discard@dawes.za.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <9e7ab7380612141336p3b930047l3a4a76947239162f@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34451>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0kV-0007Jw-A9 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 01:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752060AbWLOAQY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 19:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbWLOAQY
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 19:16:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:39700 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1752060AbWLOAQX
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 19:16:23 -0500
Received: (qmail invoked by alias); 15 Dec 2006 00:15:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 15 Dec 2006 01:15:59 +0100
To: Pazu <pazu@pazu.com.br>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Pazu wrote:

> 2006/12/14, Rogan Dawes <discard@dawes.za.net>:
> 
> > Why not remove it from the repo, then set .gitignore?
> > 
> > If it is generated code, or compiled code, it probably shouldn't be in
> > the repo in the first place . . . Simply correct that mistake, and you
> > are good to go.
> 
> Basically, because I don't want to mess with the upstream. I know, I
> can remove them only from my local branch, and never push the commit
> that removed the files, and that's what I'll probably do if there's no
> other way -- but it would be best if I could just ignore the files. It
> doesn't sound unreasonable, does it?

It is not unreasonable. But I could not find an easy way to do it with 
git. It should be easy to hack it into it, though.

Ciao,
Dscho
