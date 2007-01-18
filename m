From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Document the master@{n} reflog query syntax.
Date: Wed, 17 Jan 2007 21:50:03 -0500
Message-ID: <20070118025003.GC23124@spearce.org>
References: <20070118020804.GA23488@spearce.org> <Pine.LNX.4.64.0701171829240.27034@elephant.stardot-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 03:50:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7NM7-0000wx-TZ
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 03:50:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbXARCuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 21:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbXARCuL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 21:50:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58701 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbXARCuK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 21:50:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7NLd-0005yF-Tj; Wed, 17 Jan 2007 21:49:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D99020FBAE; Wed, 17 Jan 2007 21:50:03 -0500 (EST)
To: Jim Treadway <jim@stardot-tech.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701171829240.27034@elephant.stardot-tech.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37060>

Jim Treadway <jim@stardot-tech.com> wrote:
> On Wed, 17 Jan 2007, Shawn O. Pearce wrote:
> >-  of the ref at a prior point in time.  This suffix may only be
> >+  of the ref at a prior point in time.This suffix may only be
> 
> I'm guessing that the above was unintentional?

Yes.  Danngit.  Junio, can you hand edit that patch?

-- 
Shawn.
