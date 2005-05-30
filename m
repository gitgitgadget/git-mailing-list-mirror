From: Chris Wedgwood <cw@f00f.org>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 15:32:42 -0700
Message-ID: <972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 00:31:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcsmb-0006vl-Ro
	for gcvg-git@gmane.org; Tue, 31 May 2005 00:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVE3WdU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 18:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVE3WdP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 18:33:15 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:44165 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261794AbVE3Wcr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 18:32:47 -0400
Received: from pimout2-ext.prodigy.net (pimout2-int.prodigy.net [207.115.4.217])
	by ylpvm43.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id j4UMWrKf028481
	for <git@vger.kernel.org>; Mon, 30 May 2005 18:32:55 -0400
X-ORBL: [63.202.173.158]
Received: from taniwha.stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout2-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4UMWiM3401038;
	Mon, 30 May 2005 18:32:44 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 05140528F2D; Mon, 30 May 2005 15:32:42 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2005 at 01:00:42PM -0700, Linus Torvalds wrote:

> So before I do that, is there something people think is just too
> hard for somebody coming from the CVS world to understand? I already
> realized that the "git-write-tree" + "git-commit-tree" interfaces
> were just _too_ hard to put into a sane tutorial.

I'm still at a loss how to do the equivalent of annotate.  I know a
couple of front ends can do this but I have no idea what command line
magic would be equivalent.
