From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement git-staged, an alias for 'git diff --cached'.
Date: Wed, 29 Oct 2008 11:19:57 -0400
Message-ID: <20081029151956.GA28598@segfault.peff.net>
References: <1225237145-95435-1-git-send-email-dsymonds@gmail.com> <1225238368-98594-1-git-send-email-dsymonds@gmail.com> <20081029003931.GA7291@sigill.intra.peff.net> <20081029010107.GB12065@leksak.fem-net> <20081029010534.GA8833@sigill.intra.peff.net> <HUCQtsE3HvgGu_KDktGNx0KyijzaFKOESHnzFagEbf4erQlMxjgVNQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stephan Beyer <s-beyer@gmx.net>,
	David Symonds <dsymonds@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Oct 29 16:21:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvCrD-0002Ro-7W
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 16:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbYJ2PT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 11:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752668AbYJ2PT7
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 11:19:59 -0400
Received: from peff.net ([208.65.91.99]:1488 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752621AbYJ2PT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 11:19:58 -0400
Received: (qmail 28612 invoked by uid 1000); 29 Oct 2008 15:19:57 -0000
Content-Disposition: inline
In-Reply-To: <HUCQtsE3HvgGu_KDktGNx0KyijzaFKOESHnzFagEbf4erQlMxjgVNQ@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99370>

On Wed, Oct 29, 2008 at 09:33:08AM -0500, Brandon Casey wrote:

> > You are missing some of the context,
> 
> Yeah, it would have been nice if there was audio.
> Anyone take minutes, possibly?

There's no audio. Some of the slides will be available. I took notes on
at least one of the discussions, which I will try to summarize and post.
And I think some of the discussion will end up as patches, which will
hopefully provide full justification in their commit messages. ;)

-Peff
