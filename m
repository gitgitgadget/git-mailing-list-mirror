From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - trial run
Date: Fri, 26 Jun 2009 17:44:04 +0200
Message-ID: <200906261744.04610.jnareb@gmail.com>
References: <200906252122.51737.jnareb@gmail.com> <94a0d4530906260412h78b55458gc722964011edb54d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 17:44:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKDbB-0003Eg-0J
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 17:44:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbZFZPoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 11:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbZFZPoG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 11:44:06 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:37898 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbZFZPoE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 11:44:04 -0400
Received: by fxm9 with SMTP id 9so2183834fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=U8nodrcIxgzPucSyG3YpZCZZ8IKWrsGVMICAl7FsmZI=;
        b=gvb6opkRKQ/Vxl5DkNJYejtzy5d6CjQEtZMl9UbNDpLIdFib0FMd3mbrRXOVD6XtE/
         JOimDCkCbUobYMaWqjCugKPMPC8I24/ZHmA8RoEXyKgrA/yuAD9X2hn0esheFtoooBqq
         EzZFwl8JFDnJN3XxoSmLXzWI9j6FjmX/65Vus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=f7Dox55sank3zeU20MgopvbCmyrZgYf69j8052n3/+4Qo6pu8F4Y8FGj8LKHuvQHel
         xcCv2i0178frmQGk4JfBX4iektjAf2YKJkMaRB0nJuOzrAoM99KoeSgaZXpiTzFS+gn3
         ZqLT/MnltVzFgiMJS0Pvt/Z+WtWi6gJtWaZEA=
Received: by 10.103.248.17 with SMTP id a17mr2346701mus.97.1246031046139;
        Fri, 26 Jun 2009 08:44:06 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id 7sm18143150mup.24.2009.06.26.08.44.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 08:44:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <94a0d4530906260412h78b55458gc722964011edb54d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122305>

On Fri, 26 June 2009, Felipe Contreras wrote:
> 2009/6/25 Jakub Narebski <jnareb@gmail.com>:

> > I have created _proposed_ version of questions for upcoming
> > "Git User's Survey 2009", based on (a bit of) feedback on git
> > mailing list:
> > =C2=A0"[RFH] Questions for Git User's Survey 2009"
> > =C2=A0Msg-Id: <200905291855.03328.jnareb@gmail.com>
> > =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/120287
> > and comments on #git IRC channel on FreeNode.
> >
> > Current version of survey has 30 questions, as compared to
> > 60 questions last year; the number of free-form essay questions
> > were also greatly reduced.
> >
> >
> > The *test* version of this year survey can be now found at
> > the following URL (as in previous year, we use Survs.com)
> >
> > =C2=A0http://www.survs.com/survey?id=3D2PIMZGU0&channel=3DTFN2Y52K7=
Y

I reworked those comments a bit, to make it easier to see
proposed changes.

> These are my comments:
>=20
> -3. Did you find Git easy to learn?
> +3. Have you found Git easy to learn?
>=20
> That assumes the user already learned to use git [...]

Thanks.  I think your version is better.

>=20
> -8. How do you obtain Git?
> +8. How did you obtain Git? (maybe s/obtain/install/)
>=20
> Most people install once, or at least not very often

Perhaps

  +8. How did/do you obtain Git?

It is IMHO more interesting how people upgrade Git, than just how
they installed it.

>=20
> -14. How do you fetch/get changes from upstream repository?
> +14. How do you fetch/get changes from upstream repositories?
>=20
> Only one repository?

Good catch.  Thanks.

>=20
> git ... --dirstat
>=20
> Isn't '--stat' more common?
> git ... --stat (or --dirstat)

Well, this is specifically about this rare used feature/option.
"git ... --stat" or "git ... --summary" is a byproduct of many
other commands, like "git pull" / "git merge", or "git format-patch".
But perhaps we should ask about it explicitly.

>=20
> -18. Which of the following features do or did you use?
> +18. Which of the following features have you used?
>=20
> More readable.

True.  Thanks.

>=20
> -22. Did you participate in previous Git User's Surveys?
> +22. In which of the previous Git User's Surveys have you participate=
d?
>=20
> -24. Which form of Git documentation do you use?
> -    Do you consider them useful?
> +24. How useful have you found Git documentation?
>=20
> -28. Do you read the mailing list, or watch IRC channel?
> +28. Which communication channels do you use?

Good ideas.

>=20
> Also, I would like to see a list of areas users would like improvemen=
ts:
> XX. In you opinion, which areas need improvement?
>  * user-interface
>  * documentation
>  * performance
>  * more features
>  * other
>=20
> Is there a way for users to assign points? eg. user-interface: 2,
> documentation: 1, more features: 1

We can always use 'matrix' form, with columns corresponding to importan=
ce
of a given area for improvement (1-3, or 1-5 numeric range).  Because
asking user to order from most important to least important (one can
enforce this on Survs.com by requiring only one answer with given colum=
n
selected) would be too difficult and confusing.

>=20
> I like it better than the previous one :)

Thanks!

--=20
Jakub Narebski
Poland
