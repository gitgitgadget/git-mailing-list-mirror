From: Yann Dirson <ydirson@altern.org>
Subject: Re: Collecting cvsps patches
Date: Fri, 16 Jun 2006 23:34:42 +0200
Message-ID: <20060616213442.GO7766@nowhere.earth>
References: <20060611122746.GB7766@nowhere.earth> <1150173310.15831.6.camel@dv> <20060613095445.GM1297@nowhere.earth> <448EC1C6.5060902@dm.cobite.com> <20060613151504.GN1297@nowhere.earth> <Pine.LNX.4.64.0606130841200.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Mansfield <centos@dm.cobite.com>,
	Pavel Roskin <proski@gnu.org>, GIT list <git@vger.kernel.org>,
	cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Fri Jun 16 23:34:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrLxN-0000v1-FN
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 23:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbWFPVeR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 17:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWFPVeR
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 17:34:17 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:10900 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751473AbWFPVeR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 17:34:17 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C94497312D;
	Fri, 16 Jun 2006 23:34:15 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FrLxi-0000d1-Qz; Fri, 16 Jun 2006 23:34:42 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606130841200.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21974>

On Tue, Jun 13, 2006 at 08:47:15AM -0700, Linus Torvalds wrote:
> 
> On Tue, 13 Jun 2006, Yann Dirson wrote:
> > 
> > I have setup a Q&D page at
> > http://ydirson.free.fr/en/software/scm/cvsps.html to link to.
> > 
> > I'll expand it later with more information.
> 
> Will you be able to set up gitweb on that site, perhaps? 

No, CGI's on this hosting platform are restricted to ISP-provided
ones.

Do you think it would be adequate to have this repo hosted on
kernel.org ?


> Also, I guess that patch I posted in the "cvsps wierdness" thread (yeah, 
> yeah, bad spelling, but it wasn't me who started the thread) should 
> probably be added, since it fixed at least one test-case.
> 
> Although it should probably get more testing with a bigger and more 
> real-life repository..

Added, in the to-check branch.  At least the idea is sound.

Anyway, there are quite a number of hairy repos out there, which
appear to cause problem to cvsps.  I'll see if I can identify more
problems precisely - I have already collected a handful of them to
http://bugs.debian.org/cvsps.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
