From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT] In the commit dialog, deal with Signed-off-by not
	on the last line
Date: Wed, 18 Feb 2009 09:01:16 -0800
Message-ID: <20090218170116.GC22848@spearce.org>
References: <4993DBF0.8070901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git <git@vger.kernel.org>
To: Yann Simon <yann.simon.fr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 18:02:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZpot-0003Fh-Cf
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 18:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbZBRRBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 12:01:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753385AbZBRRBS
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 12:01:18 -0500
Received: from george.spearce.org ([209.20.77.23]:44528 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbZBRRBR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 12:01:17 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EA5A5381FF; Wed, 18 Feb 2009 17:01:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4993DBF0.8070901@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110558>

Yann Simon <yann.simon.fr@gmail.com> wrote:
> The previous implementation made the assumption that
> the Signed-off-by is always on the last line.
> 
> Correct this assumption and deal with Signed-off-by everywhere in
> the commit message.
> 
> Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
> ---
>  .../egit/ui/internal/dialogs/CommitDialog.java     |   65
> ++++++++++++--------
>  1 files changed, 40 insertions(+), 25 deletions(-)

This patch is whitespace damaged and can't be applied by machine.
 
> diff --git
> a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
> b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
> index bbe7193..403d69d 100644
> ---
> a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
> +++
> b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java

-- 
Shawn.
