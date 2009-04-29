From: Jeff King <peff@peff.net>
Subject: Re: [doc] User Manual Suggestion
Date: Wed, 29 Apr 2009 10:05:20 -0400
Message-ID: <20090429140520.GA31343@coredump.intra.peff.net>
References: <200904240051.46233.johan@herland.net> <b4087cc50904231730i1e8a005cpaf1921e23df11da6@mail.gmail.com> <200904242230.13239.johan@herland.net> <alpine.LNX.2.00.0904241655090.2147@iabervon.org> <20090424213848.GA14493@coredump.intra.peff.net> <4E155CC5-B20A-4B79-8CBF-9D1E0E36920F@boostpro.com> <20090425003531.GA18125@coredump.intra.peff.net> <1A9F6DB0-983F-4A5B-B3B7-33227C11F36A@boostpro.com> <20090429063448.GA22448@coredump.intra.peff.net> <D1C7AEA3-1565-4E86-AFF0-9EC2F0D79FCC@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 16:05:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzAPn-0004y5-Oz
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 16:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbZD2OFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 10:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbZD2OFZ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 10:05:25 -0400
Received: from peff.net ([208.65.91.99]:37637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbZD2OFY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 10:05:24 -0400
Received: (qmail 8177 invoked by uid 107); 29 Apr 2009 14:05:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 29 Apr 2009 10:05:37 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Apr 2009 10:05:20 -0400
Content-Disposition: inline
In-Reply-To: <D1C7AEA3-1565-4E86-AFF0-9EC2F0D79FCC@boostpro.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117891>

On Wed, Apr 29, 2009 at 09:27:11AM -0400, David Abrahams wrote:

>> object storage. That is, half of the idea of git is a big database of
>> content-addressable objects.
>
> Absolutely, it's important to know that everything is content-addressable 
> (which essentially communicates the same important information as "the 
> object's id is a hash of its contents").  I was trying to say that the 
> fact that each one is a "first-class" object  and has a unique name is not 
> particularly remarkable.

I see. I consider those concepts inextricably linked. But I suppose you
could explain one without the other.

Anyway, thanks for the perspective.

-Peff
