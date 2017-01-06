Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FDD81FEB3
	for <e@80x24.org>; Fri,  6 Jan 2017 14:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbdAFOFt (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jan 2017 09:05:49 -0500
Received: from mout.gmx.net ([212.227.17.21]:63444 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754883AbdAFOEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2017 09:04:37 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MgGDK-1cAk441MfO-00Nico; Fri, 06
 Jan 2017 14:56:02 +0100
Date:   Fri, 6 Jan 2017 14:56:01 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Anton Tsyganenko <anton-tsyganenko@yandex.ru>
cc:     Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
Subject: Re: Encoding issue in git gui
In-Reply-To: <8dc95372-979c-e8e5-5df8-1f4025ab0db5@yandex.ru>
Message-ID: <alpine.DEB.2.20.1701061452000.3469@virtualbox>
References: <8dc95372-979c-e8e5-5df8-1f4025ab0db5@yandex.ru>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1677856576-1483710962=:3469"
X-Provags-ID: V03:K0:iyhyD/OXcWI1Ac5jsLlouUiweobSw/5VMDoPSI0SZuHBFLx4XO1
 kLnKM5B+L5wdfCLIFgmY0oqYXCosGz7CTQInxyAMInmQaD2pQSHoxEBzSw9Z3NgdHOdwqJ5
 o9Gna5DE7JckLTTt8zFAOFIbZ2OgADa5b7wONqLz44TBQsrbVyXs5cugx1DBblFgiee+NRi
 kPSaIElRsWOJHXv3hjo4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KrpjpvA24z0=:8pF0JLTBh4Gy3XAZZMXZkv
 o9cgNLp6dJfJmvhkk/WNuryGf61fq65UwJhrEifq15ni2rYfLNWpRMWvyRJRJsvDGS49XIJL6
 ROGUG2RJlbQgpKq2Z9cgrJJjvzD0I9fLKy/bsmHIOxjTh1IVSgmkN6xKo+hhRwp4qh6dODCLU
 vLBziaZXbcygJXcPyQT2THWMH2pdTJX63hGGVfPn65djdApRMxa7mKOs1d75Daxte/wN+Z44k
 F2qKiLily1e4UHo9MZDlwYcEuv3l/rp2lD2h46I4aDna0zaE0ufrugQYpNCLHTas6dS8DlLkO
 Ijl7gf6nSq/kB17Tm243c0HRO70B2E9bkIBv8Nb7Js3diBC3t/09fdeDll29gmpKn+oBdNKpp
 WtqGpUv6KbNtqM6gEagzG/D6EMJT5M8lmkRg8VJwKodKK8JycAcru8c+vEIrPJ6SCvNGrgKyH
 xEvkNVvuDQ1TtxDuC5j/P6QCA+t72I/bMcK7zRolcoyzpmW9q7jN8ZLSQjcfQeBR98OOO4gyV
 FkYsk6vBSMqhSIzh2daFGvxnkXnsfrvvXcqcT3rqVvIAu+Jup+d3B7QXbP5WsWkc9PnA6zdQb
 3MQiobdhb+34RKEHHX8XkhecGxnblw/JbCsFWzywo4E/HCT2RmNmhLBWRj7lf7tEmKxEKCgSh
 Y3ugo13wN2lkyW2v3pW5FXiL0ZgyUgIQD82qcerNKaHrgkXDm5HGdK8VedyKFe8wkA2t3N9Y8
 t7dsWSrAJckjWcFbcM4PJjSG/UlMJLCvcbY4THCENZVc26PQgMM3+DG1QQ3E4u494r/pCVKU8
 ggh691dtUl7mvVjxarsPtdCf0MbTkRAqN8ivBiNnomwvowkAAL9yZz2AoZTBtNjxFZRPo8Khz
 Su0V+P1F/L0D5Kb9M41b7BzVu/sJscfqExbviHwXKo1cjqISMNcqBGbhtpOxuOv2qDbbwa4le
 5sUoHPMmNvwfCCn/ziaHpAJ8mqHrZsPxORQ/lvN+RMVPQ4fd3YEGkP9pdzqfEqJv90RJpTHDQ
 x0GrqclYP2QuWCIAQp6BHvE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1677856576-1483710962=:3469
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

On Fri, 6 Jan 2017, Anton Tsyganenko wrote:

> When I run a tool from tools menu in the standard git gui, the output
> seems to have wrong encoding. For example, add a tool called "encoding
> test" that runs command "echo =D0=9F=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D0=BA=
=D0=B0", then run it. In the output
> window "=C3=90?=C3=91?=C3=90=C2=BE=C3=90=C2=B2=C3=90=C2=B5=C3=91?=C3=90=
=C2=BA=C3=90=C2=B0" in printed instead of "=D0=9F=D1=80=D0=BE=D0=B2=D0=B5=
=D1=80=D0=BA=D0=B0".

I can confirm that this happens on Linux:

$ uname -srv
Linux 4.4.0-53-generic #74-Ubuntu SMP Fri Dec 2 15:59:10 UTC 2016

$ git gui version
git-gui version 0.21.0

$ dpkg -l tcl tk
Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig=
-pend
|/ Err?=3D(none)/Reinst-required (Status,Err: uppercase=3Dbad)
||/ Name           Version      Architecture Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  tcl            8.6.0+9      amd64        Tool Command Language (default=
 ve
ii  tk             8.6.0+9      amd64        Toolkit for Tcl and X11 (defau=
lt

Cc'ing the Git GUI maintainer.

Ciao,
Johannes
--8323329-1677856576-1483710962=:3469--
