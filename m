From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Intensive rename detection
Date: Tue, 4 Nov 2008 11:47:38 +0100
Message-ID: <20081104104738.GD21251@atjola.homenet>
References: <216e54900811031717j70669868p3c7503357ceb5138@mail.gmail.com> <216e54900811031718o4cc81294sc0c32be1e71b9372@mail.gmail.com> <alpine.LFD.2.00.0811032021210.3419@nehalem.linux-foundation.org> <216e54900811032107p159e98ecn8958f0a78efde8f2@mail.gmail.com> <216e54900811032119h4cb51327v2d85712acc444185@mail.gmail.com> <216e54900811032202h5c82e3a9j30100e5b82f6a16a@mail.gmail.com> <20081104061647.GA18297@coredump.intra.peff.net> <216e54900811032236l5ae4bde5v16ab6519962e428f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 11:49:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxJT1-0000NN-TQ
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 11:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbYKDKrp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Nov 2008 05:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbYKDKrp
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 05:47:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:45711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752898AbYKDKro (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 05:47:44 -0500
Received: (qmail invoked by alias); 04 Nov 2008 10:47:42 -0000
Received: from i577BB701.versanet.de (EHLO atjola.local) [87.123.183.1]
  by mail.gmx.net (mp023) with SMTP; 04 Nov 2008 11:47:42 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18fX9QnBe8f2x3s0pUeX4famHOQcNGwCWvUtc9T0S
	3+wkKayjtAjMW4
Content-Disposition: inline
In-Reply-To: <216e54900811032236l5ae4bde5v16ab6519962e428f@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100067>

On 2008.11.03 22:36:42 -0800, Andrew Arnott wrote:
> On Mon, Nov 3, 2008 at 10:16 PM, Jeff King <peff@peff.net> wrote:
> > On Mon, Nov 03, 2008 at 10:02:37PM -0800, Andrew Arnott wrote:
> >
> >> Hmmm.... actually on second run I am still getting the too many fi=
les
> >> warning.  I put the [diff] section in a ~/.gitconfig file, a
> >> .gitconfig file in the root of my repo, and in the .git/config fil=
e,
> >> but none of them seem to get rid of the message.
> >
> > Where are you getting the warning? On "git status"?
> >
> > If so, then this is an instance of the problem I mentioned here:
> >
> >  [PATCH v3 7/8] wt-status: load diff ui config
> >  20081026044935.GG21047@coredump.intra.peff.net
>
> Yes, on git status.  I'm afraid I don't know how to look up the
> reference you gave.

http://marc.info/?l=3Dgit&m=3D122499658810367&w=3D2

Bj=F6rn
