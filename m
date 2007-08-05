From: Jeff King <peff@peff.net>
Subject: Re: Terminology question about remote branches.
Date: Sun, 5 Aug 2007 08:14:09 -0400
Message-ID: <20070805121409.GA19885@coredump.intra.peff.net>
References: <854pjfin68.fsf@lola.goethe.zz> <20070804092933.aaec6d52.seanlkml@sympatico.ca> <85ejijgzzg.fsf@lola.goethe.zz> <20070805100532.GG12507@coredump.intra.peff.net> <85172807-B7EB-47DD-813E-FAF5894E1190@zib.de> <20070805110200.GA18083@coredump.intra.peff.net> <85tzre8b4w.fsf@lola.goethe.zz> <20070805115208.GA19734@coredump.intra.peff.net> <85fy2y89kb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 05 14:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHezu-0003cv-TU
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 14:14:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755190AbXHEMOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 08:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbXHEMOM
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 08:14:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2311 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754583AbXHEMOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2007 08:14:11 -0400
Received: (qmail 18261 invoked from network); 5 Aug 2007 12:14:14 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 5 Aug 2007 12:14:14 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Aug 2007 08:14:09 -0400
Content-Disposition: inline
In-Reply-To: <85fy2y89kb.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55004>

On Sun, Aug 05, 2007 at 02:12:04PM +0200, David Kastrup wrote:

> Well, that is pretty much exactly what I find fascinating: that the
> behavior is arbitrary and undocumented enough that one can't deduce it
> either by logic or by recollection or by documentation, but just by
> reading the code.

I see your point, but I think you are reading too much into my words. I
am 99% sure that is the way it works (because it would make no sense to
work any other way, and that is my mental model of how it works), but I
am very hesitant to state something outright which I haven't
double-checked in the code. Thus I used weak language.

-Peff
