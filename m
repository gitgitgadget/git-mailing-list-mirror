From: Jeff King <peff@peff.net>
Subject: Re: 745224e0 gcc-4.9 emmintrin.h build error
Date: Thu, 10 Jul 2014 16:23:18 -0400
Message-ID: <20140710202318.GC15615@sigill.intra.peff.net>
References: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 22:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5KsI-0007to-D6
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 22:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbaGJUXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 16:23:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:59569 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750988AbaGJUXU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 16:23:20 -0400
Received: (qmail 11628 invoked by uid 102); 10 Jul 2014 20:23:20 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Jul 2014 15:23:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 16:23:18 -0400
Content-Disposition: inline
In-Reply-To: <CAOvwQ4hNVvzeCUczi7Qurcycp8HA8KU=u1ntu3fzBwu4fTEzPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253207>

On Thu, Jul 10, 2014 at 09:59:37PM +0200, Tuncer Ayaz wrote:

> The changes in 745224e0 don't seem to build here with gcc-4.9 on
> linux x64_64. Any idea what's wrong?

Weird. It compiles fine on my x86_64 box (Debian unstable, gcc
4.9.0-10). Can you tell us more about your environment?

-Peff
