X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git-gui: A commit / fetch / push interface
Date: Wed, 8 Nov 2006 00:55:11 -0500
Message-ID: <20061108055511.GD28498@spearce.org>
References: <20061107083603.GB9622@spearce.org> <17745.3287.358673.265578@cargo.ozlabs.ibm.com> <45516F21.9070901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 05:55:25 +0000 (UTC)
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45516F21.9070901@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31121>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhgPC-0005B0-3k for gcvg-git@gmane.org; Wed, 08 Nov
 2006 06:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754331AbWKHFzR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 00:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbWKHFzQ
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 00:55:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44228 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754331AbWKHFzP
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 00:55:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhgP3-0001JY-EJ; Wed, 08 Nov 2006 00:55:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B678620E487; Wed,  8 Nov 2006 00:55:11 -0500 (EST)
To: Liu Yubao <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

Liu Yubao <yubao.liu@gmail.com> wrote:
> Paul Mackerras wrote:
> >Shawn Pearce writes:
> >
> >>I liked it and wanted to start making it available to some folks I
> >>work with who are more comfortable with the mouse than they are with
> >>the keyboard.  At first I tried fixing a few of the outstanding bugs
> >>in gitool but I eventually wound up rewriting the thing from scratch.
> >
> >Cool!
> >
> >>I have posted a repository with the source on pasky's service:
> >>
> >>	http://repo.or.cz/w/git-gui.git
> >
> >Shouldn't the "w" be "r" there?  It gave me an error "Can't lock ref"
> >with the "w".
>
> This it a gitweb URL, not a repos URL for 'git clone', you can only view
> it in web browser.

Too bad pasky doesn't have the magic mapping setup in the webserver
so they are one and the same.  :-)

I linked to the gitweb rather than the repository as I figured
people might want to read the history, or since it was just one
blob download it right from the webpage rather than cloning the
repository.  But given that this is the git mailing list most people
probably would have expected to clone it instead...

-- 
