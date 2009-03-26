From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/8] Documentation: move callouts.xsl to
	manpage-{base,normal}.xsl
Date: Thu, 26 Mar 2009 05:40:52 -0400
Message-ID: <20090326094051.GA14292@coredump.intra.peff.net>
References: <1237881866-5497-1-git-send-email-chris_johnsen@pobox.com> <1237881866-5497-2-git-send-email-chris_johnsen@pobox.com> <20090324085147.GA1799@coredump.intra.peff.net> <B1EF04D8-8423-4794-BEFF-908C1B3DEC31@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Chris Johnsen <chris_johnsen@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 10:42:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmm6h-0006kV-Lf
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 10:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbZCZJlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 05:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbZCZJlG
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 05:41:06 -0400
Received: from peff.net ([208.65.91.99]:49348 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbZCZJlF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 05:41:05 -0400
Received: (qmail 13045 invoked by uid 107); 26 Mar 2009 09:41:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 26 Mar 2009 05:41:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Mar 2009 05:40:52 -0400
Content-Disposition: inline
In-Reply-To: <B1EF04D8-8423-4794-BEFF-908C1B3DEC31@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114757>

On Tue, Mar 24, 2009 at 02:36:52PM -0500, Chris Johnsen wrote:

> Thank you for looking at these. I will incorporate your feedback and  
> resend in a couple of days.

Great, thanks.

> I used -C -M in some early diffs to make sure it would "compress" like 
> that, but I failed to do so for the final send-email.

FWIW, I just set diff.renames in my git repo so I don't have to remember
(the only reason not to generate renames for format-patch is if the
recipient is not using git to apply -- but it is a pretty safe
assumption that people here are using git).

-Peff
