From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] Java Git (aka jgit) has switched to 3-clause BSD
Date: Wed, 28 May 2008 19:26:39 -0400
Message-ID: <20080528232639.GN30245@spearce.org>
References: <20080526044640.GB30245@spearce.org> <483BFA8D.30309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Florian =?utf-8?Q?K=C3=B6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Thu May 29 01:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1V3O-0001be-3W
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 01:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754469AbYE1X0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754474AbYE1X0m
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 19:26:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38930 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754433AbYE1X0m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 19:26:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1K1V2M-00017F-Mp; Wed, 28 May 2008 19:26:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2928420FBAE; Wed, 28 May 2008 19:26:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <483BFA8D.30309@web.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83147>

Florian Kberle <FloriansKarten@web.de> wrote:
> 
> will you convert my last patches (v3) too, or do I have to do it manually?

I'll convert them for you.  Its a simple script and it can be
run multiple times without affecting already converted files.
You could also run it yourself as a final series-end commit by
taking the script out of my commit message in my "bsd" branch.
 
> It would be cool if you would accept or comment my last patches.

Yea, sorry I have been slacking on that since you posted them.
I still have them in my inbox for me to go through but I've been
quite busy the past few days and haven't had the time needed to
really give them the good reading they deserve.  I'll try to do
it soon.  Probably this weekend.
 
-- 
Shawn.
