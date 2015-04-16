From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 3/3] t0027: Add repoMIX and =?UTF-8?Q?LF=5Fnul?=
Date: Thu, 16 Apr 2015 14:52:01 +0200
Organization: gmx
Message-ID: <2eed28a82cbdb426a0d152c157d2cefe@www.dscho.org>
References: <552E9950.9050008@web.de>
 <c87875cc4da70fc671b40ba637421c94@www.dscho.org> <552EC2E0.3010705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, git-owner@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 14:52:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YijHF-0004UM-1C
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 14:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbbDPMwK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Apr 2015 08:52:10 -0400
Received: from mout.gmx.net ([212.227.15.18]:64443 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757288AbbDPMwF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 08:52:05 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LikQP-1ZEEH63UTd-00czwf; Thu, 16 Apr 2015 14:52:01
 +0200
In-Reply-To: <552EC2E0.3010705@web.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:WuF3CTq8xr2yO0Ao/3vy3WDWVaonCH7rtVjsNDw/Zy/jvdMwHGn
 KeIWDndlBrkD22lYYpO2up/EMk9P7Ak4+uo+ZCGkaQXFd5XQJiI9MVf0s2f0m+vF060JizB
 tBInQ7nlBvCpld6DFnDzf8f5MipDgUw6uCnSV5DgeojYDM2mZFNjStVP4XIm21gKDx87a5i
 LCD2BgMZu9iSn1D7U+PLA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267285>

Hi Torsten,

On 2015-04-15 21:58, Torsten B=C3=B6gershausen wrote:

> Yes, I try to be up-to-date with Git for Windows, but missed to follo=
w
> this very patch.
> Do you plan to send it to git.git ?

I did plan to send it to this mailing list (together with the other 23 =
branches we accumulated in all those years, at a mild pace, of course),=
 but *after* releasing Git for Windows 2.x (which is now imminent).

If you could cherry-pick my fix into your series, that would be splendi=
d! However, if you feel that you came up with a better patch, please do=
 not hesitate to drop my patch (I'd like to know about that, too, of co=
urse).

Thanks!
Johannes
