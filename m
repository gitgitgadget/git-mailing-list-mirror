From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] Add "stg bury" command, with the functionnality of contrib/stg-sink.
Date: Wed, 18 Apr 2007 22:35:02 +0200
Message-ID: <20070418203502.GA8524@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth> <4625DDA5.60503@vilain.net> <Pine.LNX.4.64.0704181130330.30721@reaper.quantumfyre.co.uk> <200704182219.26410.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Sam Vilain <sam@vilain.net>, Junio C Hamano <junkio@cox.net>,
	Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:36:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeGt1-0006cF-Ng
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 22:36:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992592AbXDRUgQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 16:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992618AbXDRUgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 16:36:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:38809 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992592AbXDRUgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 16:36:16 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DB2A85DFE2;
	Wed, 18 Apr 2007 22:36:13 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8E9031F06B; Wed, 18 Apr 2007 22:35:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200704182219.26410.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44942>

On Wed, Apr 18, 2007 at 10:19:26PM +0200, Robin Rosenberg wrote:
> > I can't really think of a single metaphor where float and bury are both 
> > appropriate though.
> 
> The stack is transparent, so the "float" comes from thinking of the stack as a 
> column (glass pillar) of water with things in it. So I wanted to float patches. I
> didn't think too much about the name, it just popped out. At least that is what
> I *think* I was thinking at the time.
> 
> The logical opposide thing is to "sink" things you don't work to work on.  "bury" 
> implies  you don't see things, which just isn't true.

Indeed, I originally planned to name it "sink", as the prototype
script.  It is when starting to write the documentation, that I
started to feel like writing "sink: bury patches down the stack", and
felt there was something wrong.  Since I could not find a plausible
description involving "sink", I finally went for "stg bury", although
I was not very pleased with it.

But if the consensus is that "sink" or something else sounds better, I
have myself no objection to bury "bury" :)

Best regards,
-- 
Yann.
