From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 10:32:54 -0400
Message-ID: <20160429143254.GA27249@sigill.intra.peff.net>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
 <20160429121429.GB27952@sigill.intra.peff.net>
 <vpqeg9o7gh4.fsf@anie.imag.fr>
 <B5E5068F-7D69-41F8-BC33-E287567FD3AD@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	stefan.naewe@atlas-elektronik.com, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:33:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9Ta-000147-ED
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbcD2Oc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:32:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:59131 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752950AbcD2Oc6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:32:58 -0400
Received: (qmail 9612 invoked by uid 102); 29 Apr 2016 14:32:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 10:32:57 -0400
Received: (qmail 22264 invoked by uid 107); 29 Apr 2016 14:32:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Apr 2016 10:32:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2016 10:32:54 -0400
Content-Disposition: inline
In-Reply-To: <B5E5068F-7D69-41F8-BC33-E287567FD3AD@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293006>

On Fri, Apr 29, 2016 at 04:22:05PM +0200, Lars Schneider wrote:

> >>> +# The follow numbers need to be adjusted when new documentation is added.
> >>> +test_file_count html 233
> >>> +test_file_count xml 171
> >>> +test_file_count 1 152
> [...]
> I agree, too. I wasn't sure about this check. That's why I added
> the little comment above to point out the problem.
> 
> Should I reroll?

IMHO, yes.

-Peff
