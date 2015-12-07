From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Problems installing git-for-windows
Date: Mon, 7 Dec 2015 20:38:17 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1512072036570.21630@virtualbox>
References: <323868295.20151207124400@ptoye.com> <alpine.DEB.2.20.1512072001540.21630@virtualbox> <279121240.20151207191837@ptoye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Peter Toye <git@ptoye.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 20:38:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a61cA-0002Xw-24
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 20:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbbLGTiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 14:38:22 -0500
Received: from mout.gmx.net ([212.227.15.15]:60443 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932342AbbLGTiV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 14:38:21 -0500
Received: from virtualbox ([37.24.142.60]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MdKDb-1ZodUA3xlD-00IX2E; Mon, 07 Dec 2015 20:38:18
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <279121240.20151207191837@ptoye.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:R202sX68PObxcAJy01LnP1FWoH63MFiN6BamAA4qRb4qSVfdiRB
 +rOLbGcfo3h9aOax0VhWFs7G9JBYaC6MTzQ3GOUOcAfgOQEQ5w9e5ZWIKgY3X9gtm+N9KGG
 95wOSpFfgCqhnMHAOHcI+Y8pFFgSHK1vyUnkhWaupLur/rhdE2y7bGadhhlZxtggxWqyoBm
 qmkcaR+qebmrMzBDIr8Wg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hOzvBXFMIRo=:iAcX9jybBFsSPNno71IRjF
 7KpZOqJGpR0rC6s3aHb2iNm1uUhelhpxxjJtvIBSnm1hRqv8gNVVMJzgj35STEuRUY3WZ121s
 q561UCdr8AQohYYpklcjHsL4eVraynucrNXlV/LEWQuY5s5kmZpzcON8zq9ycteaJq51Zt7Dl
 eeJld36TzQpmapFjfd23cCpi5av8bbT1QHKaUmKII8shFRic5LEbs5jU9U/l3bp7bceJVxAvF
 HCRPp9Se4t8Ckd/zlN8/i0oWqM8KEOz/wOt576CuwI1ySS1K8aXLRj7DiHHbq7isUxRx7dnSn
 G7I6HwVi/TqHLcHaZGv+Udx7xdf4oSPDSkl6tC1yc1it9/+NhCJseMmy/IEtuEdjQWiBE2mW5
 48vwypTmQt4ao3INZVK00KK4aVR/4pFFve/Im1lJ/24QzgjNs7KHbIx4B8DGotpZjE+WKQ9v2
 lnRe7dAJg13oElbKQiR5Zb39j9G849ofcJ+TR+6dMEIxw2V7DKwTcY9ShHDNWjb+tZ9Sd1Cpn
 w7feRFnpxO1AOsVwFhiz6ihmOp0tSEuzUoBQhrZI2l1r2x76A2jlNwMINofGTUQDmylJn8uXp
 nx8AdQiqfoNKDQkWcMYA2Xsk8bndiuEqKNdNMdMqFHtg8dDVhQT8Lx2tmKSvzs4Fyc2I7Dd30
 RkBjStrSR7rp5A3Gs9ExwVlMVVPoFnezoSEsKyjX87OXFLpGAKqyCCCsRhB/8nKr1YepA0ik8
 HWwm49w7oqyL5AWA6HkH0Hka7iG2EM8nZwcHXc0Ht/HX1+Yl7epX2kK6fQS1+/q60oxIhuSu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282109>

Hi Peter,

On Mon, 7 Dec 2015, Peter Toye wrote:

> Thanks - sorry I didn't report the version number - it was 2.6.3 as you
> suggested. I didn't realise that development was so active. Do yo know
> when the next version will be stable or should I go for an earlier
> version?

I am "side-tracked" with a couple of tickets but plan to do a 2.6.3(2)
soon unless Junio releases a 2.6.4 first.

If you need a fixed installer *real fast*, you can follow these easy
steps: https://github.com/git-for-windows/git/wiki/Making-an-installer

Ciao,
Johannes
