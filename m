From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 11:48:15 +0200
Message-ID: <20090406094815.GC20356@atjola.homenet>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com> <20090405230655.GB20356@atjola.homenet> <200904060123.58602.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 11:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqlUR-0007lD-5F
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 11:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758358AbZDFJsV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 05:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758540AbZDFJsV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 05:48:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:55256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758324AbZDFJsU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 05:48:20 -0400
Received: (qmail invoked by alias); 06 Apr 2009 09:48:16 -0000
Received: from i59F56377.versanet.de (EHLO atjola.local) [89.245.99.119]
  by mail.gmx.net (mp060) with SMTP; 06 Apr 2009 11:48:16 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18M/zNlP6EMUyvqlssWL3NtLSOunWbn90zLqHrFQ0
	C4iAHlWGJHL7nI
Content-Disposition: inline
In-Reply-To: <200904060123.58602.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115802>

On 2009.04.06 01:23:58 +0200, Markus Heidelberg wrote:
> Bj=F6rn Steinbrink, 06.04.2009:
> > On 2009.04.06 01:35:24 +0300, Felipe Contreras wrote:
> > > Well, it's a matter of preference, and you would not loose the op=
tion
> > > to do it the way you like. But actually, "git diff --cached" is a
> > > different action; you can't do "git diff --cached HEAD^.." for
> > > example.
> >=20
> > Sure you can. It diffs the index against HEAD^
>=20
> No, note the ".."

Oh, d'oh... Sorry, and thanks!

Bj=F6rn
