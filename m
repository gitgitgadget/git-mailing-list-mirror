Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCEC15D5
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 06:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=tboegi@web.de header.b="qkEmCt+V"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B3103
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 23:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1698647793; x=1699252593; i=tboegi@web.de;
	bh=J/OeCismxVJAq3+Lyhc9hOXvFRA9JxmavULAr+Rg78Q=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:
	 In-Reply-To;
	b=qkEmCt+VDhkkSik9Pk7jBqTqoiIx04omgaswzGXBpCUCHQsFz6wIVjGK8K2toA5v
	 v/Pf7r8IYbJu/1IY2O6Bc30+Ms8EgU5GMDLfykYaLAryT9VgBS/dA8Y6fzD04xHEB
	 I71ysQkYlFDYbETM6qpmn6Y2N6/Dt9cA5Sdtgje3ToowqC6Ac+CPf6UlStD4Y5m4k
	 in0YsUY2cgWNZcjhGdQt+HeZk8rY4tydLSwS55ofoTkedzl84W/VItoypvzZnwPxo
	 IpRx7AGkDFOmckmla0q6OXQhBDQqXMRD2M7ea+5H3Msrz6EqrfxaBcniPs7THxFXJ
	 GK18k98OHfBoxOYgEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([195.198.253.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8Elg-1rb4KH2Yd6-014QFk; Mon, 30
 Oct 2023 07:36:33 +0100
Date: Mon, 30 Oct 2023 07:36:33 +0100
From: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To: Alexander Mills <alexander.d.mills@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030063633.GA7451@tb-raspi4>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:cI3W9l3Fhd9ZBxiUE+raRa8UFGnLFEoUodryQrOYVu5nzxEhU6M
 ERytN1Noyyjf9U328iekW5CVUdVYAe1T5P9mLvA/vC7wRu3kZiufDcmfEQuvCFX6PqQHPzm
 QEbzoBzoFJ68eUa12jxna3zJDuwMPhxpeJTAUnp+yxzxN+e/Y2oSzFsS07mN58hzhGcnblY
 JJVCDYU3lU/5Cexg0Rmzw==
UI-OutboundReport: notjunk:1;M01:P0:yYbr8djyixk=;do9qTNf630T4rD/eMc57VRjQSWS
 khyeulc+BuiTZF3+1jl55ZBzfXes5aJ9TYXRgxnUxR6p6eRJ97MMfhNv7gkU+PNa61mcxEIy1
 m4+R+AAqUIyDjkA7A9kTA3Uaijnkjgow5P6GaB9hqRklq97BnscWH+QukHnsBdcd3AfB6kJP3
 VFQviu3DRxn2/jk39pkLoX98G/tD2cnsGQd/Kxxnps4YRhaB70s6MezAGs17ehr1SjTfTzFcb
 VBGaa3uCponxwbvz6KDpxdCrAnumLrAjAWapb3ETDGbGmSjUZGZx0X9Lg3McB0t2A0X7Vhyc2
 +y8lBJ/C7AGFa9YGaMlz2T0f8V1RrSnqQqzSwZAzNdo8QTGuK34WliHL0PElpJTiuMphOvREb
 GoJZ8fFU4VqirrdpaH9dtV4oTHie+DZRaZfrRWTpdhTaQFX3s6R22281fAc1I9ICSLyi/0fh2
 VslHF3qArnlQsmvEhDC667J7/XKI4QBqC7PDu/zcws4SS0SGbN0bTwAG13TfSscbMgpySha25
 27+zxusOqLvn7dkn7ra1H5fBejciCyd/kjrzmVJlsfGEtFIx9qvu9uPEq+cRI6hISU9Na5ipX
 lJOjAHjwRm6DLzpGvb9CxZNtA7wUvTnLg5L8vymVsBOUPXUePBUD/JoAs+XHhSBjlyLhoOVRA
 120itfuudE6T3CFOiVHL46PHPpdgEfanlCThX+14UzfSiSPTs/Y5RttkAH6iKA+KQmgSej3jF
 Lsy3uooqIhD3pXSkxF/MJdE9tBdzguCCupSUExsGNq2bhvuNI5f23C7rwnkJdDxBkWPyWlcgS
 Mk
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 29, 2023 at 06:15:35PM -0500, Alexander Mills wrote:
> When a feature branch is pushed, we get a link in the console to go to
> remote, however when I push directly to main/master, no such link, eg:
>
> ```
> alex.mills@alex node-be % git push
> Enumerating objects: 20, done.
> Counting objects: 100% (20/20), done.
> Delta compression using up to 12 threads
> Compressing objects: 100% (10/10), done.
> Writing objects: 100% (11/11), 1.56 KiB | 799.00 KiB/s, done.
> Total 11 (delta 7), reused 0 (delta 0), pack-reused 0
> remote: Resolving deltas: 100% (7/7), completed with 7 local objects.
> remote: Bypassed rule violations for refs/heads/main:
> remote:
> remote: - Changes must be made through a pull request.
> remote:
> To github.com:elx-onlinx/beautychat-chatcards.git
>    ffe1e05..bb7b0ef  main -> main
> ```
>
> Having the link in the console saves me tremendous time and is
> extremely effective/efficient. Can we get links in the console plz?
>

If we look very carfully at the log, we see that all the messages prefixed
with "remote:" come from the remote (git server).
In your case github. Other "Git repo servers" like gitlab or bitbucket hav=
e
the same feature.

Git itself, running on your local computer, does not produce this links.
If you really want to push directly to the main branch and want to see the
a link, then you better talk to the gihub folks.
