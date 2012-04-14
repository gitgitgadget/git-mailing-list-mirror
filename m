From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/5] provide better error messages for @{upstream}
Date: Sat, 14 Apr 2012 04:09:52 -0400
Message-ID: <20120414080952.GA11124@sigill.intra.peff.net>
References: <20120412204055.GA21018@sigill.intra.peff.net>
 <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Matthieu.Moy@grenoble-inp.fr
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Apr 14 10:11:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIy4f-0000pD-0S
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 10:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab2DNIKN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Apr 2012 04:10:13 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33901
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819Ab2DNIKG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2012 04:10:06 -0400
Received: (qmail 27006 invoked by uid 107); 14 Apr 2012 08:10:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 14 Apr 2012 04:10:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Apr 2012 04:09:52 -0400
Content-Disposition: inline
In-Reply-To: <1334390075-25467-1-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195478>

On Sat, Apr 14, 2012 at 09:54:30AM +0200, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:

> v2:
>=20
> - Better commit descriptions (hopefully)
> - error_message used in tests in one more place
> - Error message changed from
>   "Upstream branch '%s' not fetched from remote '%s'"
>   to
>   "Upstream branch '%s' not stored as a remote-tracking branch".

Thanks, that addresses my complaint with the previous round.

-Peff
