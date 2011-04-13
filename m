From: axel.ml@laposte.net
Subject: Re: REMOTE_USER value propagation through http push
Date: Wed, 13 Apr 2011 16:58:23 +0200 (CEST)
Message-ID: <12538384.27708.1302706703346.JavaMail.www@wwinf8204>
References: <4DA57183.6040308@laposte.net>
 <m3oc4a2tzf.fsf@localhost.localdomain>
 <22124707.170284.1302701972329.JavaMail.www@wwinf8403>
 <201104131627.29138.jnareb@gmail.com>
Reply-To: axel.ml@laposte.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 16:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA1Wj-0000Fu-J2
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 16:58:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069Ab1DMO62 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 10:58:28 -0400
Received: from out4.laposte.net ([193.251.214.121]:26565 "EHLO
	out3.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756627Ab1DMO61 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 10:58:27 -0400
Received: from meplus.info (localhost [127.0.0.1])
	by mwinf8303.laposte.net (SMTP Server) with ESMTP id 65A2C700009F
	for <git@vger.kernel.org>; Wed, 13 Apr 2011 16:58:23 +0200 (CEST)
Received: from wwinf8204 (unknown [10.98.50.224])
	by mwinf8303.laposte.net (SMTP Server) with ESMTP id 5B503700009E;
	Wed, 13 Apr 2011 16:58:23 +0200 (CEST)
X-ME-UUID: 20110413145823374.5B503700009E@mwinf8303.laposte.net
In-Reply-To: <201104131627.29138.jnareb@gmail.com>
X-Originating-IP: [82.247.209.197]
X-Wum-Nature: EMAIL-NATURE
X-WUM-FROM: |~|
X-WUM-TO: |~|
X-WUM-REPLYTO: |~|
X-me-spamlevel: not-spam
X-me-spamrating: 39.799999
X-me-spamcause: OK, (-5)(0000)gggruggvucftvghtrhhoucdtuddrfeduiedrfeekucetggdotefuucfrrhhofhhilhgvmecuoehnohhnvgeqnecuuegrihhlohhuthemuceftddtnecujhgvucdlqdehmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171461>


> Message du 13/04/11 16:29
> De : "Jakub Narebski"=20
> A : "Axel"=20
> Copie =C3=A0 : git@vger.kernel.org
> Objet : Re: REMOTE_USER value propagation through http push
>
>=20
> Nope, at the time of push commits are already created, and author and=
=20
> committer info are already set in stone, and not possible to change=20
> without rewriting commits.
>

I will dive further into the links you gave. I think I'll sacrify the c=
redentials information then for the moment.
Is there a chance that we ll see one day this third level of informatio=
n (the authentication credentials) added to the push and displayed by g=
itweb ?

I thank you for your long answers.


Une messagerie gratuite, garantie =C3=A0 vie et des services en plus, =C3=
=A7a vous tente ?
Je cr=C3=A9e ma bo=C3=AEte mail www.laposte.net
