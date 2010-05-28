From: Andreas Ericsson <ae@op5.se>
Subject: Re: cvs update vs. git pull
Date: Fri, 28 May 2010 11:35:18 +0200
Message-ID: <4BFF8E56.7050805@op5.se>
References: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Moser?= <mail@renemoser.net>
X-From: git-owner@vger.kernel.org Fri May 28 11:35:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHvyS-0005dr-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 11:35:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774Ab0E1JfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 May 2010 05:35:23 -0400
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52840 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753893Ab0E1JfX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 May 2010 05:35:23 -0400
Received: from source ([209.85.214.45]) by na3sys009aob108.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS/+OWfM7f7LSZo5eOBAuT9IVY9J7HwMo@postini.com; Fri, 28 May 2010 02:35:22 PDT
Received: by bwz17 with SMTP id 17so39115bwz.18
        for <git@vger.kernel.org>; Fri, 28 May 2010 02:35:21 -0700 (PDT)
Received: by 10.204.161.211 with SMTP id s19mr5314551bkx.129.1275039319863;
        Fri, 28 May 2010 02:35:19 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id r38sm9657375bkk.3.2010.05.28.02.35.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 May 2010 02:35:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4 ThunderGit/0.1a
In-Reply-To: <d876ae6b75ab8d9debe5b97f84a4386a.squirrel@resmo.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147921>

On 05/28/2010 11:21 AM, Ren=E9 Moser wrote:
> Hi
>=20
> I use git since a while for my own projects (how surprise).
>=20
> The company I work for still uses a CVS(nt), and this sucks, time to
> changed that. We have a use case we often have problems with. If git =
would
> solve this problem, I would really have a good arg for the managers.
>=20
> The codebase managed by CVS is quite huge and therefore we have daily=
 and
> nightly builds.
>=20
> One problem we have is, that if there is a commit to cvs while the cv=
s
> update of the build job is running (and this takes 20 minutes), then =
we
> get some inconsistence, the build will fail.
>=20
> So the question is, if we would use git, this inconsistence would not=
 be
> possible because the git pull will get the state of the sha1. Right?
>=20

Right.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
