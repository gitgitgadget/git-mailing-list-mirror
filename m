From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] push: pass --progress down to git-pack-objects
Date: Wed, 13 Oct 2010 21:24:15 -0400
Message-ID: <20101014012415.GA20685@sigill.intra.peff.net>
References: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
 <1286998311-5112-2-git-send-email-rctay89@gmail.com>
 <1286998311-5112-3-git-send-email-rctay89@gmail.com>
 <1286998311-5112-4-git-send-email-rctay89@gmail.com>
 <AANLkTikUne3NmDMEsq07oN+4pr9APQJFKhF-FKLmSUbh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 03:24:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6CY4-0003v6-2R
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 03:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548Ab0JNBXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 21:23:54 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:36744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab0JNBXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 21:23:53 -0400
Received: (qmail 3639 invoked by uid 111); 14 Oct 2010 01:23:52 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 Oct 2010 01:23:52 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Oct 2010 21:24:15 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikUne3NmDMEsq07oN+4pr9APQJFKhF-FKLmSUbh@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159012>

On Thu, Oct 14, 2010 at 08:59:41AM +0800, Tay Ray Chuan wrote:

> On Thu, Oct 14, 2010 at 3:31 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> > From: Jeff King <peff@peff.net>
> >
> > [snip]
> >
> > Reported-by: Chase Brammer <cbrammer@gmail.com>
> > Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> > Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> 
> Chase, I switched the authorship to Jeff - after all, he was the one
> who wrote the patch. I hope you're fine with that.
> 
> Jeff, if this patch is ok, since you're the author, perhaps you might
> want to add your SOB?

Yeah, definitely:

Signed-off-by: Jeff King <peff@peff.net>

-Peff
