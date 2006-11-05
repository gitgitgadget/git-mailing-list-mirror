X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Bash completion Issue?
Date: Sat, 4 Nov 2006 23:28:49 -0500
Message-ID: <20061105042849.GA3840@spearce.org>
References: <200611041236.59989.alan@chandlerfamily.org.uk> <20061104184120.GB2311@spearce.org> <200611050033.07716.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 5 Nov 2006 04:29:09 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611050033.07716.alan@chandlerfamily.org.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30945>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgZd0-0007Gr-HC for gcvg-git@gmane.org; Sun, 05 Nov
 2006 05:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965838AbWKEE2z (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 23:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965839AbWKEE2y
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 23:28:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:14268 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965838AbWKEE2y
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 23:28:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgZce-0006LH-5S; Sat, 04 Nov 2006 23:28:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5053220E491; Sat,  4 Nov 2006 23:28:50 -0500 (EST)
To: Alan Chandler <alan@chandlerfamily.org.uk>
Sender: git-owner@vger.kernel.org

Alan Chandler <alan@chandlerfamily.org.uk> wrote:
> Well I have something like this (with git 1.4.3.3)
> 
> # 'git' bash completion and library routines used by porcelain completions.
> #
> # Copyright (c) Paolo Giarrusso, 2005
> # Copyright (c) Ben Clifford, 2005
> #
> # The master version is available at:
> #       http://www.hawaga.org.uk/gitcompletion.git

Maybe you can nicely ask the Debian maintainer to switch to using
use the completion script that is actually shipped with git 1.4.3.3?

-- 
