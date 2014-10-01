From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] sha1-array: add test-sha1-array and basic tests
Date: Wed, 1 Oct 2014 11:19:10 -0400
Message-ID: <20141001151910.GA20735@peff.net>
References: <542C1711.6080609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:19:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZLgW-0005h3-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 17:19:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbaJAPTO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Oct 2014 11:19:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:53731 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752415AbaJAPTM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 11:19:12 -0400
Received: (qmail 28693 invoked by uid 102); 1 Oct 2014 15:19:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 10:19:11 -0500
Received: (qmail 27749 invoked by uid 107); 1 Oct 2014 15:19:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Oct 2014 11:19:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2014 11:19:10 -0400
Content-Disposition: inline
In-Reply-To: <542C1711.6080609@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257755>

On Wed, Oct 01, 2014 at 05:00:33PM +0200, Ren=C3=A9 Scharfe wrote:

> Helped-by: Jeff King <peff@peff.net>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Added a test for looking up a non-existing entry in an array that
> contains duplicates, as suggested by Jeff.  Changed echo20() to add
> a space after the prefix as needed, as suggested by Eric.

Both patches look good to me.

-Peff
