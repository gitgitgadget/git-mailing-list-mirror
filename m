From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: (local ?) BOINC repo broken again -or- how to act
 on the CR/LF changes made upstream
Date: Sun, 14 Sep 2014 11:04:29 +0200
Message-ID: <54155A1D.8040504@gmx.de>
References: <541336D6.3050803@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
	<54155708.7090508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Cc: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi-S0/GAf8tV78@public.gmane.org>,
	Rom Walton <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org Sun Sep 14 11:04:40 2014
Return-path: <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Envelope-to: gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from mailapps1.ssl.berkeley.edu ([128.32.13.237])
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>)
	id 1XT5jb-00027m-SZ
	for gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Sun, 14 Sep 2014 11:04:40 +0200
Received: from mailapps1.ssl.berkeley.edu (localhost [127.0.0.1])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id C2A032FEAD0;
	Sun, 14 Sep 2014 02:04:37 -0700 (PDT)
X-Original-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Delivered-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Received: from mail2.ssl.berkeley.edu (mail2.ssl.berkeley.edu [128.32.13.252])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 06C9F2FE953
	for <boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org>;
	Sun, 14 Sep 2014 02:04:36 -0700 (PDT)
Received: from mailwall2.ssl.berkeley.edu (mailwall2.ssl.berkeley.edu
	[128.32.147.8])
	by mail2.ssl.berkeley.edu (8.13.8/8.13.8) with ESMTP id s8E94ZW3000354
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Sun, 14 Sep 2014 02:04:35 -0700
X-ASG-Debug-ID: 1410685474-04b39714612bfad0001-LQ66t1
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21]) by
	mailwall2.ssl.berkeley.edu with ESMTP id y0QdcvC0L7OLAtH9 for
	<boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Sun, 14 Sep 2014 02:04:35 -0700 (PDT)
X-Barracuda-Envelope-From: toralf.foerster-Mmb7MZpHnFY@public.gmane.org
X-Barracuda-Apparent-Source-IP: 212.227.17.21
Received: from [192.168.178.21] ([78.54.169.101]) by mail.gmx.com (mrgmx103)
	with ESMTPSA (Nemesis) id 0Lkfii-1Y1Kce3wiC-00aYyk;
	Sun, 14 Sep 2014 11:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.1.1
X-ASG-Orig-Subj: Re: [boinc_dev] (local ?) BOINC repo broken again -or- how to
	act on the CR/LF changes made upstream
In-Reply-To: <54155708.7090508-S0/GAf8tV78@public.gmane.org>
X-Provags-ID: V03:K0:LYwpCfWmSv0eZ1dNqQjs+IN0ztfyYHq+xAw68Tr3qT2bzk6oRc8
	WUOIE6IODf+aYS3CxCZMAWV1318DhKbZ8vBtlGv3eIssx3eWy8jyJJeFfAuNtcJ6VYya5Yg
	WZbnff2LRzuSqbidvUr/faXwnYoPS8C8V2jShdekPtbJDFMGzvHU/i4UcMeHpQmyHpDiEpy
	Ycs2rp8nHrncLtsW237vw==
X-UI-Out-Filterresults: notjunk:1;
X-Barracuda-Connect: mout.gmx.net[212.227.17.21]
X-Barracuda-Start-Time: 1410685474
X-Barracuda-URL: http://mailwall2.ssl.berkeley.edu:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ssl.berkeley.edu
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score-Disabled: per user
X-BeenThere: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: BOINC development <boinc_dev.ssl.berkeley.edu>
List-Unsubscribe: <http://lists.ssl.berkeley.edu/mailman/options/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ssl.berkeley.edu/pipermail/boinc_dev/>
List-Post: <mailto:boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
List-Help: <mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ssl.berkeley.edu/mailman/listinfo/boinc_dev>,
	<mailto:boinc_dev-request-C9EgComYM8RUAgJt6FLh2g@public.gmane.org?subject=subscribe>
Errors-To: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
Sender: "boinc_dev" <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257012>

T24gMDkvMTQvMjAxNCAxMDo1MSBBTSwgVG9yc3RlbiBCw7ZnZXJzaGF1c2VuIHdyb3RlOgo+IEl0
IG1heSBiZSB0aGF0IHRoZXJlIGlzIGEgYnVnIGluIHRoZSB0b29scyB5b3UgYXJlIHVzaW5nLgpJ
IHVzZSBnaXQgMi4xLjAKCi0tIApUb3JhbGYKcGdwIGtleTogMDA3NiBFOTRFCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpib2luY19kZXYgbWFpbGluZyBs
aXN0CmJvaW5jX2RldkBzc2wuYmVya2VsZXkuZWR1Cmh0dHA6Ly9saXN0cy5zc2wuYmVya2VsZXku
ZWR1L21haWxtYW4vbGlzdGluZm8vYm9pbmNfZGV2ClRvIHVuc3Vic2NyaWJlLCB2aXNpdCB0aGUg
YWJvdmUgVVJMIGFuZAoobmVhciBib3R0b20gb2YgcGFnZSkgZW50ZXIgeW91ciBlbWFpbCBhZGRy
ZXNzLg==
