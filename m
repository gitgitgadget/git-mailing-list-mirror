Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5425B1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 12:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfBGMpi (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 07:45:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:32999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfBGMph (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 07:45:37 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MVdfD-1gc6NN1sNT-00Z1Fp; Thu, 07
 Feb 2019 13:45:34 +0100
Date:   Thu, 7 Feb 2019 13:45:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 0/1] git-p4: remove ticket expiration test
In-Reply-To: <20190206151153.20813-1-luke@diamand.org>
Message-ID: <nycvar.QRO.7.76.6.1902071343210.41@tvgsbejvaqbjf.bet>
References: <20190206151153.20813-1-luke@diamand.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-731515098-1549543534=:41"
X-Provags-ID: V03:K1:5VdA/VGP/ioPWyxe0RkfBP2g/GpqkT2kl/bT0xFHY3yQj9HZxmn
 hcumuunpxOHHsYHgQLwe5+ioTKH8EZHS1tobbRQat+tLUgjvK96UAqBV1sb7u5jA9a8eWG4
 M36/6qX4RnyJjTrRz6B58gQp27exhfsdT/NMJjnyh2srQfroHoZWh8dOSpm6YBuPBU4JW54
 QxgsEoRS3EDv6z3dz/9bQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eD23h7njoEw=:aDSoKg/6oPZaDrxzivPKzn
 x7gv9jpIz14unSnSgbu7QP009kMmIqUDJl9AcCfAzuLpWHhF1eBPdFL7GeN43/tf76sfnt1AH
 BwRYGe+amZzr6Q2e4aavnhcSey+WnDDFnObtU1qZU8DFLbPJ9I0PnsOBLFyVLIFZ5iAHzLHHM
 abnQffNMCiR/gV4hJ6qYkbt6C/e3s8JSoBBhwKKKm/GPhAAFMN/PRCGSuyt/pfyx9gPxs2x9+
 PkewCDr2BdGVJjFA296yd5Xv5W8PY7zTuPMRLmJMgEuz+lgOR/ARHIzaHSSrDW6JYZFla/e/B
 5rCgJFl7pHOihk6s5mI+GdEUTdkrd14L0tFW8OK03T7IyQb+RJGfH7p/sx1RtmkjQuMi3SkVP
 fSH9eAvkYnd+0L9tio2NrD0GdEDhPOs8lQCskksDQOA5Q3Rk6c6tmBZS3Eq8bhnLFckOJlpMv
 ORdpf8qQteGBzlh6e5tO9KzaHe8Pok1taZUBlGa+onOkxAkprNiOJe6ZhonpfN+VDPHWFG1GH
 b4MY9qC0eNIM+Zy4iICJiqAkX+j9yxvldVJwgfWAjdhyioadlWrMrZ6Oju0fVGtpm8J5hOekv
 qwKxVTRpeD3XHkWsMSPnY6cEF13SPdC9ZEYrVx90YpMit/DWQBXYT9m7lFtxZxliXB3VtXhmt
 hXpvOfcGUhJHIp/Xo2NunVIRlg3hOJfTU9ETKWoluBEYCaPwIkpPE/ly3P/uoOc3vjKVY9EFE
 sl8gp7D849BjsJ16AwVbXEPdP+DFr4rKtcyx3mwSrqK6R/t0MxInGuW7YJ6E7BnL58SVY90WZ
 U5hxhbZsDaheJsA3GOWnGNsvPVr89TuFFYk2JkFqCl7BNz9P5y5d1OAEeN9Fz+v//jVAJKSVg
 YjAGc9lQisVmISPCevjs/b6HxGad/DNc6wjza9fIRqlGBGEw+VrFvUcvLg794GzQ28sizrEp6
 vbjZDK+bd1g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-731515098-1549543534=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Luke,

On Wed, 6 Feb 2019, Luke Diamand wrote:

> As per thread here, this removes the git-p4 ticket expiration
> test, since it isn't really that useful.
> 
> https://marc.info/?l=git&m=154946136416003&w=2

Thank you for the prompt patch!

However, like Gábor, my feeling is that we would want that test case in a
non-flakey form, if possible. If you think that that is only possible with
a mocked p4, so be it, let's remove the test case (because the mocked one
will likely look quite a bit different). But if there are easier ways to
work around the timing issues (such as dropping the first `sync`), then
I'd prefer to have the safety of a regression test.

Thanks,
Dscho

> Luke Diamand (1):
>   git-p4: remove ticket expiry test
> 
>  t/t9833-errors.sh | 27 ---------------------------
>  1 file changed, 27 deletions(-)
> 
> -- 
> 2.20.1.611.gfbb209baf1
> 
> 
--8323328-731515098-1549543534=:41--
