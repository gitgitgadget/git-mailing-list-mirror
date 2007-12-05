From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to jump between two repositories ...
Date: Wed, 5 Dec 2007 01:11:26 -0500
Message-ID: <20071205061125.GE14735@spearce.org>
References: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: g2 <gerald.gutierrez@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 07:11:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IznU7-0005EU-2y
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 07:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbXLEGLa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 01:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbXLEGLa
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 01:11:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42906 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbXLEGL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 01:11:29 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IznTj-0001hH-GR; Wed, 05 Dec 2007 01:11:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1F1C120FBAE; Wed,  5 Dec 2007 01:11:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <C6AF7922-B2F7-42EB-B5DD-25353BC0AF2A@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67104>

g2 <gerald.gutierrez@gmail.com> wrote:
> At this point, I wanted to push my changes back to my work repository  
> so I can continue work the next day. So at home, I did a git push. I  
> expect that my work repository has the newest material, but I find  
> that when I do "git status" at work the next day, it tells me that my  
> test.c is "modified" and has already staged it for commit. I need to  
> do a "git reset" followed by "git checkout" to update my work folder  
> to the latest stuff.

Oddly enough, this question is asked so frequently that it is
answered in the GitFaq on the GitWiki:

  http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f6e73

-- 
Shawn.
