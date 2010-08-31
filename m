From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH/RFC 00/17] Begin gettextizing Git
Date: Tue, 31 Aug 2010 12:48:19 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1008311244420.28446@ds9.cixit.se>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com> <alpine.DEB.2.00.1008311205280.28446@ds9.cixit.se> <AANLkTikuQZpOjddgHtpSpw-P4AeL1swsrzJzd5cE7e8F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 13:48:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqPKH-0001Em-VH
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 13:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115Ab0HaLsX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 07:48:23 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:54926 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757197Ab0HaLsW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 07:48:22 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o7VBmJrL013446
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 31 Aug 2010 13:48:19 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id o7VBmJPM013442;
	Tue, 31 Aug 2010 13:48:19 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <AANLkTikuQZpOjddgHtpSpw-P4AeL1swsrzJzd5cE7e8F@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-3.0 (mail.cixit.se [127.0.0.1]); Tue, 31 Aug 2010 13:48:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154894>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:

> Something like that would be welcome. Personally I'm happy with editi=
ng=20
> *.po files locally with Emacs's po-mode, but to get more translators =
we=20
> probably want a friendly web interface like that at some point.

Well, it's not a web interface for translating, currently, just for kee=
ping=20
track on what needs to be translated by whom (and for language teams to=
 find=20
what to translate). You still edit the PO files in whatever you prefer.

> Preferably with an active translation community.

Translation Project is indeed very active.

> http://kerneltrap.org/mailarchive/git/2008/3/14/1163164 Is that the
> one you're talking about?

Yes.

> Translationproject seems to have a similar requirement[2], but they s=
eem=20
> require you to send a letter to the FSF through snail mail before you=
 can=20
> contribute (maybe not, I didn't read all their docs carefully).

Only when you translate FSF software for which you need to send one of =
the=20
letters that claim that you are handing over copyright to the FSF. That=
 is=20
not needed in this case, and translators working on such projects do no=
t=20
need to send one.


=46or the project side, you bascially send a POT file every now and the=
n,=20
between string-freeze and release, and update the PO files that come ba=
ck=20
from the project every now and then. I've been using the system from bo=
th=20
sides and it's lightweight enough to be workable.

--=20
\\// Peter - http://www.softwolves.pp.se/
