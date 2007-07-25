From: Marius Storm-Olsen <marius@trolltech.com>
Subject: Re: [PATCH 3/3] Teach "git branch" about --new-workdir
Date: Wed, 25 Jul 2007 08:47:57 +0200
Message-ID: <46A6F21D.2010306@trolltech.com>
References: <46A5B5F5.6000202@trolltech.com> <Pine.LNX.4.64.0707241002410.14781@racer.site> <7vd4yigmla.fsf@assigned-by-dhcp.cox.net> <46A5DF1F.2030307@trolltech.com> <Pine.LNX.4.64.0707241337470.14781@racer.site> <46A5FDF0.3060801@trolltech.com> <Pine.LNX.4.64.0707241431540.14781@racer.site> <46A63EAA.6080203@trolltech.com> <Pine.LNX.4.64.0707241923450.14781@racer.site> <46A654A6.5070802@trolltech.com> <20070724231529.GA29156@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig876A9D5B4F5A34A19C54E202"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Julian Phillips <julian@quantumfyre.co.uk>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:47:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDaee-0004kr-35
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 08:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760133AbXGYGrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 02:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758761AbXGYGrY
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 02:47:24 -0400
Received: from esparsett.troll.no ([62.70.27.18]:35678 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162AbXGYGrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 02:47:22 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 26E95742A2; Wed, 25 Jul 2007 08:47:21 +0200 (CEST)
Received: from [10.3.4.215] (error.troll.no [10.3.4.215])
	by esparsett.troll.no (Postfix) with ESMTP
	id 0EA51741AB; Wed, 25 Jul 2007 08:47:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070716 Thunderbird/2.0.0.5 Mnenhy/0.7.5.666
In-Reply-To: <20070724231529.GA29156@steel.home>
X-Enigmail-Version: 0.95.2
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAFVBMVEXU1NTAwMABAQGsrKyE
 hIQwMDAEBAS8hGUfAAACQUlEQVQ4jV2TS47cMAxEKSDZW1CfwMB4PYLkrKchsveJRR2gEen+R0hR
 9vziBmahhyqSRQ4NfF1FmIv3dH4usNAGoFprBVguQJmZ1nX0XiHgEukTCK3TairiZeXcVGzmZIoU
 3738pehdVbiU9KFgMQWeZ1fpHZDfRS4rPb3eQVaZChGx4ikt5GDkAZQ2KKohzjklno4+iJpVhxka
 ZjSpasJ4gdGaEQMWTMjRa5uTqza0XDJjzhIdzGTMrqoopimoIPCKZtVOq265MAXpMLXycmVl2Y8C
 oE1FkT/faKauOjYoHJyOxHfvixjowvI0xZJsKykubgLYzuJMdBO+L86TjxfQ9hz9jpSudbnXXzRm
 tor5i3MUONpOfARAhlWbzWF7OhP2eSeEW9HUBNiHOxUM8HLWHhUAj3NZNsdqRZpNA+DJ+XlX+Qc9
 Z4ZjHX8LRUzgTBBef84NQoCMOcS0+BMsj3klbTzRri03ugXr9em1GfgzDAyEn4J3fvFI5YwdTrYu
 1ntAY1h5ysM2OMGm+cBOocCXHisAHu2PagnLghoG2krz8bzsA4fj7KxCGk+63jt+DDCtYjbFNkHD
 nRwpRqsQYx5WYzsbm/eBfn0I4TbOGvMWqhQAiEDzNs4apumCI0x2OyHtY7uAlZff/sanbH9+AGT1
 KOEmUlJISdYPgEgehw+cTZEf6xeFyoEjCPgv+A62KhW3EOy9PL7WmCBMRWmfYN0OqW9krzl/Ay91
 75HMqfDtP8UFckFUX2rwrm/kTVB2gH+hdu4avZVCuAAAAABJRU5ErkJggg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53670>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig876A9D5B4F5A34A19C54E202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Alex Riesen said the following on 25.07.2007 01:15:
> Marius Storm-Olsen, Tue, Jul 24, 2007 21:36:06 +0200:
>> IMO Windows user expect files to be DOS style, since all other files
>> are.  Yes, most newer tools 'handle' Unix style files, but creating ne=
w
>> ones will mostly be DOS style. Some will actually wreak havoc on your
>> files, and start adding DOS line endings in the middle of your Unix li=
ne
>> ending file. I've seen it happen. So, dealing with Unix style text fil=
es
>> on Windows can be a problem for some people.
>=20
> I have to stay with Windows, but I'd absolute hate having their stupid
> line-ending by default. As will my project supervisor, and he gets
> changes from something like 300 developers. You will definitely get
> their votes against changing the default

Ok, so maybe not changing the default.
Though it's weird behavior for _most_ Windows developers out there, I=20
agree that the current Windows Git population would mostly prefer the=20
Unix line endings. And I can see how someone who's working on Windows=20
and handling a lot of patches from other developers of multiple OSs=20
also wanting the non-platform-standard Unix line-endings.
I still would argue that it's not the norm. Currently yes, in the=20
foreseeable future, I doubt it.


>>> Git is really slowed down tremendously just by the fact that it runs =
on=20
>>> Windows.  You should not add to that.
>> The auto crlf conversion is not the slow down here, and the time spent=

>> there is negligible. I use autocrlf on all my repos on Windows, and
>> don't notice it. Filestat'ing on the other hand.. :-)
>=20
> Of course you wont notice it: you're already on Windows.

