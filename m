From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add test for rebase -i with commits that do not pass pre-commit
Date: Mon, 28 Jan 2008 21:24:45 -0500
Message-ID: <20080129022445.GG24004@spearce.org>
References: <20080128154232.900.qmail@c07ab49f5b12dd.315fe32.mid.smarden.org> <alpine.LSU.1.00.0801281632300.23907@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 03:25:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgA5-0004hO-Eo
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 03:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290AbYA2CYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 21:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752986AbYA2CYu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 21:24:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:47347 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbYA2CYu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 21:24:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJg9L-0000qy-H6; Mon, 28 Jan 2008 21:24:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6785820FBAE; Mon, 28 Jan 2008 21:24:45 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0801281632300.23907@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71917>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> This accompanies c5b09feb(Avoid update hook during git-rebase --interactive)

wtf was I smoking when I wrote that commit subject line?  Its not
the update hook we're avoiding here.  But yea, I thought this looked
like something I had worked on recently.  :)

> to prove that Debian's Bug#458782 (git-core: git-rebase doesn't work when
> trying to squash changes into commits created with --no-verify) is indeed
> fixed now.

-- 
Shawn.
