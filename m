From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: try to locate git in same directory as git-gui (on Windows)
Date: Sun, 7 Oct 2007 13:10:43 -0400
Message-ID: <20071007171043.GY2137@spearce.org>
References: <11916634041243-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 07 19:11:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeZea-00029o-QX
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 19:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbXJGRKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2007 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbXJGRKr
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Oct 2007 13:10:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45129 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbXJGRKq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2007 13:10:46 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IeZeI-0005cJ-EH; Sun, 07 Oct 2007 13:10:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5209120FBAE; Sun,  7 Oct 2007 13:10:43 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <11916634041243-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60204>

Steffen Prohaska <prohaska@zib.de> wrote:
> This commit adds another guess where git might be located.
> After searching PATH the last fallback is the directory
> in which git-gui is installed. This is a good guess for
> a sane installation.

Thanks.
 
-- 
Shawn.
