From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [RFC/PATCH 1/2] log: add "log.showsignature" configuration
 variable
Date: Thu, 26 May 2016 17:43:22 +0200 (CEST)
Message-ID: <393273591.80027.1464277402819.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com> <20160526130647.27001-2-mehul.jain2029@gmail.com> <156149583.51074.1464270131166.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CA+DCAeSYr-q-0uSeDymJPHZwVZDZhh4yHH48peLOKodbxW1N7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Austin English <austinenglish@gmail.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 17:33:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5xHX-0006tO-0P
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 17:33:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbcEZPdB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 May 2016 11:33:01 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:54719 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753457AbcEZPdA convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 11:33:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id A5D8721C4;
	Thu, 26 May 2016 17:32:56 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m_zpsNl8xCGn; Thu, 26 May 2016 17:32:56 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8F49521B8;
	Thu, 26 May 2016 17:32:56 +0200 (CEST)
In-Reply-To: <CA+DCAeSYr-q-0uSeDymJPHZwVZDZhh4yHH48peLOKodbxW1N7A@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: add "log.showsignature" configuration variable
Thread-Index: 95ffCKMN7ashtMiiJgTTsL5chsaulQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295659>

Mehul Jain <mehul.jain2029@gmail.com> writes:
> Hi Remi,
>=20
> Thanks for your input.
>=20
> On Thu, May 26, 2016 at 7:12 PM, Remi Galan Alfonso
> <remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> > Hi Mehul,
> >
> > Mehul Jain <mehul.jain2029@gmail.com> writes:
> >> When log.showsignature set true, "git log" and "git show" will beh=
ave
> >
> > 'When log.showsignature is set to true' ?
>=20
> Pardon me, but I don't understand your question.
> I think you are suggesting me to write
> "When log.showsignature is set to true"
> instead of
> "When log.showsignature set true".

Sorry, I should have made explicit what went through my mind.
"When log.showsignature set true" doesn't sound right to me, while
"When log.showsignature is set to true" sounds better, however not
being a native english speaker maybe it's just me being wrong.

Thanks,
R=C3=A9mi
