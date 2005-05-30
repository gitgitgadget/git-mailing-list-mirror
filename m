From: Chris Wedgwood <cw@f00f.org>
Subject: Re: I want to release a "git-1.0"
Date: Mon, 30 May 2005 16:56:33 -0700
Message-ID: <526551.b8e690d40dd297a911bca6b35fc0dd2e.ANY@taniwha.stupidest.org>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> <972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 01:55:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcu5S-0005JN-EF
	for gcvg-git@gmane.org; Tue, 31 May 2005 01:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVE3X4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 19:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVE3X4q
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 19:56:46 -0400
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:20440 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261739AbVE3X4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 19:56:39 -0400
Received: from taniwha.stupidest.org (adsl-63-202-173-158.dsl.snfc21.pacbell.net [63.202.173.158])
	by pimout4-ext.prodigy.net (8.12.10 milter /8.12.10) with ESMTP id j4UNuYPA189856;
	Mon, 30 May 2005 19:56:34 -0400
Received: by taniwha.stupidest.org (Postfix, from userid 38689)
	id 01FD1528F2D; Mon, 30 May 2005 16:56:33 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, May 30, 2005 at 03:32:42PM -0700, Chris Wedgwood wrote:

> I'm still at a loss how to do the equivalent of annotate.  I know a
> couple of front ends can do this but I have no idea what command line
> magic would be equivalent.

A few people asked what does this now.  Git Tracker does, a (random)
example of which might be:

  http://www.tglx.de/cgi-bin/gittracker/annotate/tracker-linux/torvalds/linux-2.6.git/mm/mmap.c?blob=de54acd9942f9929004921042721df5cdfe2b6c7
