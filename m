From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 12:20:52 -0500
Message-ID: <20070206172052.GA5135@spearce.org>
References: <20070206023111.GB9222@spearce.org> <eq9j3k$sn1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 06 18:21:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEU03-0005jg-Jg
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 18:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752262AbXBFRU4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 12:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752217AbXBFRU4
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 12:20:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42845 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752262AbXBFRUz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 12:20:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HETzr-00033W-9H; Tue, 06 Feb 2007 12:20:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5A94020FBAE; Tue,  6 Feb 2007 12:20:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <eq9j3k$sn1$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38862>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shouldn't it be:
> `filemodify`
> ^^^^^^^^^^^^
> and:
> `filedelete`
> ^^^^^^^^^^^^

Yes, thanks, its fixed.

-- 
Shawn.
