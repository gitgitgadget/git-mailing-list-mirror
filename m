From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/2] po/de.po: add German translation
Date: Thu, 16 Sep 2010 13:51:26 +0200
Message-ID: <4C9204BE.800@drmicha.warpmail.net>
References: <20100915093313.44396t6yr62ixccg@webmail.tu-harburg.de> <20100916125751.163d8691@jk.gs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Stimming <stimming@tuhh.de>, trast@student.ethz.ch,
	avarab@gmail.com, git <git@vger.kernel.org>
To: =?UTF-8?B?SmFuIEtyw7xnZXI=?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Sep 16 13:51:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwD05-0007eM-Kq
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 13:51:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab0IPLvX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 07:51:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:59348 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754454Ab0IPLvW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 07:51:22 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 006C1574;
	Thu, 16 Sep 2010 07:51:21 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 16 Sep 2010 07:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=d4W9DiozlC+gWn/meRNkbrPl40E=; b=sRUX4Ft0bD3umh6tyf7j2b888B/Qae6AKoUXVWQjRpYJ3j99PgIp4iEa0vNR/U6MMB55xL21G+ZZKbbS4x5Xs0+moa/ux7MU3NhJvSZBwEkd28vlCY/JWogvETvrOuPoghqZ4tBC1sOMG33lsEcErHrUVXtVbOlTo7scisJcZGw=
X-Sasl-enc: PCxugpHhwhICYcq7eeV6FkhLu9BUiwsMrn1ZcW/4a2MW 1284637881
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 069975E6175;
	Thu, 16 Sep 2010 07:51:20 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100907 Fedora/3.1.3-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.3
In-Reply-To: <20100916125751.163d8691@jk.gs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156325>

Jan Kr=C3=BCger venit, vidit, dixit 16.09.2010 12:57:
> Christian Stimming <stimming@tuhh.de> wrote:
>=20
>> As you might guess, as the (initial) translator of git-gui I've been=
 =20
>> through this discussion before [1] and as you have noticed, I have =20
>> decided to take a translation approach different from what you have =
=20
>> recently discussed here. I deliberately tried to translate as much
>> of the terms into German as possible. I do not agree about the
>> importance of statements on this mailing list like "This translation
>> translates too much terms - I cannot find the commands I'm used to".
>> The point of a translation is to enable the usage of a program to
>> people who do *not* know the original language.
>=20
> Please explain how translating all terms makes it easier for Germans =
to
> work with git. As far as I am concerned, all the terms you tried so
> hard to translate are technical terms, i.e. their full meaning cannot=
 be
> readily understood without an explanation. That is the reason why we
> have a glossary for those terms even in the English original.
>=20
> Translating these terms into German does not change anything about
> that. All terms still need to be explained.

Absolutely true, and absolutely irrelevant for the decision whether to
translate these, since they need to be explained in any case.

>=20
> There is some slight potential gain in that perhaps *some* translated
> words will be more easily associated with their corresponding
> explanations due to the imagery they use,

The aim of a good translation is to reproduce the concept, not the word=
=2E
I assume we're talking about a (mostly) non-English speaking target
audience here, and for them associating meaning with terms in their
native language is certainly easier.

=2E..
> There are quite a few examples in the git-gui translation that I
> consider extremely unwieldy, and in my initial translation of git
> itself I tried very hard to avoid translations like "Bereitstellung
> (zum Eintragen)", where I have absolutely no idea what that is suppos=
ed
> to mean. I don't want to turn this into a critique of git-gui's
> translation, though.=20
[For the record, I don't like that translation either.]

>> I'd go for "Zweig". It's even on the wikipedia page and it perfectly=
 =20
>> represents the concept.
>=20
> My main reason for not translating this one is that we have a command
> called "branch" and since people need to learn what it means anyway,
> and we're certainly not going to change the command names in differen=
t
> languages, translating the term in other uses just means that German
> users have to remember two different words for the same thing. Simila=
r
> reasoning applies to some other terms.

I really have to oppose this reasoning. Are you seriously suggesting we
should not translate the following words as a matter of principle?

add
am (OK, I'm kidding here)
annotate
apply
archive
bisect
blame
branch
bundle
cat (...)
check
checkout
cherry(-pick)
clean
clone
commit
config
count
daemon
describe
diff
fast
fetch
filter
for
format
get
grep
gui
hash
help
index
init
log
lost
mailinfo
mailsplit
merge
mergetool
name
notes
pack
parse
patch
peek
prune
pull
push
read
rebase
receive
reflog
relink
remote
repack
replace
repo
request
reset
revert
rev
send
shell
shortlog
show
stage
stash
status
submodule
symbolic
tag
tar
unpack
update
upload
var
verify
web
write

We simply need a principle we can follow, which produces readable text,
and which helps those in need of a translation. Those with a reasonable
passive understanding of English don't need a translation at all. Some
suggestions to follow:

- Identify term categories which are already in use in the English
version, such as "combinatorial graphs".

- Within each category, look for established translations in that field=
;
in any case, keep the categorical associations for the translation.

- Translate concepts, not words. If there are several choices, favour
the one which is linguistically close to the English Git glossary.
There's a good chance this will happen quite often with German.

>>>  tag                   Tag
>>
>> Der heutige Tag oder der morgige Tag? What's the problem with =20
>> "Markierung"? This is exactky the git concept which is meant.
>=20
> I believe that the English "tag" is a much better metaphor than the
> German "Markierung". One use of "tag" refers to a small label that is
> attached to, for example, baggage. This is exactly the concept we hav=
e
> in git. "Markierung" doesn't come close at all to describing the same
> concept. Conflicts markers are "Markierungen"; tags are not.

That's exactly why I suggested "Marke", see my earlier reply also for
the other terms. It conveys the same multiple metaphorical associations=
=2E

You know, there's a reason why translating is a profession. You need to
be proficient in both languages, as well as creative. In fact, I don't
think the majority of people are proficient enough for that even in
their native language (as a translation target), but every native
speaker thinks he or she is, of course. (This is a general remark not
aimed at anyone specifically.)

Michael
