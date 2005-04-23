From: Chris Wedgwood <cw@f00f.org>
Subject: Re: Humble request of 'git' developers
Date: Sat, 23 Apr 2005 13:02:46 -0700
Message-ID: <20050423200246.GA5448@taniwha.stupidest.org>
References: <426AA8E2.60403@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 21:59:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPQly-0002r4-PT
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 21:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVDWUDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 16:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVDWUDK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 16:03:10 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:53660 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S261759AbVDWUCy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 16:02:54 -0400
Received: from pimout2-ext.prodigy.net (pimout2-ext.prodigy.net [207.115.63.101])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j3NK2qcm031723
	for <git@vger.kernel.org>; Sat, 23 Apr 2005 16:02:52 -0400
X-ORBL: [67.124.119.21]
Received: from taniwha.stupidest.org (adsl-67-124-119-21.dsl.snfc21.pacbell.net [67.124.119.21])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j3NK2pSX054528;
	Sat, 23 Apr 2005 16:02:51 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id C468C115C859; Sat, 23 Apr 2005 13:02:46 -0700 (PDT)
To: Jeff Garzik <jgarzik@pobox.com>
Content-Disposition: inline
In-Reply-To: <426AA8E2.60403@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2005 at 03:58:26PM -0400, Jeff Garzik wrote:

> Please stop filling up my /usr/local/bin :)

why?

> Just have one 'git' script, which looks in /usr/local/libexec/git
> for further scripts and backends programs like write-tree and
> diff-cache.

how is that really any better?

> Also, please don't assume that "." is in PATH.  I think there is at
> least one invocation of commit-id with that assumption, in
> git-pasky-0.6.3.

That I'll buy.  I don't know of anyone who places "." in PATH.
