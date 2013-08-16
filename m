From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] CET is only one hour ahead of UTC
Date: Fri, 16 Aug 2013 08:54:30 -0400
Message-ID: <20130816125429.GA20138@sigill.intra.peff.net>
References: <1376649800-442-1-git-send-email-maandree@operamail.com>
 <1376650451-2440-1-git-send-email-maandree@operamail.com>
 <20130816125820.2adb2a8e.maandree@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mattias =?utf-8?Q?Andr=C3=A9e?= <maandree@operamail.com>,
	git@vger.kernel.org
To: Mattias =?utf-8?Q?Andr=C3=A9e?= <maandree@member.fsf.org>
X-From: git-owner@vger.kernel.org Fri Aug 16 14:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAJYE-0001NK-3l
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 14:54:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244Ab3HPMyg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 08:54:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:56330 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922Ab3HPMye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 08:54:34 -0400
Received: (qmail 26458 invoked by uid 102); 16 Aug 2013 12:54:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 07:54:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 08:54:30 -0400
Content-Disposition: inline
In-Reply-To: <20130816125820.2adb2a8e.maandree@kth.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232422>

On Fri, Aug 16, 2013 at 12:58:20PM +0200, Mattias Andr=C3=A9e wrote:

> >  The standard email format as described by RFC 2822, for
> > example -Thu, 07 Apr 2005 22:13:13 +0200\&.
> > +Thu, 07 Apr 2005 22:13:13 +0100\&.
> >  .RE
> >  .PP
> >  ISO 8601
>=20
> I when on a limb and assumed that these patches for
> git-htmldocs and git-manpages, respectively, should
> also be sent to git@ as I could not find any other
> mailing list for them.

The content of those repositories is auto-generated from git.git's
master branch. Just your first patch is sufficient, and the others will
be updated automatically when Junio runs his usual integration cycle.

-Peff
