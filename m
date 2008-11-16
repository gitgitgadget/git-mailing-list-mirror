From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH (GIT-GUI) v2 0/5] Add a customizable Tools menu.
Date: Sun, 16 Nov 2008 13:56:15 -0800
Message-ID: <20081116215615.GE2932@spearce.org>
References: <1226861211-16995-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 22:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1pcd-0005UX-Q5
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 22:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbYKPV4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 16:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908AbYKPV4Q
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 16:56:16 -0500
Received: from george.spearce.org ([209.20.77.23]:39046 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752499AbYKPV4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 16:56:16 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7447D381FF; Sun, 16 Nov 2008 21:56:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226861211-16995-1-git-send-email-angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101165>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> This series adds a customizable Tools menu, that can
> be used to call any external commands from Git Gui.
> It reduces the inconvenience of using tools like git-svn
> with GUI, by removing the need to jump between the
> terminal and the GUI even for simple actions. QGit
> already has a similar feature.

Thanks.  This is really slick.  Its in my tree now.

Given that 1.6.1 is entering rc mode, I'm probably not going to be
accepting any more new features into my master branch until 1.6.1
freezes.  Everything after this will wind up in `pu` until I cut
git-gui 0.12.0.
 
-- 
Shawn.
