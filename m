From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 1/9] builtin-verify-tag.c: use parse_options()
Date: Fri, 25 Jul 2008 17:20:02 +0200
Message-ID: <4889EF22.6020604@free.fr>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-2-git-send-email-barra_cuda@katamail.com> <4888B4E3.9000504@free.fr> <alpine.DEB.1.00.0807241807550.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 17:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMP7U-0005pt-2e
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 17:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbYGYPVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYGYPVH
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 11:21:07 -0400
Received: from postfix2-g20.free.fr ([212.27.60.43]:33586 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbYGYPVH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 11:21:07 -0400
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 110C0285DE93
	for <git@vger.kernel.org>; Fri, 25 Jul 2008 15:20:47 +0200 (CEST)
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id E4EE432A841;
	Fri, 25 Jul 2008 17:20:02 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 85F5C32A81C;
	Fri, 25 Jul 2008 17:20:02 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <alpine.DEB.1.00.0807241807550.8986@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90058>

Johannes Schindelin a =E9crit :
>=20
> That would be a bugfix.  As such, it belongs into a different commit.=
 =20

I thought, for that kind of trivial bug that probably never hit anyone,
a line in the commit message was enough.

> Care to provide a patch?

OK, will do.

Olivier.
