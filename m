From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Nov 2014, #01; Wed, 5)
Date: Sun, 09 Nov 2014 14:05:15 +0100
Message-ID: <545F668B.7000805@web.de>
References: <xmqqfvdxi7aq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 14:05:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnSBI-00018l-8k
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 14:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbaKINFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 08:05:20 -0500
Received: from mout.web.de ([212.227.15.14]:51381 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbaKINFT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 08:05:19 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0Maazp-1XTJxd3M4H-00K9HI; Sun, 09 Nov 2014 14:05:16
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqfvdxi7aq.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:E8oJx7lYhGIx6NrK1Nrwmagxt2+RTFzHR5iGWFnGPcwWnX3DLof
 k5wLoI/psTPeBKXZHhdIsTZni+sAISFAi6ldXOJbBHTYM6/sF1ihuGkoShubz+KtT4vkiI0
 mvq+1VDzoiY7Aw1i2no3GUxOIF4UP8YNJlEMu01WsPSnBFAZwC46TMLqByXglmaVboU+ERy
 454JlhzN3yiNR9pu8e/rQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> * jt/timer-settime (2014-08-29) 6 commits
>  - use timer_settime() for new platforms
>  - autoconf: check for timer_settime()
>  - autoconf: check for struct itimerspec
>  - autoconf: check for struct sigevent
>  - autoconf: check for struct timespec
>  - autoconf: check for timer_t
> 
>  Reviewed, discussed and wanting for a reroll.
> 
Every time I want to test pu under Mac OS X this patch has to be reverted manually.

Is there a chance to remove the V1 version from pu until we got the V2 version, please ?
