From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2015, #08; Mon, 23)
Date: Tue, 24 Mar 2015 16:04:28 -0400
Message-ID: <20150324200428.GA29202@peff.net>
References: <xmqqmw338khu.fsf@gitster.dls.corp.google.com>
 <xmqqsicu5fl0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 21:04:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaV41-000441-6s
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 21:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbbCXUEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 16:04:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:37948 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752222AbbCXUEc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 16:04:32 -0400
Received: (qmail 25474 invoked by uid 102); 24 Mar 2015 20:04:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 15:04:32 -0500
Received: (qmail 7246 invoked by uid 107); 24 Mar 2015 20:04:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Mar 2015 16:04:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2015 16:04:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsicu5fl0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266224>

On Tue, Mar 24, 2015 at 01:02:35PM -0700, Junio C Hamano wrote:

> > * jk/test-chain-lint (2015-03-22) 28 commits
> [...]
> >  What I queued here has fix to the issue J6t found in 15/25 squashed
> >  in, and also has 26/25 and 27/25 follow-up fixes from Michael, plus
> >  28/25 follow-up from Torsten.  If everybody involved is happy with
> >  it, we can just proceed with this copy, otherwise I'll let Peff
> >  reroll.  I am happy either way.
> 
> I'll merge this to 'next' soonish, unless I hear otherwise.  I
> double checked 15/25 (i.e. $feature{"forks"}{"default"} = [1];)
> so I think we are in good shape.

Thanks, yeah, I think what you have queued is good.

-Peff
