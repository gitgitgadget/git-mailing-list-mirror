From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows download broken?
Date: Wed, 16 Mar 2016 19:08:57 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603161907420.4690@virtualbox>
References: <CACwWb3Dm8CfhZKvfNz-4Pj=tytf3zroFxnbbTq9DM+xm4EPEig@mail.gmail.com> <CAGZ79kaz2xPUO+zUK9LSqwWPK0aYPirwjgwzKmZgGbscxq6anw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Levente <leventelist@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 19:09:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agFsf-00088x-C7
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 19:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935159AbcCPSJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 14:09:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:54601 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933425AbcCPSJC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 14:09:02 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M5Z5A-1ZrcG20ls8-00xct4; Wed, 16 Mar 2016 19:08:58
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAGZ79kaz2xPUO+zUK9LSqwWPK0aYPirwjgwzKmZgGbscxq6anw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:gWxu7swEqfM+Ph3fdV3gWbnul3WBUsdHsO1WiNiuCgCps4eml+X
 pao6FHoTZaEAYM2PACutDJK4oqzWadM0D+scIG0zGMvxX56eoZzmyOwXkBWzm7105btcrgc
 vcyjokhapO/cNTLkIx3njcZ9eW5y7Bf84iPyK3VwGcH+wkvzyDBBS+2nxpPMf0wwHwmDo+c
 pyV1cOBS+2eHu5DF78tSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MKn8vjd6+rM=:qUXige2QkJGc9p1nd/OKmD
 aIrKmu6+15uptmz1jxYWXbacWOLfErMEv0dO6Sol+27dC2qVvdOv7bZNDG5F6MZzkuCAioDMt
 bxXTNV9J7ZsvhW5TPwdWVrTzQ/YZws4/Ufl5gxT7wHwbemCG5kK+n0x6fraKldLe3LKinxgxu
 hiPX3CioiIhJcs2By9Y26jmBjJGWT038LFcJQwIo66MqV6Bqcpi5q6Jd5udJAGChrSPLdKfHQ
 meJhfbtBmujAfNQSIdI+053b8uWc7ZDF7D9Gbh59aS0iAdhhOOhZE0FObEo6wi4BLtUG3VI4b
 M6vb+IhzDDJ5gMyqDHFcbbHydLnNUJr3NjaPp4tcW5ETOgiV1NrClsems4RnHavrCtsg8GrIk
 //4xgg24ie0omceZg4Y5I3e2O1ge9/FnNac399BAzAI9kFahZvayZP8vNOFUzN++uWdhKvZmI
 ZY48YDouhH8nSjm0HstG0SKxs/+aj0X4T3U3cZknoIYYG6BtSREttErGQ/dOSQl4LejYFpi4x
 R2Z9rCHepauqElhoUnrxxTHTncULdHGrajKedtKNF3swStOk9EOMEitp8gujshHESZt9nUc3K
 AOGdts2dUoKoExxIN1a7/HBAP3G43hMcJ1ppUokcOs1wgKupxZUhjdxtIL23buTYVZLCAxvXx
 hEAVdxdUF6sM4U23/p7wPqGM2lAHYV8fyw86VihwIo0BTWepsJFIOgaLG6BNDZujrCZ09hsVT
 z+IVkPdedfJsvby9rFUkczDNurL2fPDUcKmEQJ/UBGr9hBw08v0oee4qX6vgnfYesopjhuoI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289009>

Hi Stefan,

On Wed, 16 Mar 2016, Stefan Beller wrote:

> On Wed, Mar 16, 2016 at 7:06 AM, Levente <leventelist@gmail.com> wrote:
> > It seems that this link is broken:
> >
> > https://github.com/git-for-windows/git/releases/download/v2.7.3.windows.1/Git-2.7.3-64-bit.exe
> 
> I think Git for Windows is discussed mostly in the GitHub issues.
> Anywhere, cc'ing Johannes, who does Windows releases.

Correct, on both accounts. These days, I read the Git mailing list,
though, so all is good, people can report stuff here (I sometimes even
look at bug reports via Twitter, although they are all lacking too much
detail to be really useful) ;-)

Ciao,
Dscho
