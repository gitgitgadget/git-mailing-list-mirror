From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGit Patch v2 5/7] Add script for adding second pack for test
	purpose
Date: Thu, 21 Aug 2008 08:12:52 -0700
Message-ID: <20080821151252.GS3483@spearce.org>
References: <1219288394-1241-1-git-send-email-imyousuf@gmail.com> <1219288394-1241-2-git-send-email-imyousuf@gmail.com> <1219288394-1241-3-git-send-email-imyousuf@gmail.com> <1219288394-1241-4-git-send-email-imyousuf@gmail.com> <1219288394-1241-5-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Thu Aug 21 17:20:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWBrK-0001N3-86
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 17:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbYHUPMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 11:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754935AbYHUPMx
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 11:12:53 -0400
Received: from george.spearce.org ([209.20.77.23]:48835 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728AbYHUPMw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 11:12:52 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0969C38375; Thu, 21 Aug 2008 15:12:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1219288394-1241-5-git-send-email-imyousuf@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93164>

imyousuf@gmail.com wrote:
> From: Imran M Yousuf <imyousuf@smartitengineering.com>
> 
> Forgot to add it last time and thus adding it before removing duplicate
> resources.

I would squash this to the one that copies the other resources.
 
>  1 files changed, 0 insertions(+), 0 deletions(-)
>  copy org.spearce.jgit.test/{tst => tst-rsrc/org/spearce/jgit/test/resources}/create-second-pack (100%)

-- 
Shawn.
