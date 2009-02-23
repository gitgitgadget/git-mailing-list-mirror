From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Eclipse git workflow
Date: Mon, 23 Feb 2009 07:37:24 -0800
Message-ID: <20090223153724.GG22848@spearce.org>
References: <49A27478.4040009@metropolis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anders Gunnarsson <anders@metropolis.se>
X-From: git-owner@vger.kernel.org Mon Feb 23 16:39:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbctS-00089B-Mk
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 16:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754631AbZBWPh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 10:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754497AbZBWPh0
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 10:37:26 -0500
Received: from george.spearce.org ([209.20.77.23]:38837 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305AbZBWPh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 10:37:26 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 688AD38210; Mon, 23 Feb 2009 15:37:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49A27478.4040009@metropolis.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111140>

Anders Gunnarsson <anders@metropolis.se> wrote:
> Doues anybody have a good forkflow using the Eclipse Git Plugin?
>
> My main concerne is how to merge with ecplise.
> I can only find a fetch, but no pull or merge.

merge is not yet implemented enough within JGit to provide it
as a UI action in EGit.  And nobody has started the EGit UI
for it either.

So currently those of us using EGit do merges on the command
line, or with git-gui.

-- 
Shawn.
