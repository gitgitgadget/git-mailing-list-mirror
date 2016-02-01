From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Plans for 2.7.1?
Date: Mon, 1 Feb 2016 17:54:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602011740540.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Feb 01 17:54:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQHk7-0007Jw-GU
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 17:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbcBAQyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 11:54:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:58503 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752896AbcBAQyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 11:54:18 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M8laO-1aECuJ0OaK-00C8wm; Mon, 01 Feb 2016 17:54:07
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XoVIdq0fDm2qQM99kAkrAxJnpY4lrq9KzwkTwv6kHSudDZy4l/w
 jxim96K5YN2qYy4x9CbhOJREsVsUrYEPVuEOc21OFMftydsau6pUsXfAbgVaWljwEBh/ooG
 kRdy9txRD8yoUq25K/CyfcoeKFkoYUd6k/vmh1OxYO/OaJWNwGqEIBqrn0VDLvijadRd8Hn
 l39+SQRgzMpctFz4UEwag==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fg+Pkmw4G/w=:vOEQZdmITWCMH1Yj/YMTB3
 Tsc26SCfakcJN62mgrJa7oLeuwC1p27gQcf1F9YmosetqbGyHimZomFoaBBljMhe3W/y8GT3E
 jCdoCie6skDgl22q29P8J0GxweuDTXTwK8sN71DlvzCSM/Knc8LFBGylA/yGX2U/2goxzhmEJ
 t/pXUoV0t6YmMCvjYFPfPrP7NvS0QjlcTeQvZamCblvqp1BtRLYoeaOL5AGCZjHqNMDsor/by
 8VoQj66gmgEyFC4/thNbpRvHD22LzOiCg5Zh7yWjoWHvvhRY7mykhLXWIRisXIM/jbCKmFm31
 eAz3GTYRQMi+yk0S3jYs+ms6A5vEn3L1faVQ3PsOSkjs6JvJrx3Yem6RdBjHi/NLP7vCsd0Nk
 C+w4gyGG5lNPcs9He08Bk4LX7ennautDPjexFoM0YIePt+b/N9ZX6WdnCL8lGhUB/pwQymTB+
 XJzHEPb9l/0/4paBRiGOwV7qNx8xWeGFVhh47vQHmrEvc5UEp7wpn0oJM8noQzOZp/1ugjtlq
 5E2qB12grCc9KMM/hWa4du6X7zCBpCU9lRDKplfICyKOnjFCBRCjJSMJsO2kYb7IGhAS1YrB7
 CxtWzGXm2LYEzws0tuGvF4E4bYlIJLCUHih9MAiicVWvQaNncjbeuFvCsKK+oIZPYWYh4/WgL
 MNkLrvj1LHhdirCAVwAvIUHl/RFY7Pt3CM3IMTX0ojstlELnUNwlyRt4b/DOBGH7sO5N0WZUg
 vea72NTDZbUQKwyJWwxsJySXFEnpbJxeGIe4am4mV2P7zsnKya2VJ7U2QZdL02zd8GIMjUBh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285201>

Hi Junio,

at tinyurl.com/gitCal I see a pretty timeline regarding 2.8.0, but I do
not see 2.7.1 planned anywhere.

Due to signature problems (I failed to realize that SHA-1 based .exe
signatures are no longer considered valid starting from January 1st,
2016), I got a metric ton of private and non-private bug reports regarding
"corrupt signatures", and therefore I would like to prevent those reports
from taking over my entire working hours by simply issuing a new release
of Git for Windows.

Is 2.7.1 around the corner? Otherwise I'll just make a 2.7.0(2).

Thanks,
Dscho
