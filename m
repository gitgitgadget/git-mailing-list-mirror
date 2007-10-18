From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pulling Already up-to-date linux-2.6 repo takes ~8 minutes?
Date: Thu, 18 Oct 2007 01:57:29 -0400
Message-ID: <20071018055729.GI14735@spearce.org>
References: <1192678865.20353.14.camel@Homer.simpson.net> <20071018045001.GA14735@spearce.org> <1192684150.7390.15.camel@Homer.simpson.net> <1192685971.7390.21.camel@Homer.simpson.net> <20071018054834.GH14735@spearce.org> <1192686882.9097.2.camel@Homer.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 07:57:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiOO9-0008DX-0f
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 07:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbXJRF5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 01:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752705AbXJRF5e
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 01:57:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:52183 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbXJRF5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 01:57:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IiONr-00005B-ET; Thu, 18 Oct 2007 01:57:27 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EBDC020FBAE; Thu, 18 Oct 2007 01:57:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1192686882.9097.2.camel@Homer.simpson.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61486>

Mike Galbraith <efault@gmx.de> wrote:
> On Thu, 2007-10-18 at 01:48 -0400, Shawn O. Pearce wrote:
> 
> > Look to see if there's anything on your current master branch that
> > you don't want/need anymore:
> > 
> > 	$ git log ..master
> 
> git trees here are meant to be absolutely virgin, so...

Whaa?  You found something that's better for manging the kernel
sources then Git?  ;-)
 
> Thanks again, I'm off my dangling limb.

Good to hear.  I hate being out on a limb and not having a rope to
climb down with.

-- 
Shawn.
