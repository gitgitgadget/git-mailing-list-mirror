From: Jeff King <peff@peff.net>
Subject: Re: git pull behavior changed?
Date: Wed, 21 Apr 2010 20:01:31 -0400
Message-ID: <20100422000131.GB14249@coredump.intra.peff.net>
References: <u2z3abd05a91004211413rcd2440fdq7946ef4764b24362@mail.gmail.com>
 <v2hfabb9a1e1004211422ybbf47ef0gd5dfd1791eb03c16@mail.gmail.com>
 <y2p3abd05a91004211455r30d13932t92dfbedff581b9a1@mail.gmail.com>
 <vpqsk6omppf.fsf@bauges.imag.fr>
 <h2o3abd05a91004211504pfc2de8b7sa37c9c0a4dd14f57@mail.gmail.com>
 <vpq8w8gjvhn.fsf@bauges.imag.fr>
 <z2t3abd05a91004211541y1c2c5467k5731819da7fe625@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Aghiles <aghilesk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 02:02:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4jrv-0000ID-1D
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 02:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857Ab0DVACE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 20:02:04 -0400
Received: from peff.net ([208.65.91.99]:51704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab0DVACD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 20:02:03 -0400
Received: (qmail 23693 invoked by uid 107); 22 Apr 2010 00:02:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Apr 2010 20:02:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Apr 2010 20:01:31 -0400
Content-Disposition: inline
In-Reply-To: <z2t3abd05a91004211541y1c2c5467k5731819da7fe625@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145478>

On Wed, Apr 21, 2010 at 06:41:16PM -0400, Aghiles wrote:

> Again, the behavior changed: just upgraded to 1.7.0.3, before then I was
> doing branches like this:
> 
>   git checkout -b small_fixes
>   git pull

What was the old version of git? A long time ago (maybe 1.5.x or
earlier?) we used to default unconfigured pulls differently.

-Peff
