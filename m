From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: (local ?) BOINC repo broken again -or- how to act
 on the CR/LF changes made upstream
Date: Sat, 13 Sep 2014 16:55:51 +0200
Message-ID: <54145AF7.4090606@gmx.de>
References: <541336D6.3050803@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5F9@romw-mail.romwnet.org>
	<54133C3A.4080700@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5FA@romw-mail.romwnet.org>
	<541343BC.1050503@gmx.de>
	<1BAFA9B4D550C347962F76F2E03B3BBB22C5FB@romw-mail.romwnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org
To: Rom Walton <romw-egxtZiWXYP1AfugRpC6u6w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org Sat Sep 13 16:56:01 2014
Return-path: <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>
Envelope-to: gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from mailapps1.ssl.berkeley.edu ([128.32.13.237])
	by plane.gmane.org with smtp (Exim 4.69)
	(envelope-from <boinc_dev-bounces-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>)
	id 1XSok4-00033S-Vq
	for gcdbd-boinc_dev-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Sat, 13 Sep 2014 16:56:01 +0200
Received: from mailapps1.ssl.berkeley.edu (localhost [127.0.0.1])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id 6A3BB2FEACC;
	Sat, 13 Sep 2014 07:55:58 -0700 (PDT)
X-Original-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Delivered-To: boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org
Received: from mail2.ssl.berkeley.edu (mail2.ssl.berkeley.edu [128.32.13.252])
	by mailapps1.ssl.berkeley.edu (Postfix) with ESMTP id A40F92FEA9A
	for <boinc_dev-78qBGAPTb87tebjJPvK1cED9O10f7Vne@public.gmane.org>;
	Sat, 13 Sep 2014 07:55:56 -0700 (PDT)
Received: from mailwall2.ssl.berkeley.edu (mailwall2.ssl.berkeley.edu
	[128.32.147.8])
	by mail2.ssl.berkeley.edu (8.13.8/8.13.8) with ESMTP id s8DEtuEl020506
	for <boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Sat, 13 Sep 2014 07:55:56 -0700
X-ASG-Debug-ID: 1410620155-04b397145f2b1c50001-LQ66t1
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15]) by
	mailwall2.ssl.berkeley.edu with ESMTP id JehuwcEFFATcS2Tt for
	<boinc_dev-C9EgComYM8RUAgJt6FLh2g@public.gmane.org>; Sat, 13 Sep 2014 07:55:55 -0700 (PDT)
X-Barracuda-Envelope-From: toralf.foerster-Mmb7MZpHnFY@public.gmane.org
X-Barracuda-Apparent-Source-IP: 212.227.15.15
Received: from [192.168.178.21] ([80.171.149.20]) by mail.gmx.com (mrgmx002)
	with ESMTPSA (Nemesis) id 0MdaCy-1Xh1fR1MCa-00PJhu;
	Sat, 13 Sep 2014 16:55:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:31.0) Gecko/20100101 Thunderbird/31.1.1
X-ASG-Orig-Subj: Re: [boinc_dev] (local ?) BOINC repo broken again -or- how to
	act on the CR/LF changes made upstream
In-Reply-To: <1BAFA9B4D550C347962F76F2E03B3BBB22C5FB-xy+Cp4waYzmnovBw3M9VzQFcV7zePqp5@public.gmane.org>
X-Provags-ID: V03:K0:KMPbqWTyro8XMNwB9eFXSW6Wx2PXGX5lH0iwHzF/NYQbBZWuASy
	ZeJBAyeSFGAn8IFzp1FcVA4q6nEjAbEG7b9Nt5M/bD+ldVQDDY9yewOvflaflPvYmW/FUet
	pnr071yU36bhfbVUoqg5lFGTDR8+1szLzk+QXU+NG3ZxsWKd3OV4Y0WuYDsdlneDiwgvMgD
	Z43gqrxWAUl8BeaRDExWA==
X-UI-Out-Filterresults: notjunk:1;
X-Barracuda-Connect: mout.gmx.net[212.227.15.15]
X-Barracuda-Start-Time: 1410620155
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256967>

On 09/12/2014 09:10 PM, Rom Walton wrote:
> I found this:
> http://stackoverflow.com/questions/17223527/how-do-i-force-git-to-checkout-the-master-branch-and-remove-carriage-returns-aft
> 
> That might help in the future.

This helped :

git reset --hard 9e860d0451
git pull
git clean -f
git gc
git prune


-- 
Toralf
pgp key: 0076 E94E
