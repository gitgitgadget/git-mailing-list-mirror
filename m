From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH 2/2] Add Swedish translation.
Date: Tue, 14 Sep 2010 09:25:44 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1009140921550.5456@ds9.cixit.se>
References: <20100912202111.B11522FC00@perkele> <AANLkTikg1vD33f6Rj4UEzsbrUemta6NbRWWH22h2Y0-B@mail.gmail.com> <alpine.DEB.2.00.1009130810580.31516@ds9.cixit.se> <AANLkTinhmBHQzkdEY88Oa-XsZQ4VAUz0Tci+gOt=fXmE@mail.gmail.com> <alpine.DEB.2.00.1009131437310.16248@ds9.cixit.se>
 <AANLkTikRGhcHOfR3hioz_oNOs+Yu0nGvGWq22iRws3Ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 10:25:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvQpy-00055V-1d
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 10:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab0INIZu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 04:25:50 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:55494 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751426Ab0INIZs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 04:25:48 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o8E8PiiT010104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 14 Sep 2010 10:25:44 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o8E8Piqu010100;
	Tue, 14 Sep 2010 10:25:44 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTikRGhcHOfR3hioz_oNOs+Yu0nGvGWq22iRws3Ed@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 14 Sep 2010 10:25:44 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156166>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> I see. Emacs's po-mode is maintained as part of gettext.git, so they=20
> probably make sure it has the same line wrapping rules, while gtransl=
ator=20
> uses something different.

gtranslator just takes whatever I type, which usually is confined by th=
e=20
width of my window.

> True, but the PO Date header doesn't tell you what commit the transla=
tion=20
> is based on, just when the translator did msginit. So it's not very u=
seful=20
> either.

If we do that manually, yes. I agree with not keeping the pot file itse=
lf=20
checked in, but it should probably be generated as part of the tarball=20
releases, to make it easier for external translators to just grab the f=
ile=20
and translate it. Then the date can be interesting.

--=20
\\// Peter - http://www.softwolves.pp.se/
