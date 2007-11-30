From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Move all dashed form git commands to libexecdir
Date: Fri, 30 Nov 2007 10:29:43 -0500
Message-ID: <20071130152942.GA22489@coredump.intra.peff.net>
References: <20071129231444.GA9616@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291527090.8458@woody.linux-foundation.org> <7veje8twt2.fsf@gitster.siamese.dyndns.org> <20071130003512.GB11683@coredump.intra.peff.net> <7vzlwwsgkp.fsf@gitster.siamese.dyndns.org> <20071130005852.GA12224@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291821220.8458@woody.linux-foundation.org> <5E2A9E2B-8B9A-46B0-99D0-DB3798F10119@zib.de> <20071130151223.GB22095@coredump.intra.peff.net> <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 30 16:30:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy7os-0001Pi-8t
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 16:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbXK3P3q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Nov 2007 10:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762419AbXK3P3q
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 10:29:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1285 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762379AbXK3P3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2007 10:29:45 -0500
Received: (qmail 2977 invoked by uid 111); 30 Nov 2007 15:29:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 30 Nov 2007 10:29:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Nov 2007 10:29:43 -0500
Content-Disposition: inline
In-Reply-To: <8aa486160711300728x70f591f1hf8884a78f2b15806@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66646>

On Fri, Nov 30, 2007 at 04:28:21PM +0100, Santi B=E9jar wrote:

> > But I am not opposed to having some "git foo" form for gitk.
>=20
> In mercurial "hg view" is actually an old version of gitk modified fo=
r hg.
>=20
> And as "git view" it could be added to the "git help" list.

Unfortunately, there is already a "gitview" program similar to gitk,
although it never made it out of contrib/.

-Peff