Come on, when did a search and replace in a normal size source file=20
take any time? It's really not an argument for not doing CRLF=20
conversion on a platform that creates CRLF files by default!

If you want files to be stored in the repo with Unix line-endings,=20
which I expect most people would want, to share it with other=20
non-Windows developers, you _have_ to do it. (No, not the MSys/Cygwin=20
users)


>>> IMHO in most cases -- even on Windows -- you do not want to set autoc=
rlf=20
>>> at all.  Because you do not need to store the file different from the=
=20
>>> version you have in the working tree.
>> Not true. I believe, especially at the moment, most Git users on Windo=
ws
>> are mostly developing code in a cross-platform manner, and therefore
>> care about this problem.
>=20
> Yes. They solve it by working fulltime in \n-lineending. Avoiding that
> stupid Visual Studio and Notepad helps too.

Huh? You just removed more than 3 _million_[1] potential users.. (Some=20
say 8 million [2]) Is that a good argument? Why should developers on=20
Windows avoid using Windows tools? Because they're 'idiots'? (ref=20
further down in your reply)

Anyways, even if a tool on Windows _handles_ LF line-endings perfectly=20
fine, most of these tools still create CR/LF files when you create a=20
new text file.
(No, again not the MSys or LF-configured Cygwin vim/emacs/<insert your=20
favorite unix editor here>. But the native editors which handles both=20
formats. There's plenty of those too.)


>>> The only situation where I think it makes sense, is when you have bot=
h=20
>>> Windows and Unix developers, _and_ your Windows tools sometimes produ=
ce=20
>>> CR/LF stupidly.  But then I'd set it to "input".
>> That's ok _now_, because most of the Git user group is experienced
>> developer that understand the problem. I'm trying to see past that
>> state, and prepare Git for more 'common' usage on Windows. They'd expe=
ct
>> text files on Windows to be handled correctly, without any fuzz.
>=20
> Just make the windows installer to setup templates for CR/LF depending
> on checkbox "[ ] I am Windows idiot, standard issue".

Mmm, ok. If I'm an idiot just for using Windows, I guess the battle is=20
lost already.


>> No tweaking of config options to make it work on Windows. No problems
>> with sharing repositories with Unix developers. Just work. That's not
>> the current state. But it could be.
>=20
> It is for me. It will not be that with your suggested default.

Then I wouldn't put you in the normal Windows developer category, but=20
rather the one which is dependent on MSys or Cygwin, and live in=20
bash/zsh on Windows. I would argue that most of those 3/8 million VS=20
users are not in the same category as you.

But sure, I don't mind having to set core.autocrlf=3Dtrue when I=20
configure Git, but then I would like that mode to work without the=20
extra hassle. (Most people don't want to change already incorporated=20
options, which is fully understandable)


>> Ok, I come from the Perforce world, so here how it works there:
>> 1) Files are stored with Unix line endings in the repository.
>> 2) Conversion is done on Windows (and older Macs) upon checkout, if th=
e
>> file is a text file.
>> 3) It has binary file detection when you add it to the depot, so if yo=
u
>> and to add a DOS line ending file to the repo, you have to mark it as =
a
>> binary file manually
>=20
> You always setup the lineending conversion in perforce. For each and
> every client. There is no default. I just don't see what to learn from
> them (if there ever was something to learn from).

No you don't. You _can_, but the default when you create a 'client=20
spec' is the platform specific line endings. Only 'Unix' users working=20
on Windows really take the trouble of changing the line endings to=20
they work with their MSys or Cygwin enviroments.


>> ... And Git would probably be adapted on
>> Windows more quickly, which this is all about. :-) IMHO.
>=20
> It is hardly worth it. Git already has to put up with ugly workarounds
> just because of the stupidities coming from that windows. It has had
> seldom any benefit from supporting this !@#$ing awkward platform.

Well, I guess with this opinion there really no point in me trying to=20
prove a point. If all Windows users are 'idiots' on a '!@#$ing=20
awkward' platform, I'm probably just an 'idiot' trying to help out.

I hope it's not the general opinion of the Git team that Windows users=20
should just bugger off..

Now, personally I don't have a problem with all this line ending=20
stuff. I work on Windows and Unix on a daily basis, addicted to MSys=20
and Cygwin for performing my daily tasks, and use tools which handles=20
LF and CR/LF interchangeably without any problems. So, the current=20
state of Git works for me. I'm just trying to help figuring out what=20
we can do to make the tool even more platform agnostic, and work as=20
expected.


[1] http://msdn.microsoft.com/vsip
[2] http://www.regdeveloper.co.uk/2007/06/09/vs_shell_eclipse/

--=20
=2Emarius


--------------enig876A9D5B4F5A34A19C54E202
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)

iD8DBQFGpvIeKzzXl/njVP8RArcbAJ0fCtno+jzWPR0XqJqVdNmE1jyjTQCeMbvv
r1+VdZp93gFAJjil+kOE61c=
=Tsbs
-----END PGP SIGNATURE-----

--------------enig876A9D5B4F5A34A19C54E202--
