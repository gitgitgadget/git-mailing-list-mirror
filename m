From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Release notes link problem
Date: Sat, 1 Oct 2011 02:10:04 -0400
Message-ID: <20111001061004.GA25700@sigill.intra.peff.net>
References: <CAPZPVFbWtDM5T3ZPFMc_MH4aSsfoLyVoGrGm2FeO0TOdhLrz2g@mail.gmail.com>
 <CAPZPVFY9O2VC7TS9ASReD5LYiqfDwLY5M2vxE97M+7BsYvAoqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 01 08:10:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9smH-0005yB-4v
	for gcvg-git-2@lo.gmane.org; Sat, 01 Oct 2011 08:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab1JAGKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Oct 2011 02:10:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50672
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752955Ab1JAGKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Oct 2011 02:10:06 -0400
Received: (qmail 8553 invoked by uid 107); 1 Oct 2011 06:15:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 01 Oct 2011 02:15:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Oct 2011 02:10:04 -0400
Content-Disposition: inline
In-Reply-To: <CAPZPVFY9O2VC7TS9ASReD5LYiqfDwLY5M2vxE97M+7BsYvAoqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182540>

On Fri, Sep 30, 2011 at 05:06:50PM -0400, Eugene Sajine wrote:

> The release notes link on http://git-scm.com/ is pointing to a page
> which doesn't seem to exist. I'm getting error 404 when trying to
> access it. Does anybody see the same issue?
> 
> the link is
> https://raw.github.com/gitster/git/master/Documentation/RelNotes/1.7.6.4.txt

This was due to some breakage on github this afternoon, but I believe it
has since been fixed.

-Peff
