From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Trivia: When did git self-host?
Date: Mon, 26 Feb 2007 18:57:30 -0500
Message-ID: <20070226235730.GG1639@spearce.org>
References: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 00:57:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLpir-0001dV-DX
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 00:57:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161427AbXBZX5e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 18:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161420AbXBZX5e
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 18:57:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36257 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161427AbXBZX5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 18:57:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLpic-0006Ql-96; Mon, 26 Feb 2007 18:57:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DEEE220FBAE; Mon, 26 Feb 2007 18:57:30 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40675>

Mike Coleman <tutufan@gmail.com> wrote:
> Does anyone recall when git first self-hosted?  This doesn't seem to
> be present on the GitHistory page on the wiki, and I'm not finding it
> elsewhere.
> 
> I suppose this could mean different things, but roughly I'm curious
> about the earliest point at which all further commits were
> human-generated, in real time, as opposed to the machine-generated
> commits of some robo-import script.  I'm not seeing this transition in
> the git-log, which seems to go continuously back to the very beginning
> (which is a little disturbing :-).

I think it was day 1.  One of Linus' goals was to have something
that could track itself, as that meant he was on the right path...
I think he worked about 8 hours or so on Git code before he was
able to actually commit something, and about that point he wanted to
commit.  And that is commit e83c5163316f89bfbde7d9ab23ca2e25604af290.
Yes, the beginning of history.

I've heard that Linus is a very good developer.  ;-)

-- 
Shawn.
