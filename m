From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/2] config: list only variable names for completion
Date: Thu, 28 May 2015 16:39:25 -0400
Message-ID: <20150528203924.GA29148@peff.net>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
 <1432816175-18988-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 28 22:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy4aU-0003Bx-0I
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 22:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777AbbE1Uja convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 16:39:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:37393 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754401AbbE1Uj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 16:39:29 -0400
Received: (qmail 18942 invoked by uid 102); 28 May 2015 20:39:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 15:39:29 -0500
Received: (qmail 19024 invoked by uid 107); 28 May 2015 20:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 16:39:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 16:39:25 -0400
Content-Disposition: inline
In-Reply-To: <1432816175-18988-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270194>

On Thu, May 28, 2015 at 02:29:33PM +0200, SZEDER G=C3=A1bor wrote:

> Fixed misspelled option names in docs and in commit message, incorpor=
ated
> Peff's suggestions, and renamed 'show_only_keys' to 'omit_values' in =
1/2.
>=20
> Only minor tweaking in 2/2's commit message.

This version looks good to me (though I agree with Junio's proposed
squash about the '[value_regex]' documentation).

-Peff
