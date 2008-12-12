From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH] Fix typos in comments / testcase output
Date: Fri, 12 Dec 2008 07:30:25 -0800
Message-ID: <20081212153025.GN32487@spearce.org>
References: <1229079357-19167-1-git-send-email-mike@abacus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Mike Ralphson <mike@abacus.co.uk>
X-From: git-owner@vger.kernel.org Fri Dec 12 16:32:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LB9zW-0003Ly-Lc
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 16:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757131AbYLLPa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 10:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756789AbYLLPa1
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 10:30:27 -0500
Received: from george.spearce.org ([209.20.77.23]:57281 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341AbYLLPa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 10:30:27 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id C30DB38200; Fri, 12 Dec 2008 15:30:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1229079357-19167-1-git-send-email-mike@abacus.co.uk>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102903>

Mike Ralphson <mike@abacus.co.uk> wrote:
> Signed-off-by: Mike Ralphson <mike@abacus.co.uk>

Thanks, I've applied this change, and the README correction you
noted but didn't send a patch for.  :-)

> Is it me, or is the actual maintainer of JGIT/EGIT not actually
> mentioned anywhere? Apologies if I've got the to and cc round
> the wrong way 8-)

Robin and I run JGit and EGit as a dual-maintainer approach.
We both have write access to the master repository and we apply
each other's patches rather than push directly ourselves.  It
helps keep us from cutting corners.

Although I just broke that rule by pushing my own patch to README
and my own patch to SUBMITTING_PATCHES to address the other points
you raised, but these are two auxiliary documents that we don't
pay much attention to, hence they have fallen into disarray... :-\

-- 
Shawn.
