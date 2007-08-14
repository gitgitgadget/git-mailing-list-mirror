From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-completion.bash - add support for git-bundle
Date: Mon, 13 Aug 2007 23:39:19 -0400
Message-ID: <20070814033919.GD27913@spearce.org>
References: <11869443722087-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Aug 14 05:39:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKnFf-0004gr-IN
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 05:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753379AbXHNDjY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 23:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753699AbXHNDjX
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 23:39:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53244 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657AbXHNDjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 23:39:23 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IKnFN-0007z0-4Y; Mon, 13 Aug 2007 23:39:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8206D20FBAE; Mon, 13 Aug 2007 23:39:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11869443722087-git-send-email-mdl123@verizon.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55801>

Mark Levedahl <mdl123@verizon.net> wrote:
> Signed-off-by: Mark Levedahl <mdl123@verizon.net>
> ---
>  contrib/completion/git-completion.bash |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)

Thanks!  Its applied locally, I'll ask Junio to pull it shortly,
along with a few updates for fast-import that have been lagging
behind the main tree for some time.
 
-- 
Shawn.
