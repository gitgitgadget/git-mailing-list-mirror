From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Work on t3404 in preparation for rebase--helper
Date: Fri, 13 May 2016 08:37:36 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605130835070.4092@virtualbox>
References: <cover.1462888768.git.johannes.schindelin@gmx.de> <cover.1463067811.git.johannes.schindelin@gmx.de> <xmqq8tzfgsbd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 08:38:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b16jq-0003jj-BY
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 08:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcEMGiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 02:38:12 -0400
Received: from mout.gmx.net ([212.227.15.19]:50050 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbcEMGiL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 02:38:11 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M5Lmp-1bow1h1pnz-00zXs6; Fri, 13 May 2016 08:37:34
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqq8tzfgsbd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:bh/PvPjP/thVYV8C1p9g7iAeh4myJiCLQFyiSf5WfnX2e6/YQa1
 4WzANzKwdeU2tYhD7Il0ISWGEh7SXjrVodUJbcceQ371Dz4IYpx7Mfh2v39ZKAiLakxDS61
 /iO3/P5x+qEASJcyx8u/ch2yRJQMGKc7J8Oa7d4DEw7xgzelgMaFVsT9eT6C7KXBABEMHFV
 5xf4xDwo590ZR1OMNP8Kw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f8e7D4m8jAg=:eFGCBQZqJHwaHivhNipikx
 U4cQWXayu1ARuvHCMwxI7ISZ/lS9GRnpCnWP6DB5yTFL6XWWyZqEotSsDonh1n83OSEp1nf0r
 1cv1LbYPBgiC7hkrJjMs4jNG5Lc66p8yZR8jBYMPt+YRoyfDfo1sTYuaLp60pnztbcZxjAf3V
 bzt/4rAnfdIGwX1dVkX7HWDWJh8o2FWtBZzzsjrwmWzNhtN/eNbBUPc4q3LWl1GaxfKsWjinV
 T1GFBtrMTHqGA722HkPQOVbt6mzP/d48dcikblbJwo4zid1j61qVhE4GjnzRWaCi99dr+pZLA
 VhjcN/pt3NC2mKSKaFSKzXuJ7zzi/u/qVOk7ZZumMHLeJ8s+ih6cDpwadZLv0ZiV4XCfa1/UJ
 ovvc+7nxZ7je3b6oiuHY1B9/3wKO0XGf3ktymArltRpSazsWoC6RYfw7KXp1pvgwIWd+iN1UZ
 K16SDeDezgeB0vrF42UNAr7E/D1BDA1A4HeBWupsZANHVJQNG6IjAzsp7SuFGasa6hkNrpP3K
 WmrPLQ4/y+7a+LDlnRP/NzeTVbwyLWXPrGM8iMXIehcWkywmgxDR6TrdWw0K9BfNBvdqtfZr0
 MuQRHtBExNRdafdlHzUeKev5SyMs/gcko0QX7WqScpKPg1IQURHKqO5dozCeEI8FCaV+PwJE6
 aXZoVQkqnILOT055l/D2p+rYduAPf8dtabeeAOeK2ZAPAqY7cRIep58d6R0Ud8Y243KFALvUA
 Kw2sZKxWwGHtUq7mhE6bqWFSv6Fe6pFvZgTZ9E6+rnvUYy8hS2DsMIM9cvBSZ5dH6JJ0JxRT 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294510>

Hi Junio,

On Thu, 12 May 2016, Junio C Hamano wrote:

> I took these separately already, and plan to fast-track them as they are
> both "trivially correct"; I double checked that what I have match these
> two, too.

Oh, okay. I just wanted to make things easier for you, and now that I have
a script to prepare patch series, it's really almost as trivial for me to
send out a new iteration as it would be to update a Pull Request on
GitHub.

Do you want me to hold off with new iterations in the future until you
clarified your preferred course of action?

Ciao,
Dscho
