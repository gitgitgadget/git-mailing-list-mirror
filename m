From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: GSoC 2014: Summary so far, discussion starter: how to improve?
Date: Sat, 26 Oct 2013 10:21:36 +0200
Message-ID: <87fvrophm7.fsf@linux-k42r.v.cablecom.net>
References: <8761stx04i.fsf@linux-k42r.v.cablecom.net>
	<20131019215139.GX13967@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ben Straub <bs@github.com>,
	Carlos =?utf-8?Q?Ma?= =?utf-8?Q?rt=C3=ADn?= Nieto 
	<cmn@elego.de>, Christian Couder <christian.couder@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Edward Thomson <ethomson@microsoft.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Martin Woodward <martin.woodward@microsoft.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Michael Schubert <schu@schu.io>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Pat Thoyts <patthoyts@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Philip Kelley <phkelley@hotmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Russell Belfer <rb@github.com>,
	Scott Chacon <schacon@gmail.com>,
	Shawn Pearce
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 10:22:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZz8d-00066Z-Ns
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 10:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab3JZIV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 04:21:58 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:50311 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab3JZIVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 04:21:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id E07B64D6514;
	Sat, 26 Oct 2013 10:21:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id lBCQsiilgZXz; Sat, 26 Oct 2013 10:21:41 +0200 (CEST)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.184.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A88594D6414;
	Sat, 26 Oct 2013 10:21:38 +0200 (CEST)
In-Reply-To: <20131019215139.GX13967@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Sat, 19 Oct 2013 23:51:39 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236742>

Fredrik Gustafsson <iveqy@iveqy.com> writes:
>> 
>> * Break projects into smaller, easier tasks
>>   - They should individually be simple, quick things if the mentor did
>>     them.
>>   - Should be parallelizable so students don't have to block on reviews.
>
> I'd 5-6 smaller projects setup for the summer, I think I managed to do
> 2-3 of them. (I did however do everything I applied for). I really think
> it's an excellent idea. This also meant that while one patch waited for
> review, I'd other things to work on.

Lots of kudo points for Jens and Heiko :-)

>> * Mentoring improvements:
>>   - Always have a co-mentor
>>   - Focus on social aspects (who to Cc, etc.)
>>   - Nominate separate "review mentors" to ensure fast review cycles
>
> I like the idea of review mentors. However bear in mind that you'll
> already have three people reviewing the patches (two mentors and Junio).
> We will not make it look like it's impossible to get things into
> git.git.

I think the idea was not that you'd get *more* reviews, but that there
would be a group of volunteers doing reviews to ensure that they arrive
fast.  Students should have feedback within 1-2 days of the series being
posted.

The other advantages are that it provides a set of fresh eyes, and takes
load off Junio.

I'm not even sure how official we have to make this.  In Thomas
Gummerer's case, Michael stepped up with reviews when I couldn't.  So
maybe it'll again "just work out".  But I would like to take this role,
and leave the "social" mentoring to others.

-- 
Thomas Rast
tr@thomasrast.ch
