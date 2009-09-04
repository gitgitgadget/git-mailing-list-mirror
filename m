From: Mark Struberg <struberg@yahoo.de>
Subject: Re: [JGIT] Request for help
Date: Fri, 4 Sep 2009 18:54:08 +0000 (GMT)
Message-ID: <78662.25308.qm@web27808.mail.ukl.yahoo.com>
References: <2c6b72b30909041150g6374be2ci4d36bd8ab0824a8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Douglas Campos <douglas@theros.info>, git@vger.kernel.org,
	Gabe McArthur <gabriel.mcarthur@gmail.com>
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 20:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjdvP-0003Ay-Hs
	for gcvg-git-2@lo.gmane.org; Fri, 04 Sep 2009 20:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933748AbZIDSyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Sep 2009 14:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933651AbZIDSyJ
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Sep 2009 14:54:09 -0400
Received: from web27808.mail.ukl.yahoo.com ([217.146.182.13]:32782 "HELO
	web27808.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757218AbZIDSyI convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Sep 2009 14:54:08 -0400
Received: (qmail 25843 invoked by uid 60001); 4 Sep 2009 18:54:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.de; s=s1024; t=1252090449; bh=6xTpR/qqJ+s/TUynoeRk3d0DHW7jywABfPI5yuwP/gw=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=fix3O8BNo8ELg8DJ1zaQWEA+VFbEDuyOGRchNl6RXCK6W3GF5qJH6hMhsI3F/vpVbofsOZnOEuxafXvUfNi4v5aO5vYshq71TCsqNjQ6WQLCQMh9aVSvVQa+nc8vgvNeV7PLPALLAu/T58GMVrQHrP0AHPPSHSVLp3dlAFwsF+4=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=PMUGizJZA2AxDtB1VTC0UVRaPmzrXtlPT89JRJ60h1OYez00cUBYr9ZiGOxMEnH9XsfSx+3eEn9hTDofQbFkvbGygsx9vKRtxDfSekTJmQypcDK5KnNekMNjjTent3NTjgwhHaGTO0npajgdoYfCkt03tqVwUxy0gUGvZIzViWk=;
X-YMail-OSG: pLfN.V8VM1nExfzXvSNv.325a32bcQF1yvfIyCXYGnUMJBN1km7AewZ9DjI8_1QcmDzFWwvmB9VPL9A4ygBw7RZY6.PW50BsC6rVCpY3tihn3nLmo6LcLTnSMmcQr8YBu4DMV0cxqDv1uODzTVsS6a8uj9IjSNMvTrQqBA8rM8hp761H9J7qA8Na0bjvNdDTZHqYh4xqR5u736ThzH5G1vlBBccTL_6Yto47pYku6_Fr91MxfnUlIapBeocxmgvCCYUpnbcqUWf7kL0n0c7ezy41ugCC45L5yPN5QMZMAMTLePh_PGmEy2tN
Received: from [81.16.153.112] by web27808.mail.ukl.yahoo.com via HTTP; Fri, 04 Sep 2009 18:54:08 GMT
X-Mailer: YahooMailClassic/6.1.2 YahooMailWebService/0.7.338.2
In-Reply-To: <2c6b72b30909041150g6374be2ci4d36bd8ab0824a8d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127759>

doing a rebase -i with new stuff atm... ;)

LieGrue,
strub

--- On Fri, 9/4/09, Jonas Fonseca <jonas.fonseca@gmail.com> wrote:

> From: Jonas Fonseca <jonas.fonseca@gmail.com>
> Subject: Re: [JGIT] Request for help
> To: "Mark Struberg" <struberg@yahoo.de>
> Cc: "Douglas Campos" <douglas@theros.info>, git@vger.kernel.org, "Gab=
e McArthur" <gabriel.mcarthur@gmail.com>
> Date: Friday, September 4, 2009, 8:50 PM
> On Fri, Sep 4, 2009 at 13:28, Mark
> Struberg<struberg@yahoo.de>
> wrote:
> > Hi!
> >
> > Work has been done at
> >
> > http://github.com/sonatype/JGit/tree/mavenize
> >
> > Please feel free to pull/fork and share your changes!
> I'd be happy to pull it in.
>=20
> IMO, there are a lot of things that can be squashed
> together and
> cleaned up. I know that you advocated for incremental
> introduction,
> but it seems wrong to for example add a file and then
> completely
> reformat it a few commits later. The same thing with the
> .gitignore
> fixes in step 5.
>=20
> Some comments ... Some of them I initially entered in
> github's
> codereview, but I ended up writing it all here.
>=20
> Commit: "mavenizing step 1: moved over the initial poms
> from Jasons branch"
>=20
>  * Please always add an empty line between the subject and
> the body
> =A0=A0=A0of the commit message. Like this:
>=20
> =A0 mavenizing step 1: moved over the initial poms from
> Jasons branch
>=20
> =A0 Signed-off-by: Mark Struberg >struberg@yahoo.de>
>=20
>  * The .gitignore pattern could be further limited to
> "target/" ...
> but you seem to change this to /target later.
>=20
> In org.spearce.jgit/pom.xml:
>=20
> =A0 =A0 * The use of maven-surefire-plugin should be
> removed. This module
> does not have any tests.
>=20
> =A0 =A0 * Shouldn't we retain the original
> ${groupId}:${artifactId} naming
> convention, being org.spearce:jgit?
>=20
> In org.spearce.jgit.test/pom.xml:
>=20
> =A0 =A0 * Dependency on jsch is unecessary since it
> is derived from
> org.spearce.jgit.
>=20
> =A0 =A0 * Maybe name as org.spearce:jgit-test?
>=20
> In org.spearce.jgit.pgm/pom.xml:
>=20
> =A0 =A0 * Maybe name as org.spearce:jgit-pgm?
>=20
> Commit: "mavenizing step 2: move the core libs from src to
> src/main/java"
>=20
>  * Please also add an empty line to this commit message.
>=20
>  * You might as well squash the whitespace fixes into the
> first commit.
>=20
> Commit: "mavenizing step 3: moving all core tests into the
> core module"
>=20
>  * The commit message wrongly states:
> =A0 =A0 org.spearce.jgit.test/tst/ ->
> org.spearce.jgit/src/test/java/tst/
> =A0=A0=A0Should be:
> =A0 =A0 org.spearce.jgit.test/tst/ ->
> org.spearce.jgit/src/test/java/
>=20
> Commit: "mavenizing step 4: moving some license files and
> META-INF"
>=20
>  * Shouldn't the commit message rather say "remove JSch"?
> =A0=A0=A0Then the moving of META-INF can be put in
> its own commit.
>=20
>  * The new NOTICE file has a few typos and the info could
> fit into the README
>=20
> Then I got a bit lost in a huge reformatting.
>=20
> --=20
> Jonas Fonseca
>=20


     =20
