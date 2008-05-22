From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Thu, 22 May 2008 08:12:11 -0400
Message-ID: <20080522121211.GL29038@spearce.org>
References: <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org> <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com> <20080520201722.GF29038@spearce.org> <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com> <20080520203153.GH29038@spearce.org> <7v3aoc8xtg.fsf@gitster.siamese.dyndns.org> <20080521024126.GI29038@spearce.org> <alpine.DEB.1.00.0805210930150.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, sverre@rabbelier.nl,
	Dirk =?utf-8?Q?S=C3=BCsserott?= <newsletter@dirk.my1.cc>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 22 14:13:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz9fT-0006bw-2S
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 14:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761169AbYEVMMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 08:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761151AbYEVMMT
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 08:12:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47797 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761069AbYEVMMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 08:12:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jz9eT-0002YO-6A; Thu, 22 May 2008 08:12:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 055A620FBAE; Thu, 22 May 2008 08:12:12 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805210930150.30431@racer>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82617>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 20 May 2008, Shawn O. Pearce wrote:
> > 
> > Well, we do have GIT_TRACE, and git-gui --trace is sort of the
> > same idea.  :-)
> 
> Which brings me to the suggestion to reuse GIT_TRACE instead of adding 
> an option...

Well... you may not want to see what GIT_TRACE causes, but you
do want to see what `git gui --trace` gives you.  So I didn't
want to overload it.

-- 
Shawn.
