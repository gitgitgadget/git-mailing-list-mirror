From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: remove dots in some UI strings
Date: Mon, 3 Sep 2007 00:51:18 -0400
Message-ID: <20070903045118.GR18160@spearce.org>
References: <200709021443.00144.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 06:51:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS3uK-0000qy-FL
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 06:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbXICEvZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 00:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbXICEvZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 00:51:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47101 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXICEvY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 00:51:24 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IS3uC-0003T0-LK; Mon, 03 Sep 2007 00:51:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5CEC720FBAE; Mon,  3 Sep 2007 00:51:18 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200709021443.00144.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57428>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> Dots in a UI string usually mean that a dialog box will
> appear waiting for further input. So this patch removes
> unneeded dots for actions that do not require user's
> input.

Thanks, that's a good usability improvement.  I had already merged
the i18n work that everyone has been working on so I adjusted your
patch to apply on top of that series and pushed everything back
out in my master branch.
 
-- 
Shawn.
