From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Qt git repository report
Date: Wed, 31 Jan 2007 10:42:08 -0500
Message-ID: <20070131154208.GB21888@spearce.org>
References: <200701310912.59102.andyparkins@gmail.com> <204011cb0701310234k4cb87eadhcf8669e364be4d6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 16:44:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCHbE-0005oS-Hh
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 16:42:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861AbXAaPmN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 10:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932933AbXAaPmN
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 10:42:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52253 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861AbXAaPmM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 10:42:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCHb2-0003JW-Ge; Wed, 31 Jan 2007 10:42:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5B92220FBAE; Wed, 31 Jan 2007 10:42:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <204011cb0701310234k4cb87eadhcf8669e364be4d6@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38262>

Chris Lee <clee@kde.org> wrote:
> Of course, nobody outside of Trolltech happens to have access to the
> Trolltech p4 depot, however... if you happen to use p4 internally
> (like Trolltech) and you wanted to try out the same script, you could
> clone:
> 
> git://repo.or.cz/fast-export.git

Its nice to see the 'inline' spec is useful.  :-)

We may actually have a decent little set of importers backed by gfi
real-soon-now, which would help the argument to merge gfi into the
main git.git repository post 1.5.0.

-- 
Shawn.
