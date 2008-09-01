From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git gui: show diffs with a minimum of 1 context line
Date: Mon, 1 Sep 2008 12:47:29 -0700
Message-ID: <20080901194729.GI7482@spearce.org>
References: <20080830164527.GA25370@localhost> <20080901193359.GG7482@spearce.org> <20080901194141.GA10853@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Sep 01 21:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaFPC-00046h-0D
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 21:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbYIATra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbYIATra
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 15:47:30 -0400
Received: from george.spearce.org ([209.20.77.23]:48328 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbYIATr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 15:47:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0DEA538375; Mon,  1 Sep 2008 19:47:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080901194141.GA10853@localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94607>

Clemens Buchacher <drizzd@aon.at> wrote:
> Actually, if you don't mind, I changed the commit message because 'git
> apply' is not really to blame here:
> 
> Staging hunks without context does not work, because line number
> information would have to be recomputed for individual hunks.  Since it is
> already possible to stage individual lines using 'Stage Line for Commit',
> zero context diffs are not really necessary for git gui, however.

Thanks, message updated.

-- 
Shawn.
