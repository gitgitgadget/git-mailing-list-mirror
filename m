From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH 00/31] Push GUI, GUI improvements, various jgit
	stuff
Date: Wed, 20 Aug 2008 07:13:26 -0700
Message-ID: <20080820141326.GA3483@spearce.org>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org> <200808192121.30372.robin.rosenberg.lists@dewire.com> <48AB84A2.7010905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 16:14:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVoSK-0000ht-Lo
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 16:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbYHTON2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 10:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbYHTON2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 10:13:28 -0400
Received: from george.spearce.org ([209.20.77.23]:45208 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753554AbYHTON1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 10:13:27 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AE2F938375; Wed, 20 Aug 2008 14:13:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48AB84A2.7010905@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92990>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> Actually, I'm now leaving for few days, so I'm sending out just fixes  
> for issues pointed out by Shawn and found by me in the mean time. I'll  
> squash these patches with existing commits in push branch, as it is  
> probably worth nothing to keep this in history.

Thanks.  These fixes look good to me, and they address my immediate
concerns with the series.

> BTW, as another developers are getting involved in jgit/egit coding,  
> maybe we could use (update) some wiki page for marking who is working on  
> some topic currently? Now it's not obvious for me, and as we're not so  
> numerous it would be pity to waste our time and do some redundant stuff  
> one day.

I've thought about starting a code.google.com project just to use
the issue tracking system there.  I'm using an internal tool to
keep of issues for myself, but that's not fair to the end-users or
other contributors...

-- 
Shawn.
