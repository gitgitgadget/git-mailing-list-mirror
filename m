From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2] commit: reword --author error message
Date: Mon, 26 Jan 2015 21:45:54 -0500
Message-ID: <20150127024553.GA24569@peff.net>
References: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com>
 <7e2e1d1e7f4a25d84a6f7a1c0cb035221529f189.1422286879.git.git@drmicha.warpmail.net>
 <20150126190711.GA13582@peff.net>
 <xmqqlhkplz8d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 03:46:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YFwAC-0002YZ-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 03:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184AbbA0Cp5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2015 21:45:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:38872 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752194AbbA0Cpz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2015 21:45:55 -0500
Received: (qmail 6946 invoked by uid 102); 27 Jan 2015 02:45:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Jan 2015 20:45:55 -0600
Received: (qmail 8672 invoked by uid 107); 27 Jan 2015 02:46:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Jan 2015 21:46:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Jan 2015 21:45:54 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlhkplz8d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263054>

On Mon, Jan 26, 2015 at 06:43:46PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... I somehow had trouble making
> > sense of Z ("a match...") as a noun.
> 
> > I wonder if adding back in the missing verb, rather than a colon, would
> > also make more sense:
> >
> >   --author '%s' is neither 'Name <email>' nor a match for an existing author
> 
> Then
> 
> >   --author '%s' is not 'Name <email>' and matches no existing author
> 
> would be the shortest, sweetest and hopefully grammatical, perhaps?

Yes, that one make perfect sense to me.

-Peff
