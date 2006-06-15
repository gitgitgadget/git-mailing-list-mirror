From: Yann Dirson <ydirson@altern.org>
Subject: Re: Collecting cvsps patches
Date: Thu, 15 Jun 2006 18:25:41 +0200
Message-ID: <20060615162541.GI7766@nowhere.earth>
References: <20060611122746.GB7766@nowhere.earth> <46a038f90606111516v2c8c68e2v818a0a0f9dca2da6@mail.gmail.com> <20060611224205.GF1297@nowhere.earth> <200606150921.34690.lan@academsoft.ru> <1150340912.24184.7.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Litvinov <lan@academsoft.ru>,
	GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 15 18:25:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqueq-0004pP-My
	for gcvg-git@gmane.org; Thu, 15 Jun 2006 18:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030646AbWFOQZW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Jun 2006 12:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030789AbWFOQZV
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jun 2006 12:25:21 -0400
Received: from smtp5-g19.free.fr ([212.27.42.35]:14750 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030646AbWFOQZV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jun 2006 12:25:21 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id 3F33B27718;
	Thu, 15 Jun 2006 18:25:20 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fquf8-0007ks-Bx; Thu, 15 Jun 2006 18:25:42 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1150340912.24184.7.camel@dv>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21895>

On Wed, Jun 14, 2006 at 11:08:32PM -0400, Pavel Roskin wrote:
> That said, having non-compilable repository defeats the purpose of
> collecting the patches to cvsps.  Shouldn't only compilable patches be
> allowed in the repository?

Right, it is entirely my fault, I guess I got distracted at that time.

I have change the layout of the repo to avoid such mishappenings in
the future.  The master branch holds the fixes, and new features or
intrusive fixes go into their own branches (especially since none of
them are complete yet).

Fixes that may need further thought are in the to-check branch.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
