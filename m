From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 01/15] Move split_cmdline() to alias.c
Date: Tue, 01 Jul 2008 00:51:51 +0200
Message-ID: <48696387.3070605@free.fr>
References: <cover.1214581610.git.vmiklos@frugalware.org> <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org> <486796C3.7040304@free.fr> <alpine.DEB.1.00.0806291513450.9925@racer> <48679C44.30702@free.fr> <alpine.DEB.1.00.0806291542070.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:52:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDSEg-0007Jj-QN
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbYF3Wvh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 18:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763763AbYF3Wvh
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:51:37 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:56355 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763496AbYF3Wvg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:51:36 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 93B8912B6B1;
	Tue,  1 Jul 2008 00:51:35 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 4637F12B6D2;
	Tue,  1 Jul 2008 00:51:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806291542070.9925@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86957>

Johannes Schindelin a =E9crit :
>=20
> I am generally not a fan of crossing bridges miles before you reach t=
hem.
>=20

OK, as you want. :-) I don't really care about this patch, anyway.

Olivier.
