From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
Date: Sat, 26 Sep 2009 20:10:16 +0000 (GMT)
Message-ID: <892492.1652.qm@web27801.mail.ukl.yahoo.com>
References: <200909252317.02296.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: MatthiasSohn <matthias.sohn@sap.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"spearce@spearce.org" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 22:10:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mrdb7-0002FB-CK
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 22:10:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbZIZUKP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2009 16:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbZIZUKP
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 16:10:15 -0400
Received: from web27801.mail.ukl.yahoo.com ([217.146.182.6]:23784 "HELO
	web27801.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750795AbZIZUKN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 16:10:13 -0400
Received: (qmail 3986 invoked by uid 60001); 26 Sep 2009 20:10:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1253995816; bh=YRU0ls+2FIIcGLdxgIuZvkvG8yBZytj1XhevatVaizU=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=FP9cbd/quwOFi1K1HmSYnd9KElsvEpnSyoVWrD4P6qOqWslKloYqtWFmyOICC/WsLGiWw7EdIda8r7qLX/dbP5YqkqFSUz9BOELvfH3LUR9MtwKHPQMa9zE359ZdgerRirlH34QnVjb2yomZpIbCjajFjYOhYSkwJ0FIn1RSt9g=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VjiSY4aqexOS1hW1+a/zgeDbCLNjYufz5Vo9J4D59DgXSpWtSarTS6FVh1fvH8UVTRMbW8ctitMnnmJ1iwvCm42GPzhD86Vp4fhEEwLfHwbk7tgbvVhkYMrQIRn3if+uKNGFHyYlMBrfBZvhth1rtVhO4trv/X6+FoNnNnyqM2I=;
X-YMail-OSG: cV1VZxUVM1nqQP3owtZ7e.IBYivELEimGPArPq2trzb0w.5yW8nOYEHl37mbQ6fz6dWXqrWZm.H8i7_xgDGUDEWwemTHyQDoKF0tn5eerfL7WizyUHys7iQpVZcCBfY8WaLiSl_2qU2jgvltwaOVB4rOT9g1PqTcooeNDem8MW8n73hnyTR3JdK78ZY1cc6QFA.mp.z_xiFkEeNLt8IypvP96h7sSb3xyvmODuNSP6iNDn4sxs7lQnCB3Z39dLDj5tvaIwA8S904elijb.XzRm2osU1TFd0deNfZ_jqajMvSs.l3qQPZ
Received: from [62.47.130.12] by web27801.mail.ukl.yahoo.com via HTTP; Sat, 26 Sep 2009 20:10:16 GMT
X-Mailer: YahooMailClassic/7.0.14 YahooMailWebService/0.7.347.3
In-Reply-To: <200909252317.02296.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129175>

Hi Robin!

Thanks for your comments, answers inside.

Please note that all my comments are for JGit only and not for the Egit=
 Eclipse plugin! This should be discussed separately.

LieGrue,
strub

--- On Fri, 9/25/09, Robin Rosenberg <robin.rosenberg.lists@dewire.com>=
 wrote:

> From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
> Subject: Re: [JGIT PATCH 7/9] removing eclipse project files
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "MatthiasSohn" <matthias.sohn@sap.com>, "git@vger.kernel.org" <gi=
t@vger.kernel.org>, "spearce@spearce.org" <spearce@spearce.org>
> Date: Friday, September 25, 2009, 11:17 PM
> torsdag 24 september 2009 13:50:11
> skrev Mark Struberg <struberg@yahoo.de>:
> > Hi Matthias!
> >=20
> > the answer is a clear yes and no=A0 - a 'jein' for
> german speaking people like you ;)
> >=20
> > yes: we have the same settings for the compiler as
> used before: jdk 1.5 for source and target. This is exactly
> what has been taken in the ant build which was used prior to
> maven.=20
> >
> > Please note that the settings in
> org.eclipse.jdt.core.prefs never had (and must not have) any
> impact on the created jar!
>=20
> Not sure what ant files you are referring to here and which
> jars. The plugins downloadable from jgit.org has been built
> using PDE build. so some of the .settings should affect the
> compiler and thus the generated jars.


Apologise, you are right, no ant files. But a shell script make_jgit.sh=
 which calls the javac directly. So no PDE for JGit as far as I see fro=
m the sources.

>=20
> > and no: currently the very file you mentioned contains
> a lot more stuff. In fact most of this are only editor
> settings, preferred formattings etc which has nothing to do
> with the build per se. Eclipse has the ability to
> import/export all those settings in a XML file which is
> version independent. We should go this way and also supply
> similar setting-files for Idea and NetBeans. But forcing
> those settings via an internal Eclipse plugin config file is
> imho bad practice.
>=20
> That way is awkward and people to import the settings and
> screw them up in their workspaces. I've made the projects
> I'm involved use .settings and make different settings
> mostly a non-issue because everyone gets new
> settings automatically as they change.=20

We should integrate the checkstyle plugin into our pom. This should giv=
e you almost the same functionality.

> Prior to eclipse 3.3
> sharing settings was a big problem, but It's not a big deal
> nowadays. The most annoying thing is that some settings are
> not available as project specific settings.=20

As you already pointed to: we have to clearly separate between settings=
 stored in the project itself and settings stored in the workspace. The=
 first are by far not all settings needed, the 2nd are not checked in t=
o git anyway. Maybe I didn't  find it yet, but is there an ability to s=
et formatter settings for XML (e.g. Tabs vs spaces policy)? I was only =
able to specify this for the whole workspace and not on a per project b=
asis. And there is a lot more which imho cannot be set for a project. S=
o checking in the xml sounds like it is way more powerful isn't? And we=
 would have this feature for a lot non-Eclipse users too (e.g. for Jona=
s who hacks the nbgit NetBeans plugin based on JGit (again: EGit is a d=
ifferent story!)).

>=20
> We use 3.3 (well I think the last user dropped it
> recently), 3.4 and 3.5. I often have to fix up new projects
> but that is typically a one-time per eclipse project
> problem. (typically the JRE gets bound to a specific install
> location).
>=20
> The .launch files is another story since they change format
> all the time.

And the profiler settings, and and and. It's sad, but the list is long =
:(

We can also let the eclipse settings files checked in currently if you =
like. But I'd be happy if we continue collecting information and then m=
ake a decision.

txs,=20
strub




     =20
