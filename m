From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 1/2] init: support --import to add all files and commit  right after init
Date: Thu, 26 Mar 2009 22:23:27 +0100
Message-ID: <200903262223.28546.markus.heidelberg@web.de>
References: <1237978720-2500-1-git-send-email-pclouds@gmail.com> <20090325124219.GA5307@coredump.intra.peff.net> <adf1fd3d0903250549l60e4a2d1j8bd57ba66d24a678@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 22:25:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmx4F-0003aw-Sv
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 22:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755572AbZCZVXU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 17:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbZCZVXU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 17:23:20 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:55512 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZCZVXT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 17:23:19 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7CAC4F99B536;
	Thu, 26 Mar 2009 22:23:15 +0100 (CET)
Received: from [89.59.78.67] (helo=.)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lmx2h-00034o-00; Thu, 26 Mar 2009 22:23:15 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <adf1fd3d0903250549l60e4a2d1j8bd57ba66d24a678@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19dGSoR3g+IYDwHmxxzzb+xTBYTYNk9AnPO791f
	gpb4I2lZUVH5f6/GMA7ZJFvU0XgsLWZbsVnxDoarvkdfMiFup4
	L4Ez51WQJgfy8OIXMdKg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114822>

Santi B=E9jar, 25.03.2009:
> 2009/3/25 Jeff King <peff@peff.net>:
> > On Wed, Mar 25, 2009 at 01:38:30PM +0100, Johannes Schindelin wrote=
:
> >
> >> > > +If no message is given, "Initial commit" will be used.
> >> >
> >> > Why a default message and not running the editor?
> >>
> >> Because I would say "Initial commit" anyway.
>=20
> And I would say "Commit inicial".

And I would describe the current state in a few words.

Invoking an editor is more universal and I don't think the majority
would be contented with "Initial commit".

Markus
