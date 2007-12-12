From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] ugit: a pyqt-based git gui // was: Re: If you would write git from scratch now, what would you change?
Date: Tue, 11 Dec 2007 23:10:02 -0500
Message-ID: <20071212041002.GN14735@spearce.org>
References: <402731c90712110548k67f28b64w5afa93ee908ce73b@mail.gmail.com> <e5bfff550712111020k51829c03n5d64a94ce7c7ac2a@mail.gmail.com> <31e9dd080712111114t2bbdba60m18b7d6210f3f9174@mail.gmail.com> <e5bfff550712111133j66c4b9adx9f57661cc720aa41@mail.gmail.com> <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David <davvid@gmail.com>, Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Jason Sewall <jasonsewall@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 05:10:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Ivc-0006Qo-Gv
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 05:10:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbXLLEKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 23:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbXLLEKH
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 23:10:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39272 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbXLLEKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 23:10:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J2Iuu-0003Ec-9o; Tue, 11 Dec 2007 23:09:52 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C333420FBCB; Tue, 11 Dec 2007 23:10:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67990>

Jason Sewall <jasonsewall@gmail.com> wrote:
> Anyway, ugit is very good for a first draft; its text display beats
> whats in git-gui in a big way (and I would *hope* qt4 would beat
> Tcl/Tk at that at least).

Are you just using the wrong fonts under git-gui?  I mean both
Tk and qt4 are drawing text through your windowing system, from
the same pool of font files... if qt4 can draw nice text then
so can Tk, right?

-- 
Shawn.
