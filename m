From: Yann Dirson <ydirson@altern.org>
Subject: Re: Autoconf/Automake
Date: Fri, 16 Jun 2006 22:17:15 +0200
Message-ID: <20060616201715.GM7766@nowhere.earth>
References: <1150324030.23268.12.camel@dv> <20060615072450.GF7766@nowhere.earth> <20060615133146.GA5794@steel.home> <20060615201000.600939E2BC@derisoft.derived-software.demon.co.uk> <Pine.LNX.4.63.0606152239270.7480@wbgn013.biozentrum.uni-wuerzburg.de> <20060615220534.GL7766@nowhere.earth> <Pine.LNX.4.63.0606160053560.7480@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Richards <news@derived-software.ltd.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 16 22:17:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrKkq-0004F7-Hg
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 22:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWFPUQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 16:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbWFPUQu
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 16:16:50 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:5867 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751512AbWFPUQt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 16:16:49 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id CD3CC22568;
	Fri, 16 Jun 2006 22:16:48 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FrKkl-0000aM-PC; Fri, 16 Jun 2006 22:17:15 +0200
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0606160053560.7480@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21968>

On Fri, Jun 16, 2006 at 12:58:30AM +0200, Johannes Schindelin wrote:
> > On Thu, Jun 15, 2006 at 10:42:40PM +0200, Johannes Schindelin wrote:
> > > As for now, I fail to see why the current system is not adequate for git!
> > 
> > I can reassure you, gazillions of people still fail to see why cvs is
> > not adequate for their project.  And the ratio of devs in the
> > corporate world not knowning git to those not knowning cvs is far
> > superior to 2.  And everyone here knows cvs is not more adequate than
> > git for so many tasks :)
> 
> You know as well as I that this comparison is unfair. I am _NOT_ a 
> corporate person. I hope that you do not judge me as a complete airhead.

Well, I have to apologize - especially after looking closer at the
current Makefile.  I think I understand now why autoconf was suggested
in the first place, but it what it would achieve would mostly moving
the ifdef's to configure.ac, which would not be such a gain anyway.

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
