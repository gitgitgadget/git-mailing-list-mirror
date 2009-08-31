From: Jeff King <peff@peff.net>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 12:41:46 -0400
Message-ID: <20090831164146.GA23245@coredump.intra.peff.net>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
 <vpqskf8z0rj.fsf@bauges.imag.fr>
 <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 18:42:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi9xs-00027I-3R
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 18:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753446AbZHaQlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 12:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbZHaQlt
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 12:41:49 -0400
Received: from peff.net ([208.65.91.99]:44321 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753382AbZHaQls (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 12:41:48 -0400
Received: (qmail 25071 invoked by uid 107); 31 Aug 2009 16:42:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 31 Aug 2009 12:42:00 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 12:41:46 -0400
Content-Disposition: inline
In-Reply-To: <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127486>

On Mon, Aug 31, 2009 at 08:00:41PM +0530, Sitaram Chamarty wrote:

> > Maybe you have an older version of Git?
> 
> Had 1.6.4, just tried with 1.6.4.2 -- the error is still there, exactly so.
> 
> Anything I can do to provide more info?

IIRC, the message you are seeing comes when the _server_ is an older
version of git. It is harmless, though.

-Peff
