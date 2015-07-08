From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Draft of Git Rev News edition 5
Date: Wed, 08 Jul 2015 15:02:29 +0200
Organization: gmx
Message-ID: <96e72d94244ef3d2b7ecdfdb83fdbafd@www.dscho.org>
References: <CAP8UFD2fpRiOmgL9GW-1N9ZLAY+p-nOSH-b57vJFO4e_tELrWw@mail.gmail.com>
 <20150705191101.GB9815@flurp.local>
 <CAP8UFD3pD_6_SrrtCWywA8x5XY_SD3bed=QhZBBrTq0zQvqFPw@mail.gmail.com>
 <CAPig+cTpy32c13Sv=m49hzqOBisZ0v07AT0X5BYNB07acrcW8w@mail.gmail.com>
 <CAEcj5uXiGVvLm==s_SB7GnvBfuKi7j4yH+fgNq4JZtkvK7pZwg@mail.gmail.com>
 <CAPig+cRv6g_nAEdGtrESFiE+5+OxEHwjhEPX0Q0WL+eHzkCAGA@mail.gmail.com>
 <559CCFBE.9000702@drmicha.warpmail.net>
 <xmqqegkjyu0b.fsf@gitster.dls.corp.google.com>
 <CAP8UFD1=KxcYyFfFZ++5Vty-KMv-ci8dtdo4bfX7oj_wgLOE7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nicola Paolucci <npaolucci@atlassian.com>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>,
	Eric Raible <raible@nextest.com>,
	Emma Jane Hogbin Westby <emma@emmajane.net>,
	Max Kirillov <max@max630.net>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	karthik nayak <karthik.188@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 08 15:02:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCp00-0004Sq-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 15:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbbGHNCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 09:02:48 -0400
Received: from mout.gmx.net ([212.227.17.20]:55919 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932617AbbGHNCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 09:02:45 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MgGDK-1ZPW1j2v26-00NjE1; Wed, 08 Jul 2015 15:02:33
 +0200
In-Reply-To: <CAP8UFD1=KxcYyFfFZ++5Vty-KMv-ci8dtdo4bfX7oj_wgLOE7g@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:QRg+b5O5PWnCFdjyYKPzUEFAX6my4TYVvfWOzSen5UGIxbc+bq4
 J+wGVQxRfBN4CplqYpUNkNlBpYVaNCSSH4NR1XcmgdQ5riu7GSFUxTJPEzdX2XYZT4S5ETA
 7YW95YqvZo9U2f92NizRDG9Tfeh6ArTu3rPdBIX3DiAecKBbDo5VV+SQ3Cogn6xqedbzruB
 MZ4xA+dahphark4mKrr1w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iki7G2+jcbY=:GrhEWDkXnaIwKwPHjQtDAx
 IUMX4GswdUR2U9Vyd5Goh1WHCVptXik5advnIY066FCeMM23YbtrhdBbKE2AEMQlISpmGOsHr
 +C8SrbFK4dnp0FCyp99H8f1jmuLyYCD7NbNDwE6vUpK9uTRrgzMHg1ffLWd64L2G1T6hovMJZ
 b9nRNmx3uFLM1+gD8SJDPb6qxCrxsUdQPaGXiF8vyApsKCfBlz4Qfp2xoFAhQrTGVDtWxZ3Qj
 8dZMpfSLKMkio3cstI1/4LeZgUS9jVCJG3GAHLHrtuzcAbMlyP64kXF7dv11LBwp6qbAtj0JW
 pa9xc9/WRqv6jxAH+Qb1PBf0IcMcFan3O9FJFOYIjUGFro5xMKu8fulsHK7qWLCEqN64eU+zE
 dltPzcahBlyX3MxWkJtMm7OemVnBCcZh2Ne93jJecDY1F5YyKSMNZ6Q1nU71NbLODFU5nZAmZ
 N9nslhbbNlp4AMbZGf+ls9qhPE4RywtQ8bpt18J7wFNtalJ6YQbM9AAwPJiY9Lwgm20weNztC
 I/V7ytH0v1qlx6TbpEcDXb7EX19tfAA/LoyrCcCAWh3kXMH/XuoHNMYvHlbF4lWuL4NBfcNxG
 BqGWE7j4v0CIY42Kz4bQb1CdjkiolqJ8YN3xoeHSEmLehcH2um1tppOoZhkaKwC8EL1O+taM+
 h2Af6WzQErgsvBMP1F/vNiLAcpMLfgy/LMGZl4+FKCqhoimihOkqyMl55rjckhrpGpqc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273681>

Hi,

On 2015-07-08 12:29, Christian Couder wrote:
> On Wed, Jul 8, 2015 at 9:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Just as an example, in the section on "visualizing merge diffs after the
>>> fact", few people will be interested in the detail that I pointed out
>>> the "--merges" option of rev-list to Dscho. While that recollection is
>>> true and everything on the git-ml is public, I consider "Git Rev News"
>>> to be "more public", targetted to a wider audience than the regulars.
>>> They don't all know how much Git owes to Dscho. If things like this end
>>> up in the news it makes me ponder for each on-list reply whether I'd
>>> rather reply in private. Maybe I'm being overly sensitive (though not
>>> affected in this case), but I just feel there are different degrees of
>>> "public".
>>
>> I do not see "Michael pointed out that there was a slightly better
>> way to do that" as saying anything bad about his contribution.
> 
> On the contrary I think that the way Dscho used sed shows some cli
> proficiency and might be interesting to some people.

Just for the record: I was really happy to learn about the --merges option. Also: I have not the faintest problem to demonstrate lack of knowledge publicly. It was kind of flattering to hear that my contributions to Git are appreciated, though ;-)

>> I however do agree with you that we want to see the newsletter aim
>> to summarize things better.  Instead of saying "Dscho suggested X,
>> Michael then refined it to Y", with full details of what X and Y
>> looked like, it would be more appropriate for the target audience to
>> say "Dscho and Michael worked together to come up with a solution
>> Y".
> 
> With the details, I think readers are more likely to remember the
> --merges option.

Yep, people remember things better when there is some story behind that they can relate to.

Ciao,
Dscho
