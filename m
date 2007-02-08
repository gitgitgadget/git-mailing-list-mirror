From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] qgit4: Add a header and set the font family appropriately to the log message
Date: Thu, 8 Feb 2007 18:41:53 -0500
Message-ID: <20070208234153.GB1556@spearce.org>
References: <200702082158.56463.andyparkins@gmail.com> <200702082331.13095.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:42:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFIts-0007ow-J1
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965670AbXBHXl5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965680AbXBHXl5
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:41:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40141 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965670AbXBHXl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:41:56 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFItd-0008UB-Lu; Thu, 08 Feb 2007 18:41:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 87CEA20FBAE; Thu,  8 Feb 2007 18:41:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702082331.13095.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39129>

In case you did not already know, --numbered is a wonderful option
to git-format-patch.  It automatically numbers the commits by placing
a sequence into the subject header (e.g. [PATCH 1/3]), making it
easier for everyone to know how many patches are in your series.

-- 
Shawn.
