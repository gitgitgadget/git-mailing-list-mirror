From: Jeff King <peff@peff.net>
Subject: Re: Extra pair of double quotes in "git commit" output?
Date: Wed, 26 Nov 2008 08:34:23 -0500
Message-ID: <20081126133422.GA1761@coredump.intra.peff.net>
References: <20081126064906.6117@nanako3.lavabit.com> <20081125232521.GC30942@coredump.intra.peff.net> <adf1fd3d0811251606t7f49eb84y53075427859bd26a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Santi =?utf-8?B?QsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Nov 26 14:35:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5KYO-0006yv-VW
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 14:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYKZNe1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Nov 2008 08:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753669AbYKZNe0
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 08:34:26 -0500
Received: from peff.net ([208.65.91.99]:3303 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646AbYKZNe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 08:34:26 -0500
Received: (qmail 18472 invoked by uid 111); 26 Nov 2008 13:34:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 26 Nov 2008 08:34:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Nov 2008 08:34:23 -0500
Content-Disposition: inline
In-Reply-To: <adf1fd3d0811251606t7f49eb84y53075427859bd26a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101735>

On Wed, Nov 26, 2008 at 01:06:34AM +0100, Santi B=C3=A9jar wrote:

> Maybe just use the output of "git branch -v":
>=20
> master d9a5491 foo: bar
>=20
> or even literally:
>=20
> * master d9a5491 [ahead 1] foo: bar
>=20
> or to make the separation more evident:
>=20
> [master d9a5491] foo: bar

Out of those suggestions, I find only the final one aesthetically
acceptable. Nobody else has weighed in, so maybe they don't care. Or
maybe they are just on vacation due to the (American) holiday.

-Peff
