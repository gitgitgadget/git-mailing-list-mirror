From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Use NullProgressMonitor.INSTANCE and indent for
	loop
Date: Wed, 6 May 2009 13:48:49 -0700
Message-ID: <20090506204849.GM30527@spearce.org>
References: <1241642224-6914-1-git-send-email-alex.blewitt@gmail.com> <1241642224-6914-2-git-send-email-alex.blewitt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 22:49:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1o3Y-0002ZP-MW
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 22:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761779AbZEFUsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 16:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761590AbZEFUst
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 16:48:49 -0400
Received: from george.spearce.org ([209.20.77.23]:38018 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761483AbZEFUst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 16:48:49 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BE76F381CE; Wed,  6 May 2009 20:48:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241642224-6914-2-git-send-email-alex.blewitt@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118387>

Alex Blewitt <alex.blewitt@gmail.com> wrote:
> ---
>  .../src/org/spearce/jgit/lib/PackWriter.java       |   25 ++++++++++---------
>  1 files changed, 13 insertions(+), 12 deletions(-)

Also, I'd like a Signed-off-by line for your patches.  We follow
Linux kernel tradition and use a Signed-off-by line to mean
you agree to the "Developer's Certificate of Origin 1.1" (see
SUBMITTING_PATCHES in the top level directory, part 5).

For the 2 that you've submitted thus far (this one, and the make
private constructor) you can just reply to the email and drop the
SOB line into the message body.  In the future make sure you add
it in with git commit -s or git format-patch -s prior to sending.
 
-- 
Shawn.
