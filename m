X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Cleaning up git user-interface warts
Date: Fri, 17 Nov 2006 00:00:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611162353250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 23:00:54 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31631>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkqDX-0003sW-QF for gcvg-git@gmane.org; Fri, 17 Nov
 2006 00:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755490AbWKPXAU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 18:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755491AbWKPXAU
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 18:00:20 -0500
Received: from mail.gmx.de ([213.165.64.20]:60586 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755490AbWKPXAT (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 18:00:19 -0500
Received: (qmail invoked by alias); 16 Nov 2006 23:00:18 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp027) with SMTP; 17 Nov 2006 00:00:18 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 15 Nov 2006, Linus Torvalds wrote:

> Peopel seem to believe that changign a few names or doing other totally 
> _minimal_ UI changes would somehow magically make things understandable. 

Never ever underestimate pet peeves. If we give many people an obvious 
reason (however trivial and bike-shed-coloured) to complain, they will 
complain.

If we pull (pun intended) that reason away under their collective 
backsides, they will have to find another reason to complain. But by the 
time they found something, they will already be happy git users!

But since you just provided a patch to make life easier on non-gitters, I 
guess you agree with that already.

And hopefully you also agree that enhancing the syntax of git-merge to 
grok "git-merge [-m message] <branch>" and "git-merge [-m message] 
<url-or-remote> <branch>" would be a lovely thing, luring even more 
people into using git.

Maybe they even start complaining about subversion and CVS calling a merge 
"update", who knows?

Ciao,
Dscho
