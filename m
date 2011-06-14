From: Andreas Ericsson <ae@op5.se>
Subject: Re: Using Transifex in git.git
Date: Tue, 14 Jun 2011 11:16:36 +0200
Message-ID: <4DF726F4.3000204@op5.se>
References: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dimitris Glezos <glezos@indifex.com>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6?= =?ISO-8859-15?Q?r=F0?= 
	<avarab@gmail.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 11:22:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWPpi-0001wG-QL
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 11:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755736Ab1FNJWp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jun 2011 05:22:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54277 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab1FNJWo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 05:22:44 -0400
Received: by fxm17 with SMTP id 17so3446388fxm.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 02:22:42 -0700 (PDT)
Received: by 10.223.55.200 with SMTP id v8mr53987fag.82.1308042999193;
        Tue, 14 Jun 2011 02:16:39 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id e16sm2558078fak.17.2011.06.14.02.16.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 02:16:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <BANLkTikQJYYd4sTJoDrL28Bo35+GpV3HgA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175753>

On 06/14/2011 07:57 AM, Ramkumar Ramachandra wrote:
> Hi Dimitris et al,
>=20
> [+CC: Git List; for wider exposure]
> [+CC: Jonathan Nieder; he has been involved with translations in the =
past]
> [+CC: Junio C Hamano; for authoritative policy advice]
>=20
> I think it's a good idea to use a system like Transifex to manage
> translations for git.git, so that we can attract a large number of
> non-technical translators.  Further, I think it's a good time to star=
t
> off on this now, since many of the i18n bits from =C6var's series are=
 in
> 'master'.  So, I'm looking to start off a discussion about how to
> adapt a translation system into our current patch workflow.  Dimitris
> is the lead developer of Transifex, and can help with the details.
>=20

It's always better to start coding on changes and then show how those
changes make life easier for people than to suggest something out of
thin air and start a discussion about it before applying any work.

I for one have no idea what transifex is, how it works or why it's
superior to any of the currently existing tools to manage .po files.
I also have no real interest in translations, although I chip in a
bit with the swedish one when someone else does the grunt part of the
work to make it happen. I believe many here share that sentiment with
me, so you'd probably be better off doing a sales-pitch kind of mail
to the people who have contributed greatly to the actual translations
earlier so they can voice their opinions on what system they want to
use.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
