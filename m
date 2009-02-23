From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] [PATCH 2/2] Make sure to set up the default (pull)
	remote branch for master
Date: Mon, 23 Feb 2009 08:47:33 -0800
Message-ID: <20090223164733.GN22848@spearce.org>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl> <e26eb3c2a7a0ce2b96252f00c17a62913d741579.1235228532.git.ferry.huberts@pelagic.nl> <20090223160957.GK22848@spearce.org> <49A2CB47.6050303@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 23 17:49:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdzL-0001vs-4F
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbZBWQrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZBWQrf
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:47:35 -0500
Received: from george.spearce.org ([209.20.77.23]:34373 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbZBWQrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:47:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id AF7FB38210; Mon, 23 Feb 2009 16:47:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49A2CB47.6050303@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111156>

"Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl> wrote:
> Shawn O. Pearce wrote:
> > Shouldn't this be "branch" and not "Constants.MASTER" ?
> 
> yep. missed that. want a new patch? afaic you can patch that up yourself :-)

Yes, new patch.  Its a large rewrite of what you had otherwise
submitted.  Much easier on the maintainers if we don't have to
do such things... plus the attribution is more correct, its you
that did the rewrite, not us.  :)

-- 
Shawn.
