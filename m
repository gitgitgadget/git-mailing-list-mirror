From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Mon, 25 Aug 2008 02:41:37 +0200
Message-ID: <200808250241.40407.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200808200308.26308.jnareb@gmail.com> <20080824213634.GA16753@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 02:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXQDx-0000Aj-Ce
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 02:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYHYAlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2008 20:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbYHYAlp
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 20:41:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:33902 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYHYAlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 20:41:44 -0400
Received: by ug-out-1314.google.com with SMTP id c2so439252ugf.37
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 17:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=omlmVQZzRbBiARjMKzHm22roxxao9uoD+egPFFsRNno=;
        b=tieiGGrRiz+jykKag7d00xVkcQ85+AGQV5RYLzunfEMQ23+B8O7HNczqNc2LXR5ROj
         Wk4BqNQD/fK2jj9hAYD/V+rS6Jek0NuXquoLLI2v6cGXvSgLFcmPbhOuyPUFoxVQuAPa
         aHfM6gYIfUPLl1CuS/08gDduPZRUvuD52ugAk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HH/f+YWWt5l23A65AcWjpGdg3Ax43Ct7Y8qu/G87724Pmteiqp+RlqA7JKgypNe40O
         Qr09w7TfGg8XVN/8r8Fi9U7tBxE4XtB9ArsYFtsh63RIdg9a6MYwv2gpwHzeFjFXUj+H
         CEF4cjLdXYYvrnwbm21sWZNHrkd5ZP1GCLfE4=
Received: by 10.66.236.16 with SMTP id j16mr1876673ugh.31.1219624901883;
        Sun, 24 Aug 2008 17:41:41 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.185])
        by mx.google.com with ESMTPS id i39sm6536281ugd.47.2008.08.24.17.41.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 17:41:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080824213634.GA16753@leksak.fem-net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93581>

On Sun, 24 Aug 2008, Stephan Beyer napisa=B3:
> Hi again,
>=20
> > 8.  Which Git version(s) are you using?=20
> >  [ ] pre 1.3
> >  [ ] 1.3.x
> ...
> >  [ ] master
> >  [ ] next
>=20
> I wonder if people who do not know about master/next being git.git
> branches may do "[X] next" because they think they will use the next
> version available.
>=20
> So could you write "master branch of official git repository" and the
> same for "next"?

Thanks. I've added this.

> > 12. What other SCM did or do you use?
> ...
> > By "custom (non-published)" it is meant here version control system
> > which was not released to the public, for example something written
> > for yourself, or internal company project used only in company.
>=20
> Better:
>  "custom (non-published)" means a version control system which has
>  not been released to the public, for example, something written for
>  yourself or your company only.

Thank you, that is much better.

> And I am unsure if "SCM" is better than "version control system"
> in this sentence, but I do not think this is really important.

Hmmm...

> > 16. I use Git for (check all that apply):
> ...
> > Note that above choices are neither orthogonal nor exclusive.
> > You might want to check multiple answers wven for single repository=
=2E
>                                            ^^^^^^^^^ "even for a"
>=20

Corrected. Thanks.

> > 17. How do you obtain Git?
> ...
> >  [ ] pull form main repository
>             ^^^^ from

Corrected. Thanks.
=20
> > Explanation: binary package covers pre-compiled binary; source scri=
pt
> > is meant to cover installation in source-based distributions, like
> > 'emerge' in Gentoo.
>=20
> "pre-compiled binary (e.g. from rpm or deb archives)"

Thanks, added.

> > 59. Should Git User's Survey be repeated next year?
>  =20
> >  ( ) Yes
> >  ( ) No
> >  ( ) no opinion
> > Reset
>=20
> I wonder if the "no opinion" choice is not needed because there is th=
e
> "Reset" button.
>=20
>=20
> Apropos!
>=20
> Is it possible to add a header text?

It is possible.
=20
> I'd like that there are three things being clarified at the beginning=
 of
> the survey page:
>=20
>  * The survey is anonymous, but all information that the users provid=
e will
>    be publicly available on the wiki.
>=20
>  * The users may skip questions as they like.
>=20
>  * The user needs JavaScript to submit the survey.

Thanks for reminding this. I have added this to survey.

> I btw do not like the last fact, but since most users nowadays have
> JavaScript activated, it may not be that bad.

=46**k. I didn't notice this soon enough, and now I'd rather not re-ent=
er
all 60 questions. I have sent feedback that requiring JavaScript to be
able to submit survey is strange.

Survs.com came recommended here on this mailing list. I have chosen it
over editing old www.survey.net.nz because it had "other (please specif=
y)"
for both single answer (radio button) and multiple choice (checkbox)
question; later also because of the "matrix" questions. I didn't realiz=
e
that it requires JavaScript to submit... perhaps this would get correct=
ed
before starting point for Git User's Survey 2008 (1 September, or later=
).

> Also, I still do not get a succesful message after submitting, but th=
at
> may be related to the channel (test), if you have configured it like
> that. Have you? ;)

Yes, that depends on channel configuration, and I have forgot to add it
for this channel.

Thanks again for checking this survey, and for your comments.

BTW. here is analysis of 'test' channel (note that some questions, and
some possible answers, were added after starting 'test' channel):

  http://www.survs.com/app/4/wo/Y03N37u4Ou5p9SmoNrc5f0/0.0.33.1.1.1.1.5=
=2E1.1.0.1.1.7.11.0.1.0.13.1.1

--=20
Jakub Narebski
Poland
