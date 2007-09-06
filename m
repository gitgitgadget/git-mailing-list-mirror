From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Include a git-push example for creating a remote branch
Date: Thu, 6 Sep 2007 01:01:27 -0400
Message-ID: <20070906050127.GS18160@spearce.org>
References: <20070906044408.GA588@spearce.org> <buoodggo0l2.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 07:01:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9Uo-0006zQ-Do
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 07:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbXIFFBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 01:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXIFFBe
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 01:01:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39728 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbXIFFBd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 01:01:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT9Uf-0003s0-AS; Thu, 06 Sep 2007 01:01:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E863B20FBAE; Thu,  6 Sep 2007 01:01:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <buoodggo0l2.fsf@dhapc248.dev.necel.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57818>

Miles Bader <miles.bader@necel.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > Many users get confused when `git push origin master:foo` works
> > when foo already exists on the remote repository but are confused
> > when foo doesn't exist as a branch and this form does not create
> > the branch foo.
> 
> Hmm, what _does_ it do in that case...?

error: dst refspec experimental does not match any existing ref on the remote and does not start with refs/.

-- 
Shawn.
