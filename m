From: Shawn Pearce <spearce@spearce.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 01:21:56 -0400
Message-ID: <20060907052155.GA31580@spearce.org>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitzilla@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 07:22:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLCL0-0003m4-Cp
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 07:22:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWIGFWB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 01:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWIGFWA
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 01:22:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:14537 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751820AbWIGFWA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 01:22:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GLCKs-0007Jv-AW; Thu, 07 Sep 2006 01:21:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 52A67212693; Thu,  7 Sep 2006 01:21:56 -0400 (EDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26592>

Jon Smirl <jonsmirl@gmail.com> wrote:
> Shawn is doing some prototype work on true dictionary based
> compression. I don't know how far along he is but it has potential for
> taking 30% off the Mozilla pack.

Not very far.  I've put some work into it but got distracted by the
sliding mmap window bit.  So I don't have anything worth sharing yet.
Which is why I've been quiet on the subject.  :-)

-- 
Shawn.
