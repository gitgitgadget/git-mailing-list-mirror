From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git refuses to work with gvim
Date: Mon, 12 Oct 2009 07:13:34 -0700
Message-ID: <20091012141334.GE9261@spearce.org>
References: <20091012134312.236d250e@gzip.coli.uni-saarland.de> <vpq8wfgg4u1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sebastian@CoLi.Uni-SB.DE, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:15:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxLgV-0007WX-PB
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756759AbZJLOOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756756AbZJLOOL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:14:11 -0400
Received: from george.spearce.org ([209.20.77.23]:38229 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756745AbZJLOOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:14:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 89BF2381FF; Mon, 12 Oct 2009 14:13:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <vpq8wfgg4u1.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130013>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> The problem is that gvim returns immediately
...
> (BTW, this is in no way specific to Git, 99% applications calling
> $EDITOR will expect the same behavior)

The sad part is, every gvim user blames Git.

Every single one of my coworkers who uses Linux had gvim as their
default $EDITOR and found git commit working sometimes, and not
working others.  Since git was new to them, they blamed git, not
their $EDITOR.  They also felt insulted when I told them their
$EDITOR was busted and should be replaced.

Someone needs to whack gvim upside the head and fix that program
to behave correctly.

-- 
Shawn.
