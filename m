From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Windows git bash - child processes see system PATH environment
 variable instead of user...
Date: Fri, 19 Feb 2016 12:33:53 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1602191233170.20796@bonsai2>
References: <CAN2vHUFYqKDDEJpGtxJ9aD+8abe-krnHBy7cm1tMm0+bh5ykBQ@mail.gmail.com> <alpine.DEB.1.00.1602191154190.20796@bonsai2> <CAN2vHUHhqVn8uXaUTdeU5mKuRLQ1084wJu27k4nMJgywOjdOdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Edward Marshall <marshallx7a@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 12:34:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWjK1-0003yM-Fo
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 12:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427234AbcBSLeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 06:34:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:60687 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426497AbcBSLd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 06:33:59 -0500
Received: from bonsai2 ([89.204.137.138]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MbOrg-1aDxTs14gG-00Imhu; Fri, 19 Feb 2016 12:33:56
 +0100
X-X-Sender: gene099@bonsai2
In-Reply-To: <CAN2vHUHhqVn8uXaUTdeU5mKuRLQ1084wJu27k4nMJgywOjdOdA@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:VocWWWcLNiY3tp4ftxsmtLAqQ9howNZCfJYTdp5GHeTLiR3ZTNa
 wWjSaE9QOSK0fIIB3a+FN4ajRxjeI2eEGHAtAMO4NOkS6iyiMQdvlR4NKMUJmhNuywV+KoJ
 GUIkuM+U+A9mOb6l9jGBjuSPBcgYzlLnU1e7jxSkduh7QlooAweX9UNkWW4AEOPKasbqqRj
 hn65iyDOQ39jrXozfntAA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cx7ORnZ3VFI=:lXrE44L+CMXnXHswkm8IgX
 /JEGvlvbtbkTk4qJCRWbaGbG8LFJmMW6MSZnEhKE09UAUdtoA51w4VOQhziTNTll+5zxAcuCA
 LjtUjk5JMjCj/d3wvk7ZhGhvDMcXmkbNp08v2lI6QDVVudcry+dlpExJ6VIWxPPjhO+ocb6P3
 5QBGoMUDZ2vXufWGGbLdMy+m5L+DZC4SjPg/ThIq2qEjpZNhY6/oW4LPsh+Wh85D6S/W7DGcp
 nbgmlB559bMBHWTzfzEcZP+NjuaCXXfLUusdXCciCDDy/uthKv0M7QxWWpsy2BMUxBkhdntd9
 4l/fDn+4lIukX3W6NuMBWOVPBJFnLcczcWW9pjXMAbP0TGLfmYVuLxDatzLNIjEJBRacvxu3W
 tOHa65FKl3xuDTG/rKy+WFFeCi/AYpnKJgMbG/hkURzqFW3sa7RyItcZoYzzan0jLd8ZIsSFx
 d0kRAFbXmdu4Yf7BtxBjB+W/Z0gG7nPbERgQZvQiOiPcPnHcYP7mvRyVpDmvGLw1FVm6lzge6
 2z42+A0d5a+23BWDbSsVGXm3SSn2QVTb5No8lTQiUPriPJQm/rEP6ITD6RcJ/Sn3ZHRQHhLbz
 estJtwsidonWNGClE6kBFnN0OHUm7Vl/cszamx82CVEmog20TFZRT+taZ2q0tU1OxHufmVduO
 8bYFu3PeI7Gmdsn9Tfh9VsyE+IsOJxNaFsHZBbqWEDVeaJVqcfqJzfh1D/wXntM5Md8b7Cvvb
 wx091SOX4wVP+MlxQ4LNSYwMpSjE7UEllQTPGQCfIo8OweLek2SFUtcRxFtQc1+4xZJP9lCf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286706>

Hi Edward,

On Fri, 19 Feb 2016, Edward Marshall wrote:

> Hey, thanks for getting back to me. I subseuqently found the
> git-for-windows issues tracker on github so have posted an updated
> version of this there - not sure where is the best place for issues.

It is the best place for Windows-specific issues. Thanks for following up!

Ciao,
Johannes
