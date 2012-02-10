From: Jeff King <peff@peff.net>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 15:04:01 -0500
Message-ID: <20120210200401.GB5504@sigill.intra.peff.net>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
 <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:04:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwhW-00050F-Q8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab2BJUEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:04:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33513
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab2BJUEE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:04:04 -0500
Received: (qmail 7129 invoked by uid 107); 10 Feb 2012 20:11:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Feb 2012 15:11:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2012 15:04:01 -0500
Content-Disposition: inline
In-Reply-To: <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190445>

On Thu, Feb 09, 2012 at 04:23:01PM -0800, Junio C Hamano wrote:

> It might be a workable short term workaround to redirect
> 
>     http://www.kernel.org/pub/software/scm/git/docs/$anything
> 
> to
> 
>     http://schacon.github.com/git/$anything
> 
> although that would not give you an access to the list of documentations
> for older releases, e.g.
> 
>     http://www.kernel.org/pub/software/scm/git/docs/v1.6.0/git.html

If there is interest in this, we would be happy to host the
documentation. Let me know if that is the case, and we can give it a
much better URL than schacon.github.com. However, I tend to think that
since the project is hosted[1] at kernel.org, the official documentation
site should be there as well.

-Peff

[1] Of course, git being git, it is not really hosted _anywhere_ in
    particular. But convention thus far has said that the kernel.org
    repository is the official one.
