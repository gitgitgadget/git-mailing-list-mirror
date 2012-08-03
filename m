From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: Introduce test_seq
Date: Fri, 3 Aug 2012 16:41:02 -0400
Message-ID: <20120803204102.GA10908@sigill.intra.peff.net>
References: <20120803221203.37e854d1@gmail.com>
 <1344026304-11687-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:41:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxOgI-0000iy-GT
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab2HCUlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Aug 2012 16:41:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50926 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab2HCUlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 16:41:04 -0400
Received: (qmail 28460 invoked by uid 107); 3 Aug 2012 20:41:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 Aug 2012 16:41:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2012 16:41:02 -0400
Content-Disposition: inline
In-Reply-To: <1344026304-11687-1-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202862>

On Fri, Aug 03, 2012 at 10:38:24PM +0200, Micha=C5=82 Kiedrowicz wrote:

> Changes since previous patch:
>=20
> 	* Added quotes around arguments, allowing `test_seq a z`
> 	* Improved test_seq comments
>=20
>  t/perf/perf-lib.sh      |  2 +-
>  t/t5551-http-fetch.sh   |  2 +-
>  t/test-lib-functions.sh | 19 +++++++++++++++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)

I think this version looks OK.

-Peff
