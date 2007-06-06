From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] New selection indication and softer colors
Date: Wed, 6 Jun 2007 01:24:42 -0400
Message-ID: <20070606052442.GG9513@spearce.org>
References: <11810802023668-git-send-email-mmelchior@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthijs Melchior <mmelchior@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Jun 06 07:24:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvo0p-0004Ab-R0
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 07:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbXFFFYs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 01:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbXFFFYr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 01:24:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41814 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758012AbXFFFYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 01:24:47 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1Hvo0i-0001Wl-SZ; Wed, 06 Jun 2007 01:24:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2E93120FBAE; Wed,  6 Jun 2007 01:24:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11810802023668-git-send-email-mmelchior@xs4all.nl>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49247>

Matthijs Melchior <mmelchior@xs4all.nl> wrote:
> The default font was already bold, so marking the selected file with bold
> font did not work.  Change that to lightgray background.
> Also, the header colors are now softer, giving better readability.

Thanks, this is actually kind of nice.  I've applied it to my
maint and pushed it out.  I feel a gitgui-0.7.3 coming real soon
(maint has 8 new commits on it already).

-- 
Shawn.
