From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] Remove "push.default unset" warning
Date: Fri, 26 Feb 2016 05:54:01 -0500
Message-ID: <20160226105401.GA12472@sigill.intra.peff.net>
References: <000001530ea408ed-2b71a34a-32bb-434c-bba5-fdac28193e9c-000000@eu-west-1.amazonses.com>
 <1456392120-16298-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, philipoakley@iee.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Feb 26 11:54:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZG2F-0003NZ-GN
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 11:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbcBZKyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 05:54:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:49973 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932087AbcBZKyE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 05:54:04 -0500
Received: (qmail 3635 invoked by uid 102); 26 Feb 2016 10:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 05:54:04 -0500
Received: (qmail 2860 invoked by uid 107); 26 Feb 2016 10:54:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 05:54:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 05:54:01 -0500
Content-Disposition: inline
In-Reply-To: <1456392120-16298-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287566>

On Thu, Feb 25, 2016 at 10:21:58AM +0100, Matthieu Moy wrote:

> Junio and Peff both lean towards removing the message completely, and
> I think I'm convinced. We would have to do this in the future anyway.

Unsurprisingly, this series looks good to me. :)

-Peff
