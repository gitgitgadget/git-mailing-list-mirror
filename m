From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 8/8] Define a basic merge API, and a two-way tree
	merge strategy
Date: Thu, 15 Jan 2009 13:09:36 -0800
Message-ID: <20090115210936.GI10179@spearce.org>
References: <1223932217-4771-1-git-send-email-spearce@spearce.org> <1223932217-4771-9-git-send-email-spearce@spearce.org> <200810232314.29867.robin.rosenberg@dewire.com> <200901152205.00600.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 22:11:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNZUY-0005PR-L5
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 22:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764047AbZAOVJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 16:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934658AbZAOVJi
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 16:09:38 -0500
Received: from george.spearce.org ([209.20.77.23]:60887 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934650AbZAOVJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 16:09:36 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0E87738210; Thu, 15 Jan 2009 21:09:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901152205.00600.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105881>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> I never got a  received reply... on this.

Sorry.  Its in my "pending" queue.  I'm still using the code
in Gerrit but I've been so swamped that I haven't been able to
look at your test case, or what's wrong with the code and why it
doesn't pass.

I honestly hoped to have something by this point, but I got behind
and I haven't quite had a chance to look at it.
 
> torsdag 23 oktober 2008 23:14:29 skrev Robin Rosenberg:
> > Hi, Shawn
> > 
> > Shouldn't testTrivialTwoWay_disjointhistories()  work?
> > 
> > The two trees have nothing in common and so should be trivially mergeable.
> > 
> > -- robin
> > 
> > From cef2695431e368da616a1e9c8de3e5e419854a4c Mon Sep 17 00:00:00 2001
> > From: Robin Rosenberg <robin.rosenberg@dewire.com>
> > Date: Thu, 23 Oct 2008 23:09:10 +0200
> > Subject: [EGIT PATCH] Simple merge test
> > 
> > ---
> >  .../org/spearce/jgit/merge/SimpleMergeTest.java    |   28 ++++++++++++++++++++
> >  1 files changed, 28 insertions(+), 0 deletions(-)
> >  create mode 100644 org.spearce.jgit.test/tst/org/spearce/jgit/merge/SimpleMergeTest.java

-- 
Shawn.
