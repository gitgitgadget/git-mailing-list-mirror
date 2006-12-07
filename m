X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: shallow clones, was Re: What's cooking in git.git (topics)
Date: Thu, 7 Dec 2006 15:59:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071557580.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vvekoyb79.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612070035570.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <87zma06ptm.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 14:59:47 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87zma06ptm.fsf@wine.dyndns.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33587>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKiu-0002c5-VG for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032285AbWLGO7m (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032286AbWLGO7l
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:59:41 -0500
Received: from mail.gmx.net ([213.165.64.20]:47135 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1032285AbWLGO7l
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 09:59:41 -0500
Received: (qmail invoked by alias); 07 Dec 2006 14:59:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp038) with SMTP; 07 Dec 2006 15:59:39 +0100
To: Alexandre Julliard <julliard@winehq.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 7 Dec 2006, Alexandre Julliard wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> * js/shallow (Fri Nov 24 16:00:13 2006 +0100)
> >> 
> >>  Probably with a better documentation of its limitations and caveats, 
> >>  this should be mergeable to 'master'.
> >
> > The more I see the missing reaction, the less sure I am this is a sensible 
> > thing to do.
> 
> I'm not sure what reaction you expect, but this is something a lot of 
> our occasional Wine users are requesting. The Wine full history is 80Mb, 
> and that's a big download if you just want to try a quick patch. Now of 
> course you won't see these users around here hacking on shallow clone, 
> most likely they just went and downloaded Wine from the CVS mirror 
> instead. But it's a shame to have to maintain a CVS mirror just for that 
> purpose...

Sorry, I was just mumbling about the fact that I would _like_ to hear back 
about successes and failures. If there are problems I want to fix them.

So, do you actually know of people who _used_ (as opposed to "tested") 
shallow clones?

Ciao,
Dscho
