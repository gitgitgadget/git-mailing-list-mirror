From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/7] Bisect dunno
Date: Wed, 17 Oct 2007 03:35:38 -0400
Message-ID: <20071017073538.GB13801@spearce.org>
References: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 09:35:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii3Rb-0000cC-L2
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 09:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbXJQHfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 03:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751950AbXJQHfp
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 03:35:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60866 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbXJQHfo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 03:35:44 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ii3RK-0006t9-WA; Wed, 17 Oct 2007 03:35:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DC6B120FBAE; Wed, 17 Oct 2007 03:35:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071014142826.8caa0a9f.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61348>

Christian Couder <chriscool@tuxfamily.org> wrote:
> Here is my bisect dunno patch series again.
> The changes since last time are the following:

I now have this series queued in my pu branch.  It passes the tests
it comes with, and doesn't appear to break anything, but apparently
there is also still some debate about what a dunno should be called
("unknown", "void", "ugly", "dunno", "skip" ...).

-- 
Shawn.
