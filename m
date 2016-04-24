From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC Project Selected | Incremental Rewrite of git bisect
Date: Sun, 24 Apr 2016 08:52:50 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604240851290.2896@virtualbox>
References: <CAFZEwPMr=imv==kvVULy4PDYKW-0RRQ5a+X8DFqNFhNjCSyWKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Roberto Tyley <roberto.tyley@gmail.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 08:53:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auDuy-0003al-A9
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 08:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbcDXGxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 02:53:06 -0400
Received: from mout.gmx.net ([212.227.17.21]:61507 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592AbcDXGxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 02:53:05 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Ldcv0-1bcsP13JpK-00iju4; Sun, 24 Apr 2016 08:52:53
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAFZEwPMr=imv==kvVULy4PDYKW-0RRQ5a+X8DFqNFhNjCSyWKA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:WZ5/YZg/1+SjkNML9qglaGkIqejK9LoV30HKxuZ/hHmp2stIvK4
 PEqeL6cK1xkZsiQHajUMfz3PrmMtx3BlZFBq1DhCOclt4RR6QCIWUBjLfngVj9sac3IK6b7
 O5KbJMwntZssqR/dqqgkfazL7i+vXiNpBmVXzXygCYiilajPeIBHX1zBJ63ES+2nua8sNTZ
 X0k1imPGdYqqX49/udjFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4xYnQSLgeiM=:5veA57geKPB4716RgT0xya
 JXNvWkZ+EkwkQEfz73Ze2fY91eYviOSipHbcj8eAVuumpRbAw00EeWSYwD1nvA9vrV6aCEWeu
 itPOaHhoimBrF9/TiMgo8MGHwmJkJMhattmDIwPFJUeKLjZqRo+MF9q6ZGtiDc8+dLKRL2fdN
 dhvYmn8aR1Nv7X2h4oW1wznHNs655Rlq490Mk47N2wGGxeCg1+kDiCGt9YXao0c+gCFWnafM7
 MRMHU50ZVBoRaPEB580JbG7QPdt9y/+vqPjODYmy57Z0KopVw4xc062CmAV6WR9lNsZwQ1Bk7
 8VDi6bqIFC/QS6oJEuMKb0RUFAYdMDtzhyxOYwQxqnXskVaPgimo3rrc9GOHO+Lp2lDYE4Dus
 YJinVMyH7iz3UEHNe1xlUykLe+e6VeR4nt0/FqQcX35SOBOhaV320d+4uSFE70Y2MLUxnKucs
 +Yf+QNxI5i/2OR/zzPBICGCKC42+G0NzXlrtwrdZ7JzTE9wv++KUbPlsGunPqttudiZeMgWIS
 CPGGZ2G9IzluodBcK/0DP4L//3uzepyNDq54Orfn4UZht5f87A6E7UOBOHNw+rqGP3ZjMdg07
 gW23WjADr+ZRuUmj3A4pCap51aUzIc0HU81jaDsNfdiS8F/LEF0kj6pCCCyIgz6XpdFyxY1e3
 VWBgSWGSJhRYjCfgipaGD8LKVYNDmZR8sjzSAVXnzZYroyj7Ik6zCrwI5hGoUuPcl+BKsbPRa
 RCNdlA4Owi1nHfeU9UAwx6kBtQsf6xAFHHgUfX1ZRCYhvOg4WGpYcXvHRlq9if6qcFktejPd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292315>

Hi Pranit,

On Sun, 24 Apr 2016, Pranit Bauva wrote:

> I am Pranit Bauva studying Mining Engineering at Indian Institute of
> Technology, Kharagpur. I have applied for Google Summer of Code 2016
> under Git organization and my project[1], "Incremental Rewrite of git
> bisect has been selected under the guidance of mentors namely Christian
> Couder and Lars Schneider.

Awesome, congratulations!

Looking forward to seeing your project progress, and to you feeling at
home here in the Git developer community.

Ciao,
Johannes
