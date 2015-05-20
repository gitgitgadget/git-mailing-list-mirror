From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: Ensimag students contributing to git
Date: Wed, 20 May 2015 16:03:57 +0200 (CEST)
Message-ID: <2016988320.1099109.1432130637289.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <722582475.919095.1431991277969.JavaMail.zimbra@ensimag.grenoble-inp.fr> <388720318.919104.1431991388837.JavaMail.zimbra@ensimag.grenoble-inp.fr> <CAP8UFD2hCScvEZxxFCc4XWLJuHM-SyqZ_x4sdmwXj8WVHrW4tQ@mail.gmail.com> <CAP8UFD16vb_-rp7kiATd=XW5FK+P+qkME8hPMku571_PDCQywg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	=?utf-8?B?UsOpbWk=?= Lespinet <lespiner@ensimag.grenoble-inp.fr>,
	Guillaume =?utf-8?Q?Pag=C3=A8s?= <pagesg@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 16:10:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv4hD-0001bY-DH
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 16:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbbETOJ5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 10:09:57 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:54344 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752819AbbETOJ4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 10:09:56 -0400
X-Greylist: delayed 475 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2015 10:09:55 EDT
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 270F528BA;
	Wed, 20 May 2015 16:01:58 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VNLZ1bRp8qPw; Wed, 20 May 2015 16:01:58 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 153B228B9;
	Wed, 20 May 2015 16:01:58 +0200 (CEST)
In-Reply-To: <CAP8UFD16vb_-rp7kiATd=XW5FK+P+qkME8hPMku571_PDCQywg@mail.gmail.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: Ensimag students contributing to git
Thread-Index: NLqM89PNDQ059fcB5fWDLi5SsaloEw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269467>

On May 19, 2015, Stefan Beller wrote :
>On Mon, May 18, 2015 at 4:23 PM, Antoine Delaite
><antoine.delaite@ensimag.grenoble-inp.fr> wrote:
>> Hello Git community,
>>
>>
>> We are a team of five students from the ENSIMAG (a french school of =
engineering and computer science) who are going to contribute to git du=
ring a month at least and after if we have the opportunity. We will wor=
k under the supervision of Mr. Moy.
>>
>>
>> We are glad to contribute to git and we are looking forward to getti=
ng advices and reviews from the git community. It will be a great exper=
ience for us as young programmers.
>>
>>
>> We planned to work on =C2=AB git pull =E2=80=93setupstream =C2=BB fo=
r the first days if nobody is currently working on it and then we thoug=
ht of finishing the work of elder contributors from the ensimag on : =C2=
=AB git bisect fix/unfixed =C2=BB.
>
>git pull is being converted from shell to C as part of the
>Google Summer of Code (cc'ing Paul Tan who is the
>student, and Johannes Schindelin and me who are the
>mentors) so there may be some merge conflicts arising
>if we go uncoordinated. See a planned timeline of Paul
>at [1]. Depending on your timeline, it might be wise to
>hold on a bit and then base your contributions on the C
>implementation rather than the bash implementation.

Thank you for the warning, we will wait for the C implementation then.

On May 19, 2015, Stefan Beller wrote :
>I am not aware of the scope you're planning to contribute
>to within the git bisect fix/unfixed topic, though I'd like
>to share a result[2] of a discussion we had some time
>ago, on how git bisect can be improved (nobody did it
>yet though).

On May 19, 2015, Christian Couder wrote :
>It's interesting, but the document doesn't really explain what is not
>optimal with the current algorithm and why the proposed algorithm is
>better.

=46or now we are not planning on heavily modifying the algorithm of=20
git bisect but we are rather planning on fixing an existing patch=20
considering that we are new to the mailing list and patches=20
(though we might have to modify partly the algorithm in the end,=20
we have not really begun to dwelve into the code of git bisect yet).

On May 19, 2015, Christian Couder wrote :
>Last Autumn I started to work a bit on =C2=AB git bisect fix/unfixed =C2=
=BB (or
>more accurately =C2=AB git bisect old/new =C2=BB) by applying and rewo=
rking a
>bit what your Ensimag elders had done. It is not much but maybe it can
>help you a bit.
>
>It is on this branch on my github repo:
>[...]
>https://github.com/chriscool/git/commits/boldnew2
>
Thank you very much, this will be really useful.

On a different note, we have started to work on the following points,=20
to get used to the code of Git, writing the tests, documentation... :
 - A possibility to configure git am so that it uses the option -3way
automatically by adding the boolean am.3way in .gitconfig.
The conversion from a bash version to a C version is no big matter.
 - Adding the possibility to use the key-word 'drop' in git rebase -i,=20
it has the same effect as deleting the line (removing the commit) but=20
allows a better control of your actions and reduces the possibility of
removing a commit by mistake.
We plan to work on the following points :
 - Adding warning/errors when removing commits by removing the line in
git rebase -i. This would be configurable through the variable=20
rebase.dropBehaviour in .gitconfig, it would have 3 states ('ignore',=20
'warn', 'error'). 'ignore' would be the same behavior as currently,
'warn' would display a warning (the rebase would still proceed) when a=20
commit is removed through line removal and 'error' would stop the=20
rebase instead.
 - Fixing a patch for git bisect fixed/unfixed as stated earlier.
 - Working on git pull --set-upstream (similar to what git push
--set-upstream does) after the C implementation of git pull.

The above list is most likely to change according to the difficulty,=20
the time needed and other parameters.

Thanks again,
R=C3=A9mi Galan Alfonso, R=C3=A9mi Lespinet, Antoine Delaite,=20
Louis Stuber, Guillaume Pag=C3=A8s
