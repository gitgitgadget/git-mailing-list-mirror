From: Tom Tobin <korpios@korpios.com>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 14:33:18 -0500
Message-ID: <1192649598.6640.44.camel@athena>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu>
	 <471476B7.5050105@users.sourceforge.net>
	 <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com>
	 <47148F72.1090602@users.sourceforge.net>
	 <1192548367.3821.4.camel@lt21223.campus.dmacc.edu>
	 <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net>
	 <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org>
	 <1192565900.6430.16.camel@athena>
	 <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org>
	 <20071017015109.303760cc@localhost.localdomain>
	 <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org>
	 <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
	 <alpine.LFD.0.999.0710170849590.26902@woody.linux-foundation.org>
	 <1192645509.6640.21.camel@athena>
	 <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 21:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiEeI-0006RU-6G
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 21:33:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761544AbXJQTde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Oct 2007 15:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761219AbXJQTde
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 15:33:34 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:59632 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbXJQTdc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 15:33:32 -0400
Received: by py-out-1112.google.com with SMTP id u77so4515859pyb
        for <git@vger.kernel.org>; Wed, 17 Oct 2007 12:33:26 -0700 (PDT)
Received: by 10.35.103.6 with SMTP id f6mr10905576pym.1192649603488;
        Wed, 17 Oct 2007 12:33:23 -0700 (PDT)
Received: from ?127.0.0.1? ( [208.75.86.189])
        by mx.google.com with ESMTPS id v55sm8642694pyh.2007.10.17.12.33.19
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Oct 2007 12:33:20 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0710171147190.26902@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61416>

On Wed, 2007-10-17 at 11:54 -0700, Linus Torvalds wrote:
>=20
> On Wed, 17 Oct 2007, Tom Tobin wrote:
> >=20
> > Or is "unix developers" code for "my sample size of one"?
>=20
> Well, let's put it this way: that "sample" is the one that started th=
e=20
> project.

And therefore your choices become magically reasonable?

> I got to pick the license. Are you going to argue about that too? I g=
ot to=20
> pick the way I wrote the code. Are you going to continue arguing abou=
t=20
> that?

The way you *wrote* the code is different from deciding how the code
*should* be written =E2=80=94 or is your code set in stone?  (Funny, co=
nsidering
that we're talking about a revision control system here.)

As for the license bit =C2=AD=E2=80=94 yes, you certainly *did* get to =
pick the
license.  What's your point?  We wouldn't even be having this discussio=
n
if it wasn't open source.

> The fact is, I don't see the people arguing for spaces having actuall=
y=20
> *done* anything for git. So why are you arguing?

Oh, here you pull out the big stick: if you haven't already done
anything for git, your ideas (as for what to, hmm, do for git) are
worthless!  Err, yeah, great perspective there.

> > Interesting how you waver between "certain developers" and "me".  I=
'm
> > convinced at this point that your argument comes down to "I can't u=
se my
> > favorite text editor with all-spaces, therefore all-spaces sucks".
>=20
> Umm. And I've *told* you that.
>=20
> The whole point is:
>  - every single damn editor out there can handle tabs.
>  - it's the default
>  - end of story.
>=20
> What's so hard to understand?=20

Every single damn editor out there can handle spaces.

The "default" is project-by-project.

Since you're BD in git-land, yes, your say-so is ultimately
end-of-story.  It doesn't make your argument reasonable.

> > As for *disk space*?  When we can measure cheap drives in sizable
> > fractions of *terabytes*, this simply isn't a serious argument.
>=20
> That disk-space translates into memory usage too, and into just being=
=20
> technically the *inferior* choice.
>=20
> How hard is that to accept? If you have a choice between a technicall=
y=20
> better solution, and a technically worse one, why are you arguing for=
 the=20
> worse one?

That disk space translates into memory usage exactly *how*?  Compiled
code?  Or the in-memory text while you're editing?  The former can't be
the issue, and the latter is trivial.

And, of course, this still comes up against the *benefits* of
all-spaces.  Benefits which have been mentioned by several people;
benefits which you refuse to *acknowledge*, even if they don't sway you=
=2E

> > Yeah, can you believe some projects actually *survive* with an
> > all-spaces indentation rule?  And ::gasp:: even *thrive*?
>=20
> Hey, I=CD=84'm not saying that others shouldn't use spaces. I'm sayin=
g that=20
> *git* should not, the same way the Linux kernel does not and will not=
=2E
>=20
> Why? Because tabs are better. You (or anybody else) have simply never=
=20
> given any argument against that very simple argument. You try to push=
 an=20
> inferior solution.

Uh huh.

> > Problems have been outlined, but since everything for you comes dow=
n to
> > "anything that comes between me and microemacs sucks", rational
> > discussion breaks down.
>=20
> Don't talk about "rational discussion", since you don't even *have* a=
ny.
>=20
> The starting point for any rational decision would be to explain why=20
> changing tabs to spaces would actually improve anything at all. And y=
ou=20
> have yet to show *any* such argument, while I've shown arguments to t=
he=20
> reverse.

You're being willfully blind here.

> One big one being: the person who started the project and still actua=
lly=20
> *does* something for it actually cares.

Because, once again, this makes your arguments correct, doesn't it?

> In contrast, your argument seems to be "I've not actually done anythi=
ng,=20
> but I want to paint the bikeshed pink".

Because, once again, being new makes one incorrect, doesn't it?

You've essentially demonstrated that git's "benevolent" dictator is an
asshole, and even worse, an irrational asshole.  It's one thing to deal
with a community member like that; when it's the BD, I think I'll move
along elsewhere.  Congratulations.
