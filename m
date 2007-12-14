From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Move frequently used commands to the top of the context menu.
Date: Fri, 14 Dec 2007 01:32:17 -0500
Message-ID: <20071214063217.GG14735@spearce.org>
References: <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com> <Pine.LNX.4.64.0712121814260.27959@racer.site> <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com> <Pine.LNX.4.64.0712121931050.27959@racer.site> <7vhcin3rv4.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0712131248500.27959@racer.site> <47613BA6.1060705@viscovery.net> <Pine.LNX.4.64.0712131417110.27959@racer.site> <47614419.3050604@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Jason Sewall <jasonsewall@gmail.com>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J347F-0003xt-Gk
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759825AbXLNGc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 01:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756551AbXLNGc1
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:32:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37821 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759521AbXLNGc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:32:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J345r-0004R0-Ck; Fri, 14 Dec 2007 01:32:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0BA3220FBAE; Fri, 14 Dec 2007 01:32:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47614419.3050604@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68245>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> "Stage/Unstage Hunk" is probably the most frequently used command of the
> patch context menu *and* it is not available in some other form than
> the context menu. Therefore, it should go to the top. "Less Context" and
> "More Context" entries are also not easily available otherwise, and are
> therefore, moved second. The other entries are available via key strokes
> (Copy, Paste, Refresh) or rarly used (Font Size, Options) and can go last.

Thanks.  This will be in my repo.or.cz tree shortly.

-- 
Shawn.
