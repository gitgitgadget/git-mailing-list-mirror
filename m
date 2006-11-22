X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A documentation to-do list
Date: Wed, 22 Nov 2006 10:57:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611221044180.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 22 Nov 2006 09:57:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <6efbd9b70611211713y4a1574adje48622f7bab6d702@mail.gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32075>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmoqv-0006DG-EM for gcvg-git@gmane.org; Wed, 22 Nov
 2006 10:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755573AbWKVJ5J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 22 Nov 2006
 04:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755608AbWKVJ5J
 (ORCPT <rfc822;git-outgoing>); Wed, 22 Nov 2006 04:57:09 -0500
Received: from mail.gmx.de ([213.165.64.20]:13713 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1755573AbWKVJ5F (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 22 Nov 2006 04:57:05 -0500
Received: (qmail invoked by alias); 22 Nov 2006 09:57:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp036) with SMTP; 22 Nov 2006 10:57:03 +0100
To: Chris Riddoch <riddochc@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 21 Nov 2006, Chris Riddoch wrote:

> Having decided to take it on myself to improve Git's documentation, I
> asked on #git if people had particular things they felt I should focus
> on.

I have a request, which is not about _what_ to document, but _how_. People 
often complained about the bad introduction into git, pointing to 
http://www.selenic.com/mercurial/wiki/index.cgi/QuickStart for a "way 
better" tutorial.

It would be really, really easy to just copy that, and describe git 
instead of hg. (There is no mention of a license there, so that may not be 
allowed, but then, it is too short and obvious to be copyrightable, isn't 
it?) You will find that git commands are way shorter!

So, finally my request: we should _organize_ the documentation such that 
your average Joe Programmer is able to get started with git in 1 minute.

If she is interested in more subtle operations, then she should have a 
technical overview such as "Branching and merging with git", maybe a 
little stripped down to leave complicated (but for normal work 
uninteresting) issues out. With a pot of steaming coffee.

Finally, for complicated issues, there is Documentation/technical, the man 
pages, the source, and the git list (in that order).

Hmmm?

Ciao,
Dscho
