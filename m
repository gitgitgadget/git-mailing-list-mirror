From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] [import-tars] fix importing of subversion tars
Date: Tue, 24 Apr 2007 12:17:49 -0400
Message-ID: <20070424161749.GR17480@spearce.org>
References: <20070424073907.GA22121@diana.vm.bytemark.co.uk> <20070424084037.GA8906@informatik.uni-freiburg.de> <20070424100924.GB23811@diana.vm.bytemark.co.uk> <20070424115104.GA14986@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:18:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgNiO-0005WW-Aa
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 18:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161792AbXDXQSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 12:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161807AbXDXQSA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 12:18:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53549 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161792AbXDXQSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 12:18:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgNhs-0005cB-SE; Tue, 24 Apr 2007 12:17:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B7FFF20FBAE; Tue, 24 Apr 2007 12:17:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070424115104.GA14986@informatik.uni-freiburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45465>

Uwe Kleine-K??nig <ukleinek@informatik.uni-freiburg.de> wrote:
> add a / between the prefix and name fields of the tar archive if prefix
> is non-empty.

Thanks, this is in my fastimport tree now.

-- 
Shawn.
