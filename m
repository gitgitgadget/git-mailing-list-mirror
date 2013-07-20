From: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
Subject: Re: [PATCH 2/2] Fix typos in comments
Date: Sat, 20 Jul 2013 22:30:38 +0200
Message-ID: <20130720203037.GA3753@domone>
References: <20130720190707.GA30044@domone>
 <20130720191311.GB30044@domone>
 <CALkWK0kzsVLGXZsxWO5rYahb39LSTFvGuE3hZaCgrJ=nuaoo7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 20 22:30:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0dnj-0005TU-NE
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 22:30:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755001Ab3GTUao convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 16:30:44 -0400
Received: from popelka.ms.mff.cuni.cz ([195.113.20.131]:46331 "EHLO
	popelka.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754966Ab3GTUan (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 16:30:43 -0400
Received: from domone.kolej.mff.cuni.cz (popelka.ms.mff.cuni.cz [195.113.20.131])
	by popelka.ms.mff.cuni.cz (Postfix) with ESMTPS id 89B23639A5;
	Sat, 20 Jul 2013 22:30:38 +0200 (CEST)
Received: by domone.kolej.mff.cuni.cz (Postfix, from userid 1000)
	id 28FB55FB94; Sat, 20 Jul 2013 22:30:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kzsVLGXZsxWO5rYahb39LSTFvGuE3hZaCgrJ=nuaoo7w@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.97.6 at popelka.ms.mff.cuni.cz
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	UNPARSEABLE_RELAY autolearn=ham version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
	popelka.ms.mff.cuni.cz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230910>

On Sun, Jul 21, 2013 at 01:21:10AM +0530, Ramkumar Ramachandra wrote:
> Ond=C5=99ej B=C3=ADlka wrote:
> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index 7fe0bff..9f29bb2 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -1137,7 +1137,7 @@ int cmd_checkout(int argc, const char **argv,=
 const char *prefix)
> >          *  3) git checkout <something> [<paths>]
> >          *
> >          * including "last branch" syntax and DWIM-ery for names of
> > -        * remote branches, erroring out for invalid or ambiguous c=
ases.
> > +        * remote branches, erring out for invalid or ambiguous cas=
es.
>=20
> Didn't look through the entire patch, but this caught me eye: what's
> wrong with "erroring out"?
Well aspell did not know it so I thought that erring is more
appropriate. Now it looks more murky, see
http://english.stackexchange.com/questions/3059/is-errored-correct-usag=
e

I am ok with removing this correction.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
