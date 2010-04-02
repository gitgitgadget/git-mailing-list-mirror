From: Raymond Auge <raymond.auge@liferay.com>
Subject: Fwd: sadly requesting help
Date: Thu, 1 Apr 2010 22:21:47 -0400
Message-ID: <i2leaacf13c1004011921l672a003qed3749f50fbbcca6@mail.gmail.com>
References: <eaacf13c1003301543r45bb18b2n1d10d209f01e3326@mail.gmail.com>
	 <2010-03-31-10-53-47+trackit+sam@rfc1149.net>
	 <x2weaacf13c1004011920r45db6608ub4a5b002a2caf335@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 02 04:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxWWD-0006aT-Mj
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 04:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab0DBCVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Apr 2010 22:21:50 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:44280 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab0DBCVt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Apr 2010 22:21:49 -0400
Received: by wwb17 with SMTP id 17so1180054wwb.19
        for <git@vger.kernel.org>; Thu, 01 Apr 2010 19:21:47 -0700 (PDT)
Received: by 10.216.1.133 with HTTP; Thu, 1 Apr 2010 19:21:47 -0700 (PDT)
In-Reply-To: <x2weaacf13c1004011920r45db6608ub4a5b002a2caf335@mail.gmail.com>
Received: by 10.216.87.147 with SMTP id y19mr888217wee.136.1270174907591; Thu, 
	01 Apr 2010 19:21:47 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143772>

Thank you Samuel,

We have plans to migrate to git in the near-ish future.

I'm doing my best to show it's=C2=A0merits to my colleagues.

I'm still a newbie, with only weeks of experience. But already it has
saved many hours of my time and allowed me to work much more
effectively and=C2=A0comfortably. I have at least 5-10 local branches t=
hat
I trivially hop across during the course of a day. I would have never
dared to do this with subversion. It was hard to innovate, and since
innovation is my job, git saved my day!

Ray

On Wed, Mar 31, 2010 at 4:53 AM, Samuel Tardieu <sam@rfc1149.net> wrote=
:
>
> >>>>> "Raymond" =3D=3D Raymond Auge <raymond.auge@liferay.com> writes=
:
>
> Raymond> We had a colo failure over the last day or so and lost the l=
ast
> Raymond> 50-60 commits on our subversion repository (apparently, our
> Raymond> backup strategy was not granular enough).
>
> Raymond> Luckily I use Git locally using the git-svn conduit.
>
> Raymond> I need to rewind my repository to an earlier revision and I'=
m
> Raymond> hoping not to have to rebuild my local repo as the project i=
s
> Raymond> huge and takes me at least 16 hours to checkout using git-sv=
n.
>
> I know this does not answer your question, but why not use this incid=
ent
> to switch to git, or at least to seriously investigate a possible fut=
ure
> switch to git?
>
> As you probably know, with git it would have been really easy to rest=
ore
> the full repository if at least one person does have a local copy of
> each branch (typically, the last person to have committed on a branch=
 is
> likely to still have a full copy of the branch). And backups can be d=
one
> simply by running "git fetch" from a secondary machine at regular
> intervals.
>
> Success story: the company I worked for in 2008 had a similar inciden=
t a
> few months after we switched from svn to git. Not only were we able t=
o
> restore a full repository copy, but also we were able to work in the
> meantime by setting one of the developers machine as the central
> repository, and development work was not disrupted for more than one
> hour (we had to educate some developers who were not familiar with
> setting remotes other than "origin" and pushing to them). We ran this
> degraded setting for a few days (degraded because we lost continuous
> testing and packaging capabilities that ran on the main server, and
> developers had to run the test themselves by issuing frequent "make
> check" commands), but it was certainly not considered a major failure=
=2E
>
> In four words: git saved the day.
>
> =C2=A0Sam
> --
> Samuel Tardieu -- sam@rfc1149.net -- http://www.rfc1149.net/
>

Raymond Aug=C3=A9
Senior Software Architect
Liferay Inc.
--
Liferay East Coast Symposium
Jun 8-9, 2010
Reston, VA
Register today!
--
=46ollow us on Twitter: liferay
