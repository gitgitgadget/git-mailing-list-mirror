From: Jordan DE GEA <jordan.de-gea@grenoble-inp.org>
Subject: [RFC] Triangular Workflow UI improvments
Date: Mon, 30 May 2016 11:07:30 +0200
Message-ID: <9A874F00-ABD8-43D5-A32E-6A39ED333E6D@grenoble-inp.org>
References: <E83A9439-54C8-4925-8EE3-6AEEDD9416F3@grenoble-inp.org> <D501BE7EF38A4CDF9ADB786B53CCFE0C@PhilipOakley>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	Samuel Groot <samuel.groot@grenoble-inp.org>,
	philipoakley@iee.org, artagnon@gmail.com, peff@peff.net
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon May 30 11:07:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7JAf-0002Zn-Qf
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 11:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbcE3JHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 05:07:34 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:49519 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbcE3JHd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 05:07:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4ACD3247F;
	Mon, 30 May 2016 11:07:31 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D68sydnWvEwp; Mon, 30 May 2016 11:07:31 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3A3BC246D;
	Mon, 30 May 2016 11:07:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 33C822077;
	Mon, 30 May 2016 11:07:31 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zOKizZvkxj7N; Mon, 30 May 2016 11:07:31 +0200 (CEST)
Received: from eduroam-032091.grenet.fr (eduroam-032091.grenet.fr [130.190.32.91])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 19F2D2066;
	Mon, 30 May 2016 11:07:31 +0200 (CEST)
X-Priority: 3
In-Reply-To: <D501BE7EF38A4CDF9ADB786B53CCFE0C@PhilipOakley>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295873>


> Le 27 mai 2016 =C3=A0 09:32, Philip Oakley <philipoakley@iee.org> a =C3=
=A9crit :
> For me, the first step would be to actually document a (the?) Triangu=
lar Workflow in the documentation, so we are all taking about the same =
broad method.
>=20
> At the moment there is a choice (assuming a ithub like service) of ei=
ther clone and then fork, or fork and clone the fork, which leave the u=
ser with different fixups of their config's being required, so describi=
ng the easier one would help folk.
>=20
> Likewise there are missing terms such as for the third place (the per=
sonal fork) that is neither the upstream, nor the local repo. Making su=
re the terminology is crisp and clean will greatly ease any implementat=
ion issues. And then there are the possible workflows...

Yes, you=E2=80=99re right.=20

Writing a complete tutorial is a good idea.=20

I start this job and the content will depend=20
on the result of this discussion.=20
