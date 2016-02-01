From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Git doc: GPL2 does not apply to repo data
Date: Mon, 1 Feb 2016 03:16:50 -0500
Message-ID: <20160201081650.GB26215@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1601280913450.2964@virtualbox>
 <1454274011-4880-1-git-send-email-philipoakley@iee.org>
 <xmqq8u35xv00.fsf@gitster.mtv.corp.google.com>
 <6D15DFBB73355B4E9EFB1AD5EF9FCA31842442AA@NZ-EXCHANGE1.fphcare.com>
 <alpine.DEB.2.20.1602010827430.2964@virtualbox>
 <1591708020.2493723.1454312995839.JavaMail.zimbra@imag.fr>
 <20160201081431.GA26215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Smith <Jonathan.Smith@fphcare.co.nz>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	GitList <git@vger.kernel.org>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Feb 01 09:17:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQ9fR-0008JL-Uk
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 09:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbcBAIQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 03:16:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:35374 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751616AbcBAIQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 03:16:53 -0500
Received: (qmail 31151 invoked by uid 102); 1 Feb 2016 08:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Feb 2016 03:16:53 -0500
Received: (qmail 22826 invoked by uid 107); 1 Feb 2016 08:17:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Feb 2016 03:17:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Feb 2016 03:16:50 -0500
Content-Disposition: inline
In-Reply-To: <20160201081431.GA26215@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285194>

On Mon, Feb 01, 2016 at 03:14:31AM -0500, Jeff King wrote:

> On a more serious note, this FAQ (and the one right after) might be
> useful for convincing people:
> 
>   http://www.gnu.org/licenses/gpl-faq.en.html#GPLOutput
> 
> Data that git stores is not strictly "output", but I think the answers
> there are relevant. And presumably written or vetted by lawyers, too.

Whoops, I just noticed this is the exact entry from Philip's patch. :-/

Sorry for the noise (and I do think it is a good link to help answer
this question, but I agree with Junio that we can let that FAQ stand on
its own without adding our own amateur-lawyer language to it).

-Peff
