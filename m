From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] NO_PERL support
Date: Fri, 3 Apr 2009 12:18:22 -0400
Message-ID: <20090403161822.GB8155@coredump.intra.peff.net>
References: <20090403T065545Z@curie.orbis-terrarum.net> <20090403154608.GA27089@coredump.intra.peff.net> <20090403T155623Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Apr 03 18:21:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lpm8p-0000ns-IF
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 18:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935151AbZDCQSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2009 12:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934489AbZDCQSn
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Apr 2009 12:18:43 -0400
Received: from peff.net ([208.65.91.99]:38129 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934080AbZDCQSj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2009 12:18:39 -0400
Received: (qmail 32704 invoked by uid 107); 3 Apr 2009 16:18:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 03 Apr 2009 12:18:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Apr 2009 12:18:22 -0400
Content-Disposition: inline
In-Reply-To: <20090403T155623Z@curie.orbis-terrarum.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115541>

On Fri, Apr 03, 2009 at 08:59:38AM -0700, Robin H. Johnson wrote:

> I usually send as attachments, as the filename of the patch is important
> as well, and the majority of places that I submit to want attachments.
> [...]
> The text was specifically describing it for the Git community.
> [...]
> This patch was generated with format-patch years ago, but has been
> hand-tuned since.

Ah, OK. Maybe I misunderstood; I thought you were submitting this for
inclusion in upstream git. In which case things like the patch filename
would become irrelevant (and the maintainer's ability to apply via "git
am" would become relevant).

> > did not apply for me, to the current 'master' or 'next'. Furthermore,
> > the blobs they are based on aren't even present in my repo, so a 3-way
> > merge was impossible. What did you base this patch on?
> The patch applies cleanly to the 1.6.2.* tarballs.

OK, thanks.

-Peff
