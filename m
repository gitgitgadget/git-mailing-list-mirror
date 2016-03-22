From: Marcus T <maddimax@googlemail.com>
Subject: Re: git fails updating submodule only if --quiet is specified
Date: Tue, 22 Mar 2016 16:51:47 +0100
Message-ID: <219B1DC5-8379-4FD5-8739-D99890362769@googlemail.com>
References: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: multipart/signed; boundary="Apple-Mail=_ADA07EE3-D81B-4E25-9712-7AE3C59054C1"; protocol="application/pgp-signature"; micalg=pgp-sha512
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 16:51:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiOb7-0002Mp-IC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 16:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbcCVPvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 11:51:54 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33737 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbcCVPvw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 11:51:52 -0400
Received: by mail-qg0-f44.google.com with SMTP id 51so16220558qgy.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:message-id:references:to;
        bh=MHxChYdZcl1UGjPh0tWQisnk6FRqJ5YuKi8vi3bGLc4=;
        b=XmfNPdZDB/PteJqDV/g0r25HincLWbxLkN9j0ibSLwtlQF6rhgjSXMpskIBT1dzuRc
         C0xao8e26sVL0bT1kVXPh/XAsYEbeqB3HFTZ43PrmQWcUhpRSQfzqbJT43+ezjGV6fh5
         RMBBC7x1slGvlm8vY5VoKiU+SJNvNo8EpmyyLJ3EnMgS6SzB5vDfV1yt0DPZrmtnQmAB
         dW515fHjKkDZxk74Bj4KyK2ajrd3721pBboxrAYc511TwxuHVUzpvMD/r9B3dU41NXAd
         LoaS8EnhMRrBajyGHrLseIzozoo/ToiZjYsDaJbvxBNC7VONrbYVNOHSTkq4V09u3o+g
         Lczg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date
         :message-id:references:to;
        bh=MHxChYdZcl1UGjPh0tWQisnk6FRqJ5YuKi8vi3bGLc4=;
        b=cxqX9LNypLw4688snO7v6iN0gkxZppDqlAwd6aqgp7VVz0A16jyG1P3WO0mrpXIRpJ
         ZfAjPUTVzjfjBw1wmexcYRi1fPUo62r9JUkLETpKVFIAxFbzBmzexKWgDEn53vPioGMk
         9tA3jpydNOjCUtN/T1gW7vRhUw71lxGQN+EgkF70BGx0XQ5F+D/cIPhGlO1qLk2ft0rk
         QlOrgjxIJT+7mZm1/4iJLmdNddlHsF2SS6o2SzDKRCIMXrL79b7Ey02U9kcLbDsDdkGk
         FH9al6gqTipoPGLqFMLM95VuJGrZfbhUVGDmxtxrB454LdcNTzPLHEulXkLsOvqaaxDP
         uRaw==
X-Gm-Message-State: AD7BkJKxE4WznrYevJ+3xI0+/1A+IAZyZo+LNBTdCZ75qQxBkuc951mbLpIOSra8lV5e9w==
X-Received: by 10.140.241.74 with SMTP id m71mr51652050qhc.36.1458661911731;
        Tue, 22 Mar 2016 08:51:51 -0700 (PDT)
Received: from [10.15.0.148] (82-198-216-115.briteline.de. [82.198.216.115])
        by smtp.googlemail.com with ESMTPSA id p129sm14738658qhp.44.2016.03.22.08.51.50
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 08:51:50 -0700 (PDT)
X-Pgp-Agent: GPGMail 2.5.2
In-Reply-To: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289510>


--Apple-Mail=_ADA07EE3-D81B-4E25-9712-7AE3C59054C1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I did a bunch more investigation:

My original problem was that it would work on a terminal, but not when =
running under jenkins.

Turns out the =E2=80=9C-v=E2=80=9D in the "index-pack=E2=80=9D step is =
whats leading to the error.

I can reproduce the issue with the command "git submodule update --init =
--recursive > out.txt 2>&1"

It seems that the =E2=80=9C-v=E2=80=9D is dropped automatically by git =
if its not connected to a terminal.

This is only an issue for =E2=80=9Cgit://=E2=80=9C urls. ssh and https =
seem to not be affected.



