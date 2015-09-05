From: John Keeping <john@keeping.me.uk>
Subject: Re: [L10N] Kickoff of translation for Git 2.6.0 round 1
Date: Sat, 5 Sep 2015 14:21:48 +0100
Message-ID: <20150905132148.GC27660@serenity.lan>
References: <CANYiYbEVU7A2w999jqLQ=V35WM0WTo--RHJHW7Ocw0FfsmqmLg@mail.gmail.com>
 <2019620.IQg8023dli@cayenne>
 <CANYiYbF3p-yHBhzyfU1WQhjRZEqjXotsQS+x5K2EbatnAGuJrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Alexander Shopov <ash@kambanaria.org>,
	Alex Henrie <alexhenrie24@gmail.com>,
	Ralf Thielow <ralf.thielow@googlemail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 15:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDQJ-0008JO-CW
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbbIENWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Sep 2015 09:22:24 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:59402 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbIENWW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Sep 2015 09:22:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E5720CDA5EA;
	Sat,  5 Sep 2015 14:22:21 +0100 (BST)
X-Quarantine-ID: <0+DQgJVoD3KP>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0+DQgJVoD3KP; Sat,  5 Sep 2015 14:22:21 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 05F91CDA46B;
	Sat,  5 Sep 2015 14:21:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CANYiYbF3p-yHBhzyfU1WQhjRZEqjXotsQS+x5K2EbatnAGuJrw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277376>

On Sat, Sep 05, 2015 at 09:14:18PM +0800, Jiang Xin wrote:
> 2015-09-05 18:02 GMT+08:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
> > Le samedi 5 septembre 2015, 10:17:54 Jiang Xin a =C3=A9crit :
> >> Hi,
> >>
> >> Git v2.6.0-rc0 has been released, and it's time to start new round=
 of git
> >> l10n. This time there are 123 updated messages need to be translat=
ed since
> >> last update:
> >>
> >>     l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)
> >>
> >>     Generate po/git.pot from v2.6.0-rc0-24-gec371ff for git v2.6.0=
 l10n
> >>     round 1.
> >>
> >>     Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> >>
> >> You can get it from the usual place:
> >>
> >>     https://github.com/git-l10n/git-po/
> >>
> >> As how to update your XX.po and help to translate Git, please see
> >> "Updating a XX.po file" and other sections in =E2=80=9Cpo/README" =
file.
> >>
> >> --
> >> Jiang Xin
> >
> >
> > Some new strings are not consistent with the actual set.
> >
> > For instance, in the "Could not ..." strings were all with capitals=
, and some
> > new ones are not. Last time, I remarked strings which were almost e=
xactly the
> > same (only difference was a final dot, if I remember). Some help st=
rings were
> > mixing different styles.
>=20
> Before this update, "Could not" vs "could not" is 50:40, and now it's=
 50:50.
>=20
>     $ grep 'Could not' po/git.pot  | wc -l
>     50
>=20
>     $ grep 'could not' po/git.pot  | wc -l
>     50

Note that Documentation/CodingGuidelines has a section on error message=
s
which says:

 - Do not end error messages with a full stop.

 - Do not capitalize ("unable to open %s", not "Unable to open %s")

 - Say what the error is first ("cannot open %s", not "%s: cannot open"=
)
