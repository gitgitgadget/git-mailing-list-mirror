From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: GitTogether topics status
Date: Fri, 19 Sep 2008 08:35:54 +0200
Message-ID: <200809190835.55103.chriscool@tuxfamily.org>
References: <200809182207.21448.chriscool@tuxfamily.org> <200809190703.11969.chriscool@tuxfamily.org> <d411cc4a0809182303x365e2280r3fc8a9a3534d8890@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 19 08:33:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgZYq-00028S-Pg
	for gcvg-git-2@gmane.org; Fri, 19 Sep 2008 08:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbYISGcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 02:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbYISGcj
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 02:32:39 -0400
Received: from smtp8-g19.free.fr ([212.27.42.65]:50168 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbYISGci convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 02:32:38 -0400
Received: from smtp8-g19.free.fr (localhost [127.0.0.1])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 914E732A807;
	Fri, 19 Sep 2008 08:32:37 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 6DFE932A80B;
	Fri, 19 Sep 2008 08:32:37 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <d411cc4a0809182303x365e2280r3fc8a9a3534d8890@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96260>

Le vendredi 19 septembre 2008, Scott Chacon a =E9crit :
> Hi,
>
> On Thu, Sep 18, 2008 at 10:03 PM, Christian Couder
>
> <chriscool@tuxfamily.org> wrote:
> > Le jeudi 18 septembre 2008, Jakub Narebski a =E9crit :
> >
> >> What also might be interesting to talk about scriptability, having
> >> defined API, libification (I see that there is planned), interface=
s to
> >> other programming languages versus calling git plumbing versus
> >> reimplementing git in other languages (e.g. JGit vs JavaGit, Grit =
vs
> >> Ruby/Git, GitPython vs PyGit, Git.pm vs Git::Repo), but I guess th=
is
> >> discussion could be had on git mailing list.
> >
> > The following topics are now together on the wiki:
> >
> >  * Linkable library for basic object access (libification or new
> > library) * Scriptability, using git in other languages (using
> > interfaces vs calling plumbing vs reimplementting)
> >
> > The second one is new.
> >
> > If we want these topics to be discussed during the GitTogether, we =
need
> > someone who wants to talk about or at least introduce these subject=
s
> > though. (Hint, hint.)
>
> I would be happy to talk about / introduce at least the second one,
> since I've done most of the work on the pure-ruby implementation of
> git in the Grit project, which is one of the more popular of the
> re-implementations out there (and runs the GitHub site).  I would als=
o
> be happy to help with a discussion on the first one, since I added it
> to the wiki in the first place and it is heavily connected to the
> second topic.  I very much want to see a library that provides basic
> Git object access that we can use to write proper bindings in
> Ruby/Python/Perl.  If the current Git code is too difficult to libify
> properly, then perhaps an alternate C implementation that is built
> only for that purpose is preferable to having a re-implementation in
> _every_ language.  Looking forward to the discussion.

Great! You are now in the "Possible speakers" list on the wiki.

Thanks,
Christian. =20
