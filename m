X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 11:49:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611291145510.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45357CC3.4040507@utoronto.ca> <87slhcz8zh.wl%cworth@cworth.org>
 <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
 <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
 <Pine.LNX.4.64.0611281432300.4244@woody.osdl.org> <456CBCD5.3050505@onlinehome.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 10:49:49 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <456CBCD5.3050505@onlinehome.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32630>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpN0H-0001rc-7r for gcvg-git@gmane.org; Wed, 29 Nov
 2006 11:49:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966882AbWK2KtW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 05:49:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967012AbWK2KtW
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 05:49:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:30414 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S966882AbWK2KtV (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 05:49:21 -0500
Received: (qmail invoked by alias); 29 Nov 2006 10:49:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 29 Nov 2006 11:49:19 +0100
To: Nicholas Allen <nick.allen@onlinehome.de>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 28 Nov 2006, Nicholas Allen wrote:

> [Linus wrote...]
> > 
> > So the tools are certainly there. "git status" just isn't necessarily the 
> > best one (or the best that it could be, for that matter)..
> 
> I guess I hit a limitation in the output of status as opposed to a
> limitation in what git can do ;-)

I think it is something different altogether: you learnt how to use CVS, 
and you learnt how to use bzr, and you are now biased towards using the 
same names for the same operations in git.

I actually use git-status quite often, just before committing, to know 
what I changed. But I will probable retrain my mind to use "git diff" or 
even "git diff --stat", because it is more informative.

As for your scenario: There really should be a "what to do when my merge 
screwed up?" document.

Ciao,
Dscho
