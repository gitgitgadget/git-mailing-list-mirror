From: Jeff King <peff@peff.net>
Subject: Re: Apple violating git LGPL?
Date: Wed, 6 Aug 2014 16:41:37 -0400
Message-ID: <20140806204137.GA22592@peff.net>
References: <CAC_jL3wO9jkE4HapvJjn-4uW4RtSxubFthrxzQJ87EQ4Gq-9Ug@mail.gmail.com>
 <20140806184304.GB21254@peff.net>
 <CA+Cdr4kobYDVGJneBXENYj=hmC6YEM=BYqGoAFvUNeaeYS_L5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert P Fischer <rpf2116@columbia.edu>, git@vger.kernel.org
To: Tony <ssk@toanii.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 22:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF81o-000850-Hr
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 22:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbaHFUlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 16:41:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:47221 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751549AbaHFUlk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 16:41:40 -0400
Received: (qmail 13532 invoked by uid 102); 6 Aug 2014 20:41:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Aug 2014 15:41:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2014 16:41:37 -0400
Content-Disposition: inline
In-Reply-To: <CA+Cdr4kobYDVGJneBXENYj=hmC6YEM=BYqGoAFvUNeaeYS_L5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254903>

On Wed, Aug 06, 2014 at 01:23:00PM -0700, Tony wrote:

> > Also, minor nit, but git is GPL, not LGPL.
> 
> But Apple put a LGPL license in side the folder. See:
> https://www.opensource.apple.com/source/Git/Git-48/src/git/LGPL-2.1

Interesting. It starts with:

  While most of this project is under the GPL (see COPYING), the xdiff/
  library and some libc code from compat/ are licensed under the GNU
  LGPL, version 2.1 or (at your option) any later version and some other
  files are under other licenses.  Check the individual files to be
  sure.

which makes sense.

-Peff
