From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 01:23:58 +0200
Message-ID: <200904060123.58602.markus.heidelberg@web.de>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com> <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com> <20090405230655.GB20356@atjola.homenet>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 01:25:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqbiP-0004L3-3x
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 01:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753888AbZDEXXy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 19:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753836AbZDEXXy
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 19:23:54 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:45276 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753771AbZDEXXx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 19:23:53 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 85C00FF72589;
	Mon,  6 Apr 2009 01:23:51 +0200 (CEST)
Received: from [89.59.118.104] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lqbgt-0000vC-00; Mon, 06 Apr 2009 01:23:51 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20090405230655.GB20356@atjola.homenet>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1+L/UN8da+Z1xleHAUnYrybtOrecaQZFPU7KOpw
	C+d8pTwjNMg0JEDpBBl+xuLxG5+x1I3p3eGADpcuL+NmS2PuA0
	L8zpA/TpDubql1ZoKp5Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115737>

Bj=F6rn Steinbrink, 06.04.2009:
> On 2009.04.06 01:35:24 +0300, Felipe Contreras wrote:
> > Well, it's a matter of preference, and you would not loose the opti=
on
> > to do it the way you like. But actually, "git diff --cached" is a
> > different action; you can't do "git diff --cached HEAD^.." for
> > example.
>=20
> Sure you can. It diffs the index against HEAD^

No, note the ".."

Markus
