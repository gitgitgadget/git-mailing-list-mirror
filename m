From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Drop StGit support
Date: Mon, 8 Dec 2008 08:18:45 -0800
Message-ID: <20081208161845.GC31551@spearce.org>
References: <1228604483-30761-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 17:20:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9iq8-0002Ey-LW
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 17:20:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270AbYLHQSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 11:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYLHQSq
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 11:18:46 -0500
Received: from george.spearce.org ([209.20.77.23]:59499 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbYLHQSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 11:18:46 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 847DD38200; Mon,  8 Dec 2008 16:18:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1228604483-30761-1-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102549>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> It is slow and none of the jgit/egit developers use it.
> 
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>

Thanks.  I also fixed up the MANIFEST.MF to not export stgit package,
and removed the StGitPatch class as it isn't used anymore after
this was applied.  Both chagnes got squashed into this patch when
I applied it.

-- 
Shawn.