> On 22 Mar 2016, at 16:02, Marcus T <maddimax@googlemail.com> wrote:
>=20
> Hello,
>=20
> I=E2=80=99m running into a nasty issue where =E2=80=9Cgit submodule =
update =E2=80=94init=E2=80=9D fails if I add =E2=80=9C=E2=80=94quiet=E2=80=
=9D
>=20
> Following you can find the output with GIT_TRACE=3D1:
>=20
> WITHOUT --quiet:
>=20
> GIT_TRACE=3D1 git submodule update --init --recursive
> 15:51:48.248945 git.c:561               trace: exec: 'git-submodule' =
'update' '--init' '--recursive'
> 15:51:48.249023 run-command.c:334       trace: run_command: =
'git-submodule' 'update' '--init' '--recursive'
> 15:51:48.256626 git.c:344               trace: built-in: git =
'rev-parse' '--git-dir'
> 15:51:48.258494 git.c:344               trace: built-in: git =
'rev-parse' '--git-path' 'objects'
> 15:51:48.260406 git.c:344               trace: built-in: git =
'rev-parse' '-q' '--git-dir'
> 15:51:48.262940 git.c:344               trace: built-in: git =
'rev-parse' '--show-prefix'
> 15:51:48.264156 git.c:344               trace: built-in: git =
'rev-parse' '--show-toplevel'
> 15:51:48.266637 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
> 15:51:48.268074 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
> 15:51:48.269913 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
> 15:51:48.271168 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.update'
> 15:51:48.272422 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'dl'
> 15:51:48.274179 git.c:344               trace: built-in: git 'config' =
'submodule.dl.url'
> 15:51:48.275445 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.dl.update'
> 15:51:48.276779 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
> 15:51:48.278362 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
> 15:51:48.279819 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
> 15:51:48.281192 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.branch'
> 15:51:48.282473 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.branch'
> 15:51:48.283788 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.update'
> 15:51:48.285269 git.c:344               trace: built-in: git =
'submodule--helper' 'clone' '--prefix' '' '--path' 'buildroot' '--name' =
'buildroot' '--url' 'git://git.busybox.net/buildroot' '' ''
> 15:51:48.285337 run-command.c:334       trace: run_command: 'clone' =
'--no-checkout' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
> 15:51:48.285687 exec_cmd.c:120          trace: exec: 'git' 'clone' =
'--no-checkout' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
> 15:51:48.286453 git.c:344               trace: built-in: git 'clone' =
'--no-checkout' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
> Cloning into 'buildroot'...
> 15:51:49.177856 run-command.c:334       trace: run_command: =
'index-pack' '--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on =
bre-build-linux' '--check-self-contained-and-connected'
> 15:51:49.178244 exec_cmd.c:120          trace: exec: 'git' =
'index-pack' '--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on =
bre-build-linux' '--check-self-contained-and-connected'
> 15:51:49.179806 git.c:344               trace: built-in: git =
'index-pack' '--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on =
bre-build-linux' '--check-self-contained-and-connected'
> remote: Counting objects: 200277, done.
> remote: Compressing objects: 100% (62420/62420), done.
> ...
>=20
> WITH --quite:
>=20
> GIT_TRACE=3D1 git submodule update --init --recursive --quiet
> 15:52:26.900568 git.c:561               trace: exec: 'git-submodule' =
'update' '--init' '--recursive' '--quiet'
> 15:52:26.900652 run-command.c:334       trace: run_command: =
'git-submodule' 'update' '--init' '--recursive' '--quiet'
> 15:52:26.907761 git.c:344               trace: built-in: git =
'rev-parse' '--git-dir'
> 15:52:26.909877 git.c:344               trace: built-in: git =
'rev-parse' '--git-path' 'objects'
> 15:52:26.911766 git.c:344               trace: built-in: git =
'rev-parse' '-q' '--git-dir'
> 15:52:26.914279 git.c:344               trace: built-in: git =
'rev-parse' '--show-prefix'
> 15:52:26.915488 git.c:344               trace: built-in: git =
'rev-parse' '--show-toplevel'
> 15:52:26.917983 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
> 15:52:26.919504 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
> 15:52:26.921244 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
> 15:52:26.922619 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.update'
> 15:52:26.923888 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'dl'
> 15:52:26.925650 git.c:344               trace: built-in: git 'config' =
'submodule.dl.url'
> 15:52:26.926892 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.dl.update'
> 15:52:26.928230 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
> 15:52:26.929709 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
> 15:52:26.931220 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
> 15:52:26.932597 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.branch'
> 15:52:26.933867 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.branch'
> 15:52:26.935170 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.update'
> 15:52:26.936660 git.c:344               trace: built-in: git =
'submodule--helper' 'clone' '--quiet' '--prefix' '' '--path' 'buildroot' =
'--name' 'buildroot' '--url' 'git://git.busybox.net/buildroot' '' ''
> 15:52:26.936732 run-command.c:334       trace: run_command: 'clone' =
'--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
> 15:52:26.936965 exec_cmd.c:120          trace: exec: 'git' 'clone' =
'--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
> 15:52:26.937803 git.c:344               trace: built-in: git 'clone' =
'--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
> 15:52:27.958503 run-command.c:334       trace: run_command: =
'index-pack' '--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on =
bre-build-linux' '--check-self-contained-and-connected'
> 15:52:27.958870 exec_cmd.c:120          trace: exec: 'git' =
'index-pack' '--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on =
bre-build-linux' '--check-self-contained-and-connected'
> 15:52:27.960447 git.c:344               trace: built-in: git =
'index-pack' '--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on =
bre-build-linux' '--check-self-contained-and-connected'
> fatal: The remote end hung up unexpectedly
> fatal: early EOF
> fatal: index-pack failed
> fatal: clone of 'git://git.busybox.net/buildroot' into submodule path =
'buildroot' failed
>=20
> ---------
> git --version
> git version 2.7.4
>=20
> Any help in tracking down the reason for this would be greatly =
appreciated.
>=20
> Thanks,
> Marcus
>=20


--Apple-Mail=_ADA07EE3-D81B-4E25-9712-7AE3C59054C1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJW8WoUAAoJEK5MaPYXd0Y0ONwH/3pmub6VAeGRZ2bRGa2AvF6d
Eg9qVEmdfsgGUWrI5mBo310BnM8HJYQYjkfyN+dAPtKs8BYbih09G9BDvHJafbfT
AMHMeqaNL/CIJawTDKv6rG4Y8g8niLr1n6v98DClCAcMZf2heDNOeo8tEs0U8N7y
wu5o7JFs4UnJcHkWc8kaHOYB+ia1GdrPfXP7BZ+YMerGGoGPqHv50qaaFfMG7Sl0
DLhBCrB652LifX/6azAsF2LJxMuWpZF69ciA2nfaBYEPkzZWNtqp0cURB5wWl6e2
l/c8yDRwmECf8E2yAMgtltP153YLQ8omTBb3e3ZN1GmZtzRAdAjBxL2Q+mGHhLM=
=LIIJ
-----END PGP SIGNATURE-----

--Apple-Mail=_ADA07EE3-D81B-4E25-9712-7AE3C59054C1--
