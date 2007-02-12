From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui blametool
Date: Mon, 12 Feb 2007 14:20:04 -0500
Message-ID: <20070212192004.GB30249@spearce.org>
References: <45D07A76.1070009@gmail.com> <20070212173218.GD29621@spearce.org> <cc723f590702120936y64044ac4r86698b5d7e540bd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 20:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGgik-0001Az-VQ
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 20:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbXBLTUL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 14:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965329AbXBLTUK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 14:20:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35679 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965327AbXBLTUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 14:20:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGgiV-0006fV-LU; Mon, 12 Feb 2007 14:19:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 05A4420FBAE; Mon, 12 Feb 2007 14:20:04 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <cc723f590702120936y64044ac4r86698b5d7e540bd8@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39425>

Aneesh Kumar <aneesh.kumar@gmail.com> wrote:
> I tried the same one. I was requesting to add the commit column. Right
> now the interface is pretty confusing. After some reading of the code
> i figured out that colours have a specific meaning. May be we need to
> add a manual to the same.
> 
> but any how having commit in a column like this is really nice. I just
> sent a new patch for blameview. That should give an idea how much the
> interface looks better.

Ahhh.  I was thinking of adding it myself anyway.  Now that two
people think showing a commit column might be a good idea, I'll
add it in.

-- 
Shawn.
