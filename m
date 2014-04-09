From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] git-multimail: update to version 1.0.0
Date: Wed, 09 Apr 2014 18:01:12 +0200
Message-ID: <53456EC8.7090109@alum.mit.edu>
References: <1396884040-26014-1-git-send-email-mhagger@alum.mit.edu> <xmqqd2gtm0id.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 18:01:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXuwT-0006bg-L1
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 18:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933895AbaDIQBb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2014 12:01:31 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57190 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933983AbaDIQBR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2014 12:01:17 -0400
X-AuditID: 12074413-f79076d000002d17-aa-53456ecbdf9b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 58.C4.11543.BCE65435; Wed,  9 Apr 2014 12:01:16 -0400 (EDT)
Received: from [192.168.69.148] (p5B156BA9.dip0.t-ipconnect.de [91.21.107.169])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s39G1DZ5029581
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 9 Apr 2014 12:01:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <xmqqd2gtm0id.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsUixO6iqHsmzzXY4P0xJouuK91MFg29V5gd
	mDwuXlL2+LxJLoApitsmKbGkLDgzPU/fLoE7o/9eO2vBK9GKXRuXMjcwnhPsYuTkkBAwkVjX
	M58dwhaTuHBvPVsXIxeHkMBlRollDX9Yuhg5gJxzTBIn/EBqeAW0JdqeT2YHCbMIqEq0rbMD
	CbMJ6Eos6mlmAgmLCgRJ/DmrCFEtKHFy5hMWEFtEQE1iYtshsIHMAuIS/f/AwsIC1hLzPu5l
	g9hTLLG+yx4kzAkUPnJxI1i1BFB1T2MQRKO6xPp5QiAVzALyEs1bZzNPYBSchWTVLISqWUiq
	FjAyr2KUS8wpzdXNTczMKU5N1i1OTszLSy3SNdfLzSzRS00p3cQICVfhHYy7TsodYhTgYFTi
	4T1h5hIsxJpYVlyZe4hRkoNJSZQ3K9s1WIgvKT+lMiOxOCO+qDQntfgQowQHs5II7/kcoBxv
	SmJlVWpRPkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJ3cy5Qo2BRanpqRVpmTglC
	momDE2Q4l5RIcWpeSmpRYmlJRjwoYuOLgTELkuIB2QvSzltckJgLFIVoPcWoy7Fh25pGJiGW
	vPy8VClx3myQIgGQoozSPLgVsOT0ilEc6GNh3kcgVTzAxAY36RXQEiagJal2LiBLShIRUlIN
	jB2X5m+9ePU9b0P9gfc2v/I92G1VtydPCGKvbNiWtS3tgX6vqNoU9lTbyKwLwb9mKT24NHXK
	/6sGEjlTHb2UTGdzl9+aKv9d6zqndI9ahJ5mrSIHV9197a2r2SZvqVQQbvVa0tY3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245977>

On 04/07/2014 08:56 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
>> ...
>> Contributions-by: Rapha=C3=ABl Hertzog <hertzog@debian.org>
>> Contributions-by: Eric Berberich <eric.berberich@gmail.com>
>> Contributions-by: Michiel Holtkamp <git@elfstone.nl>
>> Contributions-by: Malte Swart <mswart@devtation.de>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>> Junio, how would you like other people's contributions to be recorde=
d
>> within the Git project?  I have listed them above as
>> "Contributions-by".  All of these people have signed off on their
>> contributions (recorded in my GitHub repo).  So should I also/instea=
d
>> add "Signed-off-by" for those people?
>=20
> Either is fine, as long as somewhere in that directory:
>=20
>  - we make it clear that the copy we have in contrib/ is merely for
>    "batteries included" convenience;
>=20
>  - we refer to the canonical source that is your repository;
>=20
>  - we tell readers to go there to get the authoritative and up to
>    date copy, as what we have in contrib/ is possibly stale.

This information is already present in README.Git, though it doesn't sa=
y
explicitly that the copy within the Git source tree might be stale.  I
can add that if you like.

> In the longer term, I have a feeling that we may be better off to
> make the "git core" tree not be the "batteris included" convenience
> tree, though.  In the early days, Linus's rationale for including
> "gitk" held true: having tools that are not quite core is a good way
> to get people (especially those without C background) involved in
> the still-small project in its infancy to help nurture the developer
> community.  The same reasoning stood behind the merging of "gitweb".
>=20
> We already are beyond that stage, and good tools like iMerge and
> multimail that can stand on its own may be better off flourishing
> outside "git core" tree, still within the same developer community.

I was going by what you said when multimail was originally added to you=
r
repo [1]:

> The second category will be in a separate hierarchy (perhaps
> addons/, hooks/, ..., but I am fine if we decide to keep them in
> contrib/addons, contrib/hooks, etc.).
> [...]
> The multimail tool can be in the second category.  It helps use of
> Git more than it is helped by using Git.

Tell me if/when you want to transition to omitting git-multimail (and
presumably post-receive-email and maybe others) from the Git source
tree.  I suppose in that case we would replace the scripts with pointer=
s
to where they can be obtained.

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/226644

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
