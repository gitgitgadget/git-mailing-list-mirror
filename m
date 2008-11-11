From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 6/7] Add tags to the graphical history display.
Date: Tue, 11 Nov 2008 10:32:48 -0800
Message-ID: <20081111183248.GR2932@spearce.org>
References: <1226095664-13759-1-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-2-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-3-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-4-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-5-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-6-git-send-email-robin.rosenberg@dewire.com> <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:34:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzy3v-0006m4-Rd
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 19:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbYKKSct (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 13:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbYKKSct
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 13:32:49 -0500
Received: from george.spearce.org ([209.20.77.23]:38239 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYKKScs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 13:32:48 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 19CB1381FF; Tue, 11 Nov 2008 18:32:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1226095664-13759-7-git-send-email-robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100669>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Both the SWT (Eclipse) drawing and Swing versions are updated.
> The coloring and shapes are intentionally not the same as for gitk.

Despite my comments about the series, I really like the rendering
in SWT.  I'm looking forward to getting this in-tree, but I would
like to get a better definition of the Ref peeling API.
 
-- 
Shawn.
