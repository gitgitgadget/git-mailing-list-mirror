From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: a error in git documentation
Date: Tue, 31 Jul 2012 10:38:18 +0200
Message-ID: <5017997A.70406@drmicha.warpmail.net>
References: <DBDC25FF-7978-49BF-AB39-5EF9496F5456@gmail.com> <vpqpq7c1ll0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jialin Liu <jialinliu7@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jul 31 10:38:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw7yI-0000ga-BZ
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 10:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab2GaIiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jul 2012 04:38:21 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49152 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755809Ab2GaIiU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 04:38:20 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 87F012073E;
	Tue, 31 Jul 2012 04:38:19 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 31 Jul 2012 04:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=uIN/nrw22WDAlR1S4xEglM
	XR9xo=; b=nRygyBKIUYVyQVGwdCtCba0BDj5v4Rr/91DGKrsxqO7co4TMA6ZyAp
	UvoLGYIGNUkBZedrpL9bUBGT0nOtR9F84Kyadn2d7/hWXW0+FcqyeqtKPsgyHMMj
	zIwojzW7Ve1c55cgNcETg9Z5ZxqzjPcxPbPzv0hZqZzmocv6K16zU=
X-Sasl-enc: kLqBGSvOrm84WFW561Cu8JkEYfA+iysi0gfrmpY/me8E 1343723899
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EBD624827D1;
	Tue, 31 Jul 2012 04:38:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <vpqpq7c1ll0.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202635>

Matthieu Moy venit, vidit, dixit 31.07.2012 08:38:
> Jialin Liu <jialinliu7@gmail.com> writes:
>=20
>> In http://git-scm.com/book/en/Git-Basics-Recording-Changes-to-the-Re=
pository
>>
>> Notice how you don=E2=80=99t have to run git add on the benchmarks.r=
b file in this case before you commit.
>=20
> In which case? (the page is rather long)
>=20
> I didn't see a case where "git add" was not needed (or "git commit" u=
sed
> with "-a", which gives the same effect).
>=20

Matthieu: "Notice how..." is the line Jialin suggest to be changed.

Jialin: "how" is correct; "how" starts a subsentence (subclause) which
is used as the object for the verb "notice". ("Notice [that] now..."
would be correct, too.)

BTW: This is not in what many would call "git documentation" (i.e.
git.git/Documentation/). It's in the Git book. But git-scm calls the th=
e
former "reference" and puts both under "Documentation".

This is not about the question "who's the Git community". It's simply
(im)practical: You contribute to the Git book via pull requests on
GitHub and to "git documentation within the git project" by patches on
this list.

Michael
