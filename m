From: Pavel Roskin <proski@gnu.org>
Subject: Re: Collecting cvsps patches
Date: Tue, 13 Jun 2006 00:35:10 -0400
Message-ID: <1150173310.15831.6.camel@dv>
References: <20060611122746.GB7766@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT list <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Tue Jun 13 06:35:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fq0cY-0005iu-3I
	for gcvg-git@gmane.org; Tue, 13 Jun 2006 06:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864AbWFMEfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 00:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932874AbWFMEfN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 00:35:13 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:32995 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932864AbWFMEfM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 00:35:12 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fq0cR-0003Ws-OZ
	for git@vger.kernel.org; Tue, 13 Jun 2006 00:35:11 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fq0cQ-0004N4-Bx; Tue, 13 Jun 2006 00:35:10 -0400
To: Yann Dirson <ydirson@altern.org>
In-Reply-To: <20060611122746.GB7766@nowhere.earth>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21767>

Hi, Yann!

On Sun, 2006-06-11 at 14:27 +0200, Yann Dirson wrote: 
> Since there are has been some work done here and there on cvsps, but
> upstream does not seem to have time to issue a new release, I have
> started to collect the patches I found.

That's great news.  Thank you!  I'm sending four patches - two compile
fixes for recent regressions and two patches fixing DNS resolution on
64-bit systems - one on Linux and the other on other OSes.

-- 
Regards,
Pavel Roskin
