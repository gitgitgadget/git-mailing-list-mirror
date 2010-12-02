From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-commit.txt: Order options alphabetically
Date: Thu, 02 Dec 2010 06:23:16 -0800 (PST)
Message-ID: <m3wrns2r2d.fsf@localhost.localdomain>
References: <1291215526-11428-1-git-send-email-jari.aalto@cante.net>
	<20101201165043.GF26120@burratino> <87r5e1v2g8.fsf@picasso.cante.net>
	<7vzkspuw8g.fsf@alter.siamese.dyndns.org>
	<295D1E95-1C61-4960-8C9C-BDB0BD4A1A50@sb.org>
	<87mxopt8my.fsf@picasso.cante.net>
	<E02740CE-37EE-4701-BB2D-18AD493D1C05@sb.org>
	<87aakpt7uw.fsf@picasso.cante.net> <20101202095324.34237fb2@jk.gs>
	<87fwugs7pf.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, =?iso-8859-15?q?Jan_Kr=FCger?= <jk@jk.gs>,
	Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 15:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POA4F-0007nr-QI
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 15:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827Ab0LBOXV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 09:23:21 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45431 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757813Ab0LBOXU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 09:23:20 -0500
Received: by ywl5 with SMTP id 5so4102874ywl.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 06:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=MnyY7r8Gn4rIRHfJmJ52GV4SOhCCMfTyrIgiXd+yCoo=;
        b=C1sqSBjTJta6yHY/tumxxCIWjEKibqDCgriCfsJ6YvVW0Rb4iV0OrwkOR52WnQ6947
         hF7aI73Vi0lFYk2rS57D22YXzL+d1eGeqTMgX0V8iNlfzNZrCUtqyCECVqn7L9ZL3cUQ
         7NIc26ZFtCCWQd9RbKQ/3vHLy3B6SgFWnpKek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=PK7FGeIzxzoAN1KGweHeEKkjPy0lsJHd8+6ZvY93D1vBeA/zOGZAPwp1SaBt/rgMAK
         ThdQrbHqrRk5094Wm04CivLdVU9uYvVdFUeLrH2NG5FGq6rT+msqtea9QrhyCjaRbQ7z
         AXSPJZz3pXHQWasAItCGf1p55Wq7V54oMUW6U=
Received: by 10.223.115.203 with SMTP id j11mr663394faq.35.1291299799092;
        Thu, 02 Dec 2010 06:23:19 -0800 (PST)
Received: from localhost.localdomain (abwq166.neoplus.adsl.tpnet.pl [83.8.240.166])
        by mx.google.com with ESMTPS id y3sm199500fai.14.2010.12.02.06.23.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 06:23:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oB2EMKnP021383;
	Thu, 2 Dec 2010 15:22:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oB2ELllR021378;
	Thu, 2 Dec 2010 15:21:47 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87fwugs7pf.fsf@picasso.cante.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162707>

Please do not cull Cc-list, i.e. respond replying to all people who
participate in given (sub)thread.  (If it is not possible, tell why).

Jari Aalto <jari.aalto@cante.net> writes:
> 2010-12-02 10:53 Jan Kr=FCger <jk@jk.gs>:
> > [Cc un-culled]
> >
> > --- Jari Aalto <jari.aalto@cante.net> wrote:
> >
> > > The reader have to guess "imagined groups"? Hm, that's interestin=
g.
> >
> > Perhaps a more desirable (and agreeable) patch would introduce grou=
p
> > subheadings, then?
>=20
> Yes, that's the standard way of doing groups. Just like it's being do=
ne
> in other manual pages that are huge. But it is not being done in smal=
l
> manual pages. GNU project certainly doesn't in general.

Note that GNU project produced many more or less stupid/smart
conventions.  It doesn't mean that we should follow them blindly
(alphabetical sorting of options in manpages, GNU ChangeLog format,
GNU indent style for C).

>=20
> I agree that doing "groups" makes only sense on pages that have large
> number of options. For a screenful, it's more distracting than worth.

The other side of the fact that creating subsections grouping types of
options makes only sense for pages/groups that have large number of
options is that we need sorting by function, grouping related options
together.  See also use case below.

> > In rev-list-related options we already have a couple of explicit
> > groups.
>=20
> I can't find that manual page or file under Documentation/, could you
> help here?

"man git-rev-list", Documentation/rev-list-options.txt
=20
[...]
> Well. In my experience (having watched others to learn) the manual pa=
ges
> are not the source used for learning.

Counterexample: Perl.

> People go to the manual pages once they have a specific need for
> infomation and details. I could sketch these uses of manual pages:
>=20
>     - Someone throws up a git command (IRC #git, Blogs, Web page). Wh=
at
>       do all those unreadable one letter options mean? Gosh they don'=
t
>       even mean the same accross different git* programs.
>=20
>       > He searches manual pages A-Z, easy to spot all options. Not
>       > interested in related things. He tries to understand the
>       > command, script etc.

Contrived use case.  Disregarded.

>=20
>     - Someone is learning Git.
>=20
>       > He certainly does not start from manual pages. Other soources=
 of
>       > information are more in to him. Besides  Windows does not hav=
e those.

Did you check that 'man git-<cmd>' doesn't work on git on MS Windows
(msysGit, git from Cygwin)?

You can always use 'git --help <cmd>'.

>       > We might guess what MySGIt as other do: they reach Google but=
ton.
>=20
>       This person just wants to solve a problem, get things done, the
>       faster the better. The easier the better, the less thinking the
>       better.

They read "Git User's Manual", or "Pro Git", or perhaps "Git Community =
Book"
(the first included with git, the second and third available on-line).

>=20
>     - Geek. He wants to learn inside out.
>=20
>       > He digests all. Related options, related pages, flipping
>       > form man to man as he knows all the glory details is just the=
re.

And for geek grouping related options/config variables together is
helpful.


You omitted very important use case, something that was mentioned more
than once in this and related threads:

      - Someone wants to know/remember how to do something in Git.
        Assume that this someone knows git quite well, but not by heart=
=2E

      Here there is example that was give to you in this thread (or
      related subthread), namely someone checking the name of option th=
at
      ignores whitespace, and because related options are grouped toget=
her
      the he/she realizes that he/she wants different but related optio=
n
      (-b/--ignore-space-change vs -w/--ignore-all-space).

      Another example could be someone searching for config options tha=
t
      affect git (re)packing performance.  Currently those config optio=
ns
      are grouped together.

      If options are sorted alphabetically this task is made much harde=
r.
      Note that he/she know how to use searching in pager or web browse=
r.

> It all depends if it is desireable to make pages more approachable to
> the average group, or are they kept to serve only small core audience=
=2E
>=20
> There are 100+ manual pages in the git distribution. You get even
> disoriented in sheer numbers of them. And you have to throw dice to
> figure out in what page that information might be you are currently i=
n
> need.
>=20
> It's classical case of how to arrange information for easy retrieval.
> Think Libraries as model.

Computerized index, or manual?  Perhaps it is classical case, but it is
outdated: modern solutions use folksonomies / labels / tagging rather t=
han
Trove / Dewey classification or alphabetical sorting.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
