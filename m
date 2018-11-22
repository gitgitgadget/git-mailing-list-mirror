Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 333DF1F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 17:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeKWEGf (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 23:06:35 -0500
Received: from mout.gmx.net ([212.227.17.22]:58683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKWEGf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 23:06:35 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfEsY-1g5UL210l0-00Op51; Thu, 22
 Nov 2018 18:26:10 +0100
Date:   Thu, 22 Nov 2018 18:25:54 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     stefan.naewe@atlas-elektronik.com
cc:     gitster@pobox.com, git@vger.kernel.org,
        git-for-windows@googlegroups.com, git-packagers@googlegroups.com
Subject: Re: Git for Windows v2.20.0-rc0
In-Reply-To: <08df3706-fe2c-519b-f27c-3f706739d1d4@atlas-elektronik.com>
Message-ID: <nycvar.QRO.7.76.6.1811221825140.41@tvgsbejvaqbjf.bet>
References: <xmqqh8gefowy.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811202152290.41@tvgsbejvaqbjf.bet> <08df3706-fe2c-519b-f27c-3f706739d1d4@atlas-elektronik.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1278918485-1542907570=:41"
X-Provags-ID: V03:K1:40+ZIA5UhW4oJBnEUfGIo21j1xPz2ciX2cr7uR0yjZ6ykGe6vXP
 eGKbfIjQpDt4mhIg/j/2nVSDv3xt3HQ0hCRiUwvtSv6j+ZmQucu5iiaR47fo6gbSoUklkzt
 FPsN6qN/RkN97pupFTvxMq8qfu0586Q+m4P5DBMNpiKleOZ4AVx7l5ElEIhV4IyDtYxqYFR
 w477CLtWErnnfoYDVvcbw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G0vUn0EAUA8=:iIdI2guYNKdLL54SD6VnJ0
 33RyQDgJMMVOh5P1OjpglfauGS4OGPt60x4AfUVEJy8IMpfyuwqJRZABUzL/FPveu7s2fgdS1
 kD03zPf15OD5IhzbXnQY22D2faxqQU8YO8Mjo05t3Qf30OB4Ve8rCwJLcgLGYknUN6j7q9vEz
 X0xXK9agllvDelHwzWaYcFbRIkh4CSSlY24XgFxYeFEu0MlAft3u24UpgTJkW08ig99pQig+A
 ZgtLx+FLN0ViiUh8LSu/485f0OYjgb19fN6CIxoEtLXzOoxBtzO6AkUp4FYp5oJcSZFfneGT7
 iScSWmJGq8l1xDnnqbAdhuarHBHTCW2C3WanqDmx18KpykVL8XPvMVP405YgBZTEC7XKIMoxk
 OYmLrcwp7JcdrKRUrxkjI4FjmnJks1RutEwks+1EqXctutTv+FJopZ9GiLmws1WPcOz2+9tJj
 mgwgy2NE+EacPPUzdfYNtNMNn82PLvxM89JFDfyjAIqYiLs+M6LtDdbarlzIDgLX3stzI8Cfs
 VZXziGDelBasQFq+zt0DGZhbyhYHP6J70cf8/dsuDr79m3SPXtDJqw7h1RD0urY8wSuvPmH/J
 GUo0nC0mSO5KCi7u5yltZHM3VuCp/Hh7nUZQPUfLVQ/0ns3CStnI9E8qdPz0kviUDC+pSAbqx
 cYH4rVERZnUvMNBdZ6MZwjzNmEFCr08VDagzjGHAPENItmb1qws2QcW/wLmVHtZUvWYcpPNX3
 LJy82pxpoQAXkIFH0eElA7ICHnrTBiLBDOFnDwbzO5u8BYYbfbpwGGb5bP54tv/gUb8LEnHek
 PkZ0g7qSPSb+UOMLxmpqkY4+4WMkEp4szWw3vUk8yhIqImpI1zuf+AhUm2CQZDfKxdrF6Irdx
 PzlGBnpuDKPlLYrE6/qkxgYr40AsE5Lj4yctJXylbrYL4XP2juDtdYx8fJspLv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1278918485-1542907570=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Stefan,

On Thu, 22 Nov 2018, stefan.naewe@atlas-elektronik.com wrote:

> Just a quick note:
> 
> I installed v2.20.0-rc0 with these options:
> 
> $ cat /etc/install-options.txt
> Editor Option: VIM
> Custom Editor Path:
> Path Option: Cmd
> SSH Option: OpenSSH
> CURL Option: OpenSSL
> CRLF Option: CRLFCommitAsIs
> Bash Terminal Option: MinTTY
> Performance Tweaks FSCache: Enabled
> Use Credential Manager: Enabled
> Enable Symlinks: Disabled
> Enable Builtin Rebase: Enabled
> Enable Builtin Stash: Enabled
> 
> 
> 
> When starting the git bash two windows pop up instead of one.
> One that's "empty" and the other one containing the real git bash.

Thank you for the report. This has been also reported at
https://github.com/git-for-windows/git/issues/1942, and I fixed it in the
meantime.

Ciao,
Johannes

> 
> Thanks,
>   Stefan
> 
> Am 20.11.2018 um 21:56 schrieb Johannes Schindelin:
> > Team,
> > 
> > On Sun, 18 Nov 2018, Junio C Hamano wrote:
> > 
> >> An early preview release Git v2.20.0-rc0 is now available for
> >> testing at the usual places.  It is comprised of 887 non-merge
> >> commits since v2.19.0, contributed by 71 people, 23 of which are
> >> new faces.
> > 
> > The "for Windows" flavor of Git v2.20.0-rc0 is available here:
> > 
> > https://github.com/git-for-windows/git/releases/tag/v2.20.0-rc0.windows.1
> > 
> > The current change log for v2.20.0 reads like this:
> > 
> > Changes since Git for Windows v2.19.1 (Oct 5th 2018)
> > 
> > Please note: Git CMD is deprecated as of this Git for Windows version. The
> > default is to have git.exe in the PATH anyway, so there is no noticeable
> > difference between CMD and Git CMD. It is impossible to turn off CMD's
> > behavior where it picks up any git.exe in the current directory, so let's
> > discourage the use of Git CMD. Users who dislike Git Bash should switch to
> > Powershell instead.
> > 
> > New Features
> > 
> >   • Comes with OpenSSH v7.9p1.
> >   • The description of the editor option to choose Vim has been clarified
> >     to state that this unsets core.editor.
> >   • Comes with cURL v7.62.0.
> >   • The type of symlinks to create (directory or file) can now be
> >     specified via the .gitattributes.
> >   • The FSCache feature now uses a faster method to enumerate files,
> >     making e.g. git status faster in large repositories.
> >   • Comes with Git Credential Manager v1.18.3.
> >   • Comes with Git LFS v2.6.0.
> >   • Comes with MSYS2 runtime (Git for Windows flavor) based on Cygwin
> >     2.11.2.
> >   • The FSCache feature was optimized to become faster.
> > 
> > Bug Fixes
> > 
> >   • The 64-bit Portable Git no longer sets pack.packSizeLimit.
> > 
> > Thanks,
> > Johannes
> > 
> 
> 
> -- 
> ----------------------------------------------------------------
> /dev/random says: To save trouble later, Joe named his cat Roadkill Fred
> python -c "print '73746566616e2e6e616577654061746c61732d656c656b74726f6e696b2e636f6d'.decode('hex')" 
> GPG Key fingerprint = 2DF5 E01B 09C3 7501 BCA9  9666 829B 49C5 9221 27AF
--8323328-1278918485-1542907570=:41--
