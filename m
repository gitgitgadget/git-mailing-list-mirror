From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] bash completion: add --format= and --oneline
	options for "git log"
Date: Tue, 24 Feb 2009 07:39:13 -0800
Message-ID: <20090224153913.GT22848@spearce.org>
References: <94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com> <94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com> <7v3ae4r53f.fsf@gitster.siamese.dyndns.org> <20090224130626.6117@nanako3.lavabit.com> <20090224045041.GA4615@coredump.intra.peff.net> <7vprh8mm9k.fsf@gitster.siamese.dyndns.org> <20090224054524.GE4615@coredump.intra.peff.net> <20090224185913.6117@nanako3.lavabit.com> <871vtonlmv.fsf_-_@iki.fi> <87zlgcq7rq.fsf_-_@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	felipe.contreras@gmail.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzOm-000576-78
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbZBXPjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbZBXPjQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:39:16 -0500
Received: from george.spearce.org ([209.20.77.23]:42182 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbZBXPjP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:39:15 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EC64738210; Tue, 24 Feb 2009 15:39:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <87zlgcq7rq.fsf_-_@iki.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111300>

Teemu Likonen <tlikonen@iki.fi> wrote:
> We also add --format= completion for "git show".
> 
> Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
> ---
> 
> On 2009-02-24 13:02 (+0200), Teemu Likonen wrote:
> 
> > I like this change and would immediately switch to using --format= and
> > --oneline instead of --pretty=. I think we should add these bash
> > completions too.
> 
> And let's add --format= completion for "git show" too. I think --oneline
> completion is not needed with "git show" even though it works.

What version of git supports "git log --format" ?

'cause I can't find evidence that it is implemented in any current
version that Junio would apply this patch to.
 
-- 
Shawn.
