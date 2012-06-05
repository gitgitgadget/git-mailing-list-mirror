From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4 v2] api-credential.txt: show the big picture first
Date: Tue, 5 Jun 2012 03:36:26 -0400
Message-ID: <20120605073626.GD25809@sigill.intra.peff.net>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338841064-32294-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338841064-32294-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 05 09:36:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SboJd-0002It-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 09:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114Ab2FEHg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 03:36:28 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:43112
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753435Ab2FEHg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 03:36:28 -0400
Received: (qmail 14658 invoked by uid 107); 5 Jun 2012 07:36:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Jun 2012 03:36:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Jun 2012 03:36:26 -0400
Content-Disposition: inline
In-Reply-To: <1338841064-32294-2-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199212>

On Mon, Jun 04, 2012 at 10:17:42PM +0200, Matthieu Moy wrote:

> The API documentation targets two kinds of developers: those using the
> (C) API, and those writing remote-helpers. The document was not clear
> about which part was useful to which category, and for example, the C API
> could be mistakenly thought as an API for writting remote helpers.
> 
> Based-on-patch-by: Jeff King <peff@peff.net>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Fixed typos noted by Jeff.

Thanks. Patches 2-4 look OK content-wise. If you replace 1/4 with my
relative-html-prefix patch, then all of the "../" ugliness can go away.

-Peff
