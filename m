From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Helpful Script for Maintaining Integration Branches
Date: Wed, 9 Jun 2010 14:40:38 -0500
Message-ID: <201006091440.43409.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3524094.Lnpm8pxGa0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 22:23:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMRnr-0004Zl-3i
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 22:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab0FIUXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 16:23:06 -0400
Received: from rei.iguanasuicide.net ([209.20.91.252]:60600 "EHLO
	rei.iguanasuicide.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790Ab0FIUXE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 16:23:04 -0400
X-Greylist: delayed 2537 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jun 2010 16:23:04 EDT
Received: from [99.49.187.102] (helo=dellbuntu.localnet)
	by rei.iguanasuicide.net with esmtpsa (TLS1.0:DHE_DSS_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1OMR8m-0003mH-Fo
	for git@vger.kernel.org; Wed, 09 Jun 2010 19:40:45 +0000
User-Agent: KMail/1.13.3 (Linux/2.6.32-bpo.3-amd64; KDE/4.4.3; x86_64; ; )
X-Face: ^vamSukCH~ctN{VF@Q-&WG{+0';38cJ]\/:{x0w-b'+GPuWvNg%NAa2SuBw=&"obQ@q;2h
	6&5@)xd86p;wyaJ%f7&z_BW}Dkm.L$-#h%DUdk7thS-HC_A^Jp|#Tq4R/^q/-]wRVU^T?j
	g@-H./`NrG[
X-Eric-Conspiracy: There is no conspiracy.
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAMFBMVEUSKVkSKVkSKVkSKVkrXb
	grXbgrXbgrXbhEddVEddXI2uzI2uxEddUrXbgSKVlvm9zseJLgAAAAC3RSTlMZS96SGZLeS95LGbtQ3
	6QAAAI0SURBVDjLbZRNbhQxEIU9sMsqCWukMNmjITkDN+AacCBW2SH1FXqk3iJRTknZsOlyn8DhAHZj
	3iv3ZCSgNBqN/fxVvfLPhGH4+NlMROpLyPdPwxCGbzkbIsoWs+HzdQgPb83yc7JzcOHPixC+mCWbRVs
	pY2lNMMz2FMIOurZpREz4LtPU6qOly/A6G9aW0krjLAJcSgcICycxRCoXWmurHcKrvHC+eDauR7oWn2
	9cQEwExrEXa7/tJlyn9gsC/DhBdWpreheun7X1KJxybF0zhLwsnsyJ/rU4AbtYPXViyxQNQlrXWTCsJ
	6GudSNWT0NXblkVuwjBlkWVJrmaAMMJqarlLCgIcWLGGZ3yj+NRXoiqYMZRfnQBQ7VIIiKVYmUnJiyr
	bjfrItJGT9eLq7hgVhV2RTa7R5XNLttjBtQ4ksKF6ESMFERfOpfZiTzPxYnCNMw1x62G9Y2gUFkeJXo
	NIyLKGpXNrHHeCJMyuaujMNdktgkR4+au3MLaBd5cCEc02GrFVlZexk7MzCCV2wzf6OJEzN41d5VtqG
	01oIhvnx8kkGi5H22edTzHVDci52R6OkAyEnPOnUAfY6NR3iGYSu4qJfPTbS5oo9tOUMHbdKE23oTci
	3cBil8dtoGZk0BF2Yq35wSeWvYeT2EE/KnhRzorfMMgDmH3vr9szxa5TVz2dBl2dyyRfV6k76A93l6G
	8GbPEj2T+kfi/kPAP8D93f6vuL0H8BCu7v+Jq3ARhvDfGP4AtLxO3F/uHbUAAAAASUVORK5CYII=
X-Spam-Score: -3.6 (---)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148810>

--nextPart3524094.Lnpm8pxGa0
Content-Type: multipart/mixed;
  boundary="Boundary-01=_24+DM3OJene5Cjb"
Content-Transfer-Encoding: 7bit


--Boundary-01=_24+DM3OJene5Cjb
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Attached is a script I wrote today to help manage integration branches.  I'=
d=20
like to share this with anyone that might find it useful, and possibly get =
it=20
included in mainline Git.

I'm calling it git-integrate-branch.sh, but I'm open to a rename, as well a=
s=20
any review you might want to provide.

The use case is when you have a branch for a particular bug fix, but master=
=20
has had other commits that cause a conflict.  In addition, some users or=20
features may have branched from master, so you'd like to maintain as=20
integration branch so they can merge in "just" the bug fix without other=20
changes to master.

Your tree:

*-*-*-...-*-* (master)
 \
  * (bug-3010681)

You run this script and it see if the bug fix branch has any merge conflict=
=20
with master.  If not, you can leave your tree alone.  If so, it tells you t=
he=20
exact commit that causes a conflict and prompts you to update your bug fix=
=20
branch.  Once you resolve the merge manually you get:

*-*-*-...-*-...-*-* (master)
 \         \
  *---------* (bug-3010681)

At this point, you repeat the process.  Either the bug fix branch can be=20
cleanly merged with master, or it needs to be further updated due to other=
=20
conflicts.

If someone is maintaining an installation that was snapshotted from master,=
=20
their tree looks like:

*-*-...-* (production) -*-...-*-* (master)
 \                       \
  *-----------------------* (bug-301681)

They can run something like this to merge in just the bug fix without the=20
other changes from master:

git rev-list bug-3010681 '^production' |
while read rev; do
	merge_bases=3D$(git merge-base production "$rev")
	if [ $(git rev-parse production) !=3D "$merge_bases" ]; then
		printf >&2 'Merge %s into %s.' "$rev" 'production'
		break
	fi
done

Of course, this assumed the bug fix has been backported or was originally=20
written against the buggy commit, instead of being based off of master.
=2D-=20
Boyd Stephen Smith Jr.           	 ,=3D ,-_-. =3D.
bss@iguanasuicide.net            	((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy 	 `-'(. .)`-'
http://iguanasuicide.net/        	     \_/

PS Last time I wrote to this list, CC was the norm.  I am not subscribed, s=
o=20
please CC me even if it is no longer the norm.

--Boundary-01=_24+DM3OJene5Cjb
Content-Type: application/x-shellscript;
  name="git-integrate-branch.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="git-integrate-branch.sh"

#!/bin/sh

master="${2:-HEAD}"
branch="$1"

dirty=$(git status --porcelain | wc -c)
if [ $? -ne 0 ] || [ "$dirty" -ne 0 ]; then
	printf >&2 'Sorry, this command will only work with a clean tree.\n'
	exit 255;
fi

git checkout "$master" &&
git merge --no-ff "$branch"
if [ $? -eq 0 ]; then
	git reset --hard 'HEAD^'
	printf >&2 '%s is already ready to be merged into %s.\n' "$branch" "$master"
	exit 0;
fi

{
	git reset --hard &&
	git bisect start HEAD $(git merge-base HEAD "$branch") &&
	git bisect run /bin/sh -c ' {
		git merge --no-ff "$1"
		if [ $? -eq 0 ]; then
			git reset --hard "HEAD^" &&
			exit 0
		else
			git reset --hard &&
			exit 1
		fi
	} < /dev/null > /dev/null 2>&1' ignored "$branch" &&
	update=$(git rev-parse refs/bisect/bad) &&
	git bisect reset
} &&
printf >&2 \
'You must manually update
%s
by resolving the merge conflicts with
%s
by executing:
git checkout %s && git merge %s\n' "$branch" "$update" "$branch" "$update"&&

exit 1

--Boundary-01=_24+DM3OJene5Cjb--

--nextPart3524094.Lnpm8pxGa0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwP7jYACgkQdNbfk+86fC325QCgiM/lLQ1gdDrlHLO3QA7PAscd
uW4An3MWXjMfyE9Ux9ERGQJib3pFTuIK
=A0o1
-----END PGP SIGNATURE-----

--nextPart3524094.Lnpm8pxGa0--
