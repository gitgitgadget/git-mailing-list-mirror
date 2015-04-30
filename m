From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] blame: CRLF in the working tree and LF in the repo
Date: Thu, 30 Apr 2015 10:59:25 +0200
Message-ID: <5541EEED.60004@web.de>
References: <5541B2A4.8050108@web.de> <83824ee9e8a2ea1e08b05aadbdd2d1b7@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kasal@ucw.cz
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 30 10:59:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnkJo-00079J-5C
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 10:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbbD3I7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Apr 2015 04:59:36 -0400
Received: from mout.web.de ([212.227.15.4]:49905 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbbD3I7e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 04:59:34 -0400
Received: from [192.168.209.53] ([217.211.68.12]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0M5fhI-1ZBkJX1vzs-00xfOk; Thu, 30 Apr 2015 10:59:31
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <83824ee9e8a2ea1e08b05aadbdd2d1b7@www.dscho.org>
X-Provags-ID: V03:K0:MnOJWLjpmArEThJHsJ3hUjzAhFgNgdiwvuO6AGoQtT9quV5iG9i
 /LIqxyaTmcMgqaoZB4TkuybitYuSE6IFL/yQvHO8I/JekOX71FkT43w8y2HeI9beF4qpuvx
 oU4OhQ6LcdQuPbKHZ0okruq+nHDA0iMyrbi67KxgbsrC52mrXPmGic7upv3HZcueMmsqW1p
 F0vWBqbssTrWLi2aZuEHw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268065>



On 30/04/15 09:53, Johannes Schindelin wrote:
> Hi Torsten,
>
> On 2015-04-30 06:42, Torsten B=C3=B6gershausen wrote:
>> A typicall setup under Windows:
> s/ll/l/
>
>> What happened to the test cases ?
>> They where improved, but it turned out that they failed
>> from time to time, both Windows and Mac OS.
> Have you had a chance to investigate the failure symptoms? This is wo=
rrisome.
>
> Ciao,
> Dscho
Thanks for insisting  - problem found:
< 00000000 (Not Committed Yet 2015-04-30 08:36:18 +0000 1) testcase
---
 > 00000000 (Not Committed Yet 2015-04-30 08:36:19 +0000 1) testcase
(And V3 will come later)
