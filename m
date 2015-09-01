From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Fwd: Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: Tue, 01 Sep 2015 09:14:06 +0200
Message-ID: <55E5503E.2090101@web.de>
References: <55E52BA7.6020303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 09:14:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWfmP-0004is-0U
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 09:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754635AbbIAHOt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2015 03:14:49 -0400
Received: from mout.web.de ([212.227.17.11]:58073 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753392AbbIAHOs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 03:14:48 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MX0Q4-1Z9WiW3Tnw-00VxxL; Tue, 01 Sep 2015 09:14:44
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <55E52BA7.6020303@web.de>
X-Forwarded-Message-Id: <55E52BA7.6020303@web.de>
X-Provags-ID: V03:K0:4GnXGV7h7Pk/cKoQxt3C6b3k7/Vb2YGIVXYJ+9CaK/tsnbmW9Mz
 qnD8tF93dF1619VuTSGP2MPaJYkFCJYxXud3KoNAB+NswU5r78FvgIYyK97DI+2sd1LL+x+
 MV0KOPWn2wwyvzWd2c7D9CkhADsWXXH+nssiDSOqVC/S915DhoBzcLpokakNT4fa3KiSzrr
 3aTvloPRwPGQh0r0gNuxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nlbRBtmA1Es=:XoKhX1662y3YOti8TYCWDe
 JLopktUGkPc9GcSmxeR47p8Me3YEfMXaioM8crYUkl3S52Nlq8ENmGZ+hgmRDhJ8TV44LBGgL
 kh8SYmOVF8zJ7UE7sG/kzoQKwlt0Yrob5T2+WJLuelxKYLgVRGpC5+gCpxc92vvmWEuoxpPSi
 H1kDuZy96eYkeW9FWJMeV6OElk6D6CPu5qT7OztlEWx8LDCMGIxyVLCBFcKX3C1tWI6UqMJp5
 b2l1PUiawAsfyxMe40EOx1kHGQxlLcnI2YMRhYgslt0e4ka+8kO3n/cMOGxxzChc7CoIVUWEp
 7FXSHNdquvSbiZYpnFSMCSGu7DQa7GbwXc1hajEVzvYLoNldUDsJAYKxDOuWCB/r+FfBIDenV
 kgHRcFdWW5oQkJt7ol9e3kVxrjjr8vGhNeaP81iNI6bLLW/sG0XZ4ADJK8c2+ZDJ9DU5PJEXX
 Yr4n747pI09fFSfrPrhDRJ38NlZh17fplKsC0CAN+3LPJEzL7TtGzAKtan79qX59QNLe/ucrB
 3x6UJ+EyhzQLB6gPYDFtnaKfa+Io2g9HCUxPzwLXVYbZ+9P1K4ulxcwLH+m1mr8OjAO5TIUgc
 EY0KL3QI/d/W+8sqhjeVs2os+d884MQOvOcSYH3KPnKiBWS3ec8MKc5usZHHwB76yXEMLzmPC
 ZZLPTq6pW1QL1AT8rwjblWXEsQMT3uSKGKGdS9ILYjJAez+oXQAwUlvfs2kQ+yvS33dN/fAqV
 GAwo9Pqm+eqAo92JmMQaXMMZW3SWMGqJYAnGUA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276970>

Sorry if this is possible re-sending


-------- Forwarded Message --------
Subject: 	Re: [PATCH v3] git-p4: add "--path-encoding" option
Date: 	Tue, 1 Sep 2015 06:37:59 +0200
=46rom: 	Torsten B=C3=B6gershausen <tboegi@web.de>
To: 	larsxschneider@gmail.com, git@vger.kernel.org
CC: 	luke@diamand.org, gitster@pobox.com



On 01/09/15 00:10, larsxschneider@gmail.com wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>   Documentation/git-p4.txt        |  5 +++++
>   git-p4.py                       |  6 ++++++
>   t/t9821-git-p4-path-encoding.sh | 38 ++++++++++++++++++++++++++++++=
++++++++
>   3 files changed, 49 insertions(+)
>   create mode 100755 t/t9821-git-p4-path-encoding.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index 82aa5d6..14bb79c 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -252,6 +252,11 @@ Git repository:
>   	Use a client spec to find the list of interesting files in p4.
>   	See the "CLIENT SPEC" section below.
>
> +--path-encoding <encoding>::
> +	The encoding to use when reading p4 client paths. With this option
> +	non ASCII paths are properly stored in Git. For example, the encodi=
ng
> +	'cp1252' is often used on Windows systems.
> +
>   -/ <path>::
>   	Exclude selected depot paths when cloning or syncing.
>
> diff --git a/git-p4.py b/git-p4.py
> index 073f87b..2b3bfc4 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -1981,6 +1981,8 @@ class P4Sync(Command, P4UserMap):
>                   optparse.make_option("--silent", dest=3D"silent", a=
ction=3D"store_true"),
>                   optparse.make_option("--detect-labels", dest=3D"det=
ectLabels", action=3D"store_true"),
>                   optparse.make_option("--import-labels", dest=3D"imp=
ortLabels", action=3D"store_true"),
> +                optparse.make_option("--path-encoding", dest=3D"path=
Encoding", type=3D"string",
> +                                     help=3D"Encoding to use for pat=
hs"),
>                   optparse.make_option("--import-local", dest=3D"impo=
rtIntoRemotes", action=3D"store_false",
>                                        help=3D"Import into refs/heads=
/ , not refs/remotes"),
>                   optparse.make_option("--max-changes", dest=3D"maxCh=
anges",
> @@ -2025,6 +2027,7 @@ class P4Sync(Command, P4UserMap):
>           self.clientSpecDirs =3D None
>           self.tempBranches =3D []
>           self.tempBranchLocation =3D "git-p4-tmp"
> +        self.pathEncoding =3D None
>
>           if gitConfig("git-p4.syncFromOrigin") =3D=3D "false":
>               self.syncWithOrigin =3D False
> @@ -2213,6 +2216,9 @@ class P4Sync(Command, P4UserMap):
>               text =3D regexp.sub(r'$\1$', text)
>               contents =3D [ text ]
>
> +        if self.pathEncoding:
> +            relPath =3D relPath.decode(self.pathEncoding).encode('ut=
f8', 'replace')
> +
>           self.gitStream.write("M %s inline %s\n" % (git_mode, relPat=
h))
>
>           # total length...
> diff --git a/t/t9821-git-p4-path-encoding.sh b/t/t9821-git-p4-path-en=
coding.sh
> new file mode 100755
> index 0000000..1626fc5
> --- /dev/null
> +++ b/t/t9821-git-p4-path-encoding.sh
> @@ -0,0 +1,38 @@
> +#!/bin/sh
> +
> +test_description=3D'Clone repositories with non ASCII paths'
> +
> +. ./lib-git-p4.sh
> +
> +UTF8_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"
> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'Create a repo containing iso8859-1 encoded path=
s' '
> +	cd "$cli" &&
> +
> +	ISO8859=3D"$(printf "$UTF8_ESCAPED" | iconv -f utf-8 -t iso8859-1)"=
 &&
> +	>"$ISO8859" &&
> +	p4 add "$ISO8859" &&
> +	p4 submit -d "test commit"
> +'
Sorry for being persistant,
but you can't create files with names that  are ISO-8859-1 encoded unde=
r Mac OS,
we end up like this:

  a-%E4_o-%F6_u-%FC.txt


(And I'm still not convinced, that we need to call iconv each time we e=
xecute
the TC,
for a string that is always the same.
The string can be converted once, and embedded in the TC:
The following should work under Mac OS (but I don't have p4 to test it)

ISO8859_ESCAPED=3D"a-\303\244_o-\303\266_u-\303\274.txt"

UTF8_ESCAPED=3D"\141\055\303\203\302\244\137\157\055\303\203\302\266\13=
7\165\055\303\203\302\274\056\164\170\164"

ISO8859=3D$(printf "$ISO8859_ESCAPED")

> +
> +test_expect_success 'Clone repo containing iso8859-1 encoded paths' =
'
> +	git p4 clone --destination=3D"$git" --path-encoding=3Diso8859-1 //d=
epot &&
> +	test_when_finished cleanup_git &&
> +	(
> +		cd "$git" &&
> +		printf "$UTF8_ESCAPED\n" >expect &&
> +		test_config core.quotepath false &&
> +		git ls-files >actual &&
> +		test_cmp expect actual
> +	)
> +'
>
The ls-files can be written shorter (if we like short code)

+		git -c core.quotepath=3Dfalse ls-files >actual &&
