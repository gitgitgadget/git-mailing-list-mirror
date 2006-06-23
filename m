From: =?ISO-8859-1?Q?P=E1draig_Brady?= <P@draigBrady.com>
Subject: Re: What's in git.git and announcing v1.4.1-rc1
Date: Fri, 23 Jun 2006 15:04:56 +0100
Message-ID: <449BF508.9040207@draigBrady.com>
References: <7v8xnpj7hg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606221301500.5498@g5.osdl.org> <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 23 16:05:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtmIA-0002JJ-Bj
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 16:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWFWOFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 23 Jun 2006 10:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWFWOFq
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 10:05:46 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:21942 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750720AbWFWOFp (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 10:05:45 -0400
Received: from yzordderrex.lincor.com (mail@yzordderrex.netnoteinc.com [212.17.35.167] (may be forged))
	by zeus1.kernel.org (8.13.1/8.13.1) with ESMTP id k5NE5VwB006442;
	Fri, 23 Jun 2006 14:05:43 GMT
Received: from jumpgate ([84.203.137.218] helo=[192.168.2.25])
	by yzordderrex.lincor.com with asmtp (Exim 3.35 #1 (Debian))
	id 1FtmHc-0001rT-00; Fri, 23 Jun 2006 15:05:16 +0100
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060502)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606231305000.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.92.1.0
X-Virus-Scanned: ClamAV 0.88.2/1562/Fri Jun 23 07:50:07 2006 on zeus1.kernel.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22422>

Johannes Schindelin wrote:
> Hi,
>=20
> On Thu, 22 Jun 2006, Linus Torvalds wrote:
>=20
>=20
>>On Thu, 22 Jun 2006, Junio C Hamano wrote:
>>
>>> - diff --color (Johannes).
>>
>> - default to red/green for old/new lines. That's the norm, I'd think=
=2E
>=20
>=20
> ... and which happens to be useless for 10% of the male population (a=
nd=20
> even more if you look specifically at Asian people). But then, I just=
=20
> pasted that part from somewhere else.

:)

So 10% of the male population need to learn
traffic light positions rather than colours?

I'm red/green colour blind which means I can't
distinguish _subtley_ different shades of red and green.

vim is another fondue fork offender as it merges
syntax highlighting and diff colours in diff mode (vimdiff).
I put the following in ~/.vimrc to disable that madness:

if &diff
    "I'm only interested in diff colours
    syntax off
endif

P=E1draig.
