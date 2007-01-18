From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 11:51:08 -0500
Message-ID: <20070118165107.GF15428@spearce.org>
References: <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com> <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net> <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net> <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com> <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com> <20070118154257.GC15428@spearce.org> <45AFA083.9050004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Josh Boyer <jwboyer@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 17:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7aTt-00008G-Vp
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 17:51:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbXARQvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 11:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXARQvQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 11:51:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56337 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbXARQvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 11:51:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7aTg-0000OZ-2L; Thu, 18 Jan 2007 11:51:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 14A5220FBAE; Thu, 18 Jan 2007 11:51:08 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45AFA083.9050004@op5.se>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37122>

Andreas Ericsson <ae@op5.se> wrote:
> Would a +46-31 number work? If so, you could give me a call when you're
> having trouble. I'd probably end up asking the list, or bribing Junio
> with beer to answer for me, but the fee would be low (how much is a
> dozen beers in Japan?), so perhaps it'd be worth it ;-)

Heh.  The thing is, with me "on staff" I doubt you can get much
better support.  I know Git very well, almost as well as Linus,
Junio, Nico, and Johannes (sorry, no particular order there).
What I don't know off the top of my head, I know where the source
code for it is, and I can read and understand it rather quickly.

When something breaks, I can usually fix it myself, and that usually
results in a patch to Junio just hours after I discover the problem.
Most of the time the patch is worthy of inclusion and Junio picks
it up.  You can't get that kind of response from a commerical vendor,
at least not without forking over bucket loads of cash first.

The problem is, the organization has strict rules about recommending
yourself as a vendor.  But recommending a guy half way around the
world who works for beer is probably in compliance.  :-)
 
> On a serious note, it's probably about time the world saw its first
> commercial git support company. It's legal to package and sell GPL'd
> code. Many companies have already proven that it can be a very
> lucrative business.

I've thought about doing this myself.  I'm just so short on time
that developing a business providing support would probably push me
way over the edge.  Ideally I'd love to have such a venture make its
money off support contracts and a small markup on dead-tree forms of
open-source Git documentation.  I'd also love to see such a venture
be able to support a Git developer or two full-time, making sure that
all of their work is getting folded back into the main git.git tree.
Which of course implies they can't be heading off in directions
that the rest of the group finds useless/pointless/stupid/etc.

Wishful thinking.  Back to reality.

-- 
Shawn.
