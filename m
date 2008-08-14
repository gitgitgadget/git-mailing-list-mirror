From: Mark Struberg <struberg@yahoo.de>
Subject: Re: does anything like cvs export exist in git?
Date: Thu, 14 Aug 2008 21:46:08 +0000 (GMT)
Message-ID: <90329.57791.qm@web27805.mail.ukl.yahoo.com>
References: <vpqwsijjno1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 14 23:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkf5-0007oy-Ca
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYHNVqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 17:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYHNVqM
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:46:12 -0400
Received: from web27805.mail.ukl.yahoo.com ([217.146.182.10]:25513 "HELO
	web27805.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750705AbYHNVqL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:46:11 -0400
Received: (qmail 58133 invoked by uid 60001); 14 Aug 2008 21:46:09 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=FjLRRoZqn49vxEDIBgGuk5Sl3LleVOBecFpNj5e57U92VMozPcVxgGZELJSan8Iezvxln16jiPq8Y0426r+QgRI1NqM1AV/yAinRiwfzU6TgqwVOGQdnZhvX9RUM3/BaMZABDIuJjodm1fuSLwVPmErkIZSsk8pQtCvWGw8Q3IA=;
Received: from [213.162.66.179] by web27805.mail.ukl.yahoo.com via HTTP; Thu, 14 Aug 2008 21:46:08 GMT
X-Mailer: YahooMailWebService/0.7.218
In-Reply-To: <vpqwsijjno1.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92407>

Txs Matthieu, but unfortunately git-archive only knows the formats tar =
and zip, but no 'files' or whatever we may call it.

txs anyway,
mark


--- Matthieu Moy <Matthieu.Moy@imag.fr> schrieb am Do, 14.8.2008:

> Von: Matthieu Moy <Matthieu.Moy@imag.fr>
> Betreff: Re: does anything like cvs export exist in git?
> An: "Mark Struberg" <struberg@yahoo.de>
> CC: git@vger.kernel.org
> Datum: Donnerstag, 14. August 2008, 23:23
> Mark Struberg <struberg@yahoo.de> writes:
>=20
> > This is just for making sure I did not oversee
> anything.
>=20
> Did you look at git archive?
>=20
> --=20
> Matthieu

__________________________________________________
Do You Yahoo!?
Sie sind Spam leid? Yahoo! Mail verf=FCgt =FCber einen herausragenden S=
chutz gegen Massenmails.=20
http://mail.yahoo.com=20
