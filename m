From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] bash completion: add --format= and --oneline
	options for "git log"
Date: Tue, 24 Feb 2009 07:57:24 -0800
Message-ID: <20090224155724.GV22848@spearce.org>
References: <7v3ae4r53f.fsf@gitster.siamese.dyndns.org> <20090224130626.6117@nanako3.lavabit.com> <20090224045041.GA4615@coredump.intra.peff.net> <7vprh8mm9k.fsf@gitster.siamese.dyndns.org> <20090224054524.GE4615@coredump.intra.peff.net> <20090224185913.6117@nanako3.lavabit.com> <871vtonlmv.fsf_-_@iki.fi> <87zlgcq7rq.fsf_-_@iki.fi> <20090224153913.GT22848@spearce.org> <878wnvbzvd.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	felipe.contreras@gmail.com
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzgN-0004Vw-Ru
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbZBXP50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755588AbZBXP50
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:57:26 -0500
Received: from george.spearce.org ([209.20.77.23]:41805 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbZBXP5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:57:25 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 25D4E38210; Tue, 24 Feb 2009 15:57:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <878wnvbzvd.fsf@iki.fi>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111305>

Teemu Likonen <tlikonen@iki.fi> wrote:
> On 2009-02-24 07:39 (-0800), Shawn O. Pearce wrote:
> >
> > What version of git supports "git log --format" ?
> >
> > 'cause I can't find evidence that it is implemented in any current
> > version that Junio would apply this patch to.
> 
> This is meant to be a part of Nanako's patch series:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/111278

Oh, sorry.  I don't use a threaded client so I missed the
fact this was attached to her series.

Looks good to me.

Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
