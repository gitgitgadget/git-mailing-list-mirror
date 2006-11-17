X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Sean <seanlkml@sympatico.ca>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 11:34:04 -0500
Message-ID: <BAYC1-PASMTP021B5A7CD192CD4D37A152AEE80@CEZ.ICE>
References: <20061116221701.4499.qmail@science.horizon.com>
	<20061117153246.GA20065@thunk.org>
	<BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE>
	<fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 16:35:16 +0000 (UTC)
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Originating-IP: [65.93.43.81]
X-Originating-Email: [seanlkml@sympatico.ca]
Original-Message-Id: <20061117113404.810fd4ea.seanlkml@sympatico.ca>
In-Reply-To: <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 17 Nov 2006 16:34:06.0342 (UTC) FILETIME=[3316C260:01C70A66]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl6fP-0002Vt-6a for gcvg-git@gmane.org; Fri, 17 Nov
 2006 17:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933715AbWKQQeK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 11:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932946AbWKQQeK
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 11:34:10 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:60854 "EHLO
 BAYC1-PASMTP02.CEZ.ICE") by vger.kernel.org with ESMTP id S933717AbWKQQeG
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 11:34:06 -0500
Received: from linux1.attic.local ([65.93.43.81]) by BAYC1-PASMTP02.CEZ.ICE
 over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830); Fri, 17 Nov
 2006 08:34:06 -0800
Received: from guru.attic.local ([10.10.10.28]) by linux1.attic.local with
 esmtp (Exim 4.43) id 1Gl5j9-0000tv-H1; Fri, 17 Nov 2006 10:34:03 -0500
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

On Fri, 17 Nov 2006 23:19:23 +0700
"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> wrote:


> Or.. find a way to merge cogito back to git :-)
> /me runs into a nearest bush.

Pasky has already given a lot to Git, and it would be great to see even
more merged back into Git where a consensus can be reached.  In fact
Pasky has said that his plan is to push a lot more towards Git and
make Cogito a thinner UI layer.  Either way, there's absolutely nothing
wrong with people choosing to use Cogito rather than Git.  It's just
that the separate Cogito tool shouldn't have a place on the Git website
any more prominent than say StGit does.

The Git website should be a place where Git makes the best case
it can for _itself_, not for its sister tools.  It's a distraction
and gets in the way of promoting Git as a stand alone tool.  At
least one new user has complained that it was confusing.

Personally I have nothing against Cogito, I just think Pasky should
separate his role as Git webmaster from his role as Cogito author.
If people have good ideas for Git documentation, the website would be
a natural place for it, and it shouldn't have to compete with Cogito
tutorials etc.

