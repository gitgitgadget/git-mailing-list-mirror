From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: Copyright on wildmatch.c
Date: Tue, 24 Feb 2015 16:58:35 +0100
Message-ID: <54EC9FAB.9090506@web.de>
References: <CAMDzUtyitrK__iE9ykfTuP+Ooq0FwMPp_NVgBfBGbSV52+OPoQ@mail.gmail.com> <CAMDzUtymj21ckMrA87q1TATeWuH6kS_TBrsJ_jVjfeH50CaniA@mail.gmail.com> <CACsJy8Do77QSKSERPE26bKJ0gANB0XmPVBLwb1QKAW4qe0ouAQ@mail.gmail.com> <CAMDzUtz_BhW_tuQLy+AiNY7hz_HXCmHOtUNDgMBc=Taeon_Dwg@mail.gmail.com> <CACsJy8APLtweaf-q8+nCzJC-8J_vNZp-Y=AtNkX4NPuYr1jb=Q@mail.gmail.com> <CAMDzUtxf0gF=JDgEk9EU3W2VWuP-Qy8-Kz-fTx_Y16UeFRGiYA@mail.gmail.com> <CAMDzUtw8ySWwHvx4G+0R=L5JpxKqeFFNQ8Rb6bo5FRGwArzJcA@mail.gmail.com> <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: torvalds@linux-foundation.org, gitster@pobox.com, jim@meyering.net,
	namhyung@gmail.com, Duy Nguyen <pclouds@gmail.com>, peff@peff.net,
	schnhrr@cs.tu-berlin.de
To: Guilherme <guibufolo@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:58:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQHsp-0007WT-9B
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 16:58:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbbBXP6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2015 10:58:46 -0500
Received: from mout.web.de ([212.227.15.14]:62562 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbbBXP6o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 10:58:44 -0500
Received: from [192.168.178.27] ([79.250.174.212]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MX0VQ-1Y3GqR04cm-00VyVY; Tue, 24 Feb 2015 16:58:39
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CAMDzUtzPxrtwdJN7cRmaMC_Sezmr9zSge=K_pc1OztEA8FVc=g@mail.gmail.com>
X-Provags-ID: V03:K0:q28QP+jiygSlLnseV4HD8rcrK1EgkNSY69wlMAXspqvcVWHWP9G
 Pe5C9EnM6avWIFBKIgEz8rwwAs9UKCEENcwLTft4CV/9ZSR+1x/tBsUMqxKzMoe80EhaEmc
 LqedFwpqKcv4EDlROf08L/A/hq89X8LGNZ4e4t+EJN9pC0LE5qvGHhKgKR5dmmF5BeXIESC
 KxnZzTKIHeuOEzXPvz1AQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264333>

Am 24.02.2015 um 13:34 schrieb Guilherme:
> This is just an email to all the people i have written in private
> about relicensing the files in need in TSS so they can reply to this
> email and it be recorded in the mailing list.
>
> The files are part of ctypes.c hex.c git-compat-util.h.
>
> On Tue, Feb 24, 2015 at 1:22 PM, Guilherme <guibufolo@gmail.com> wrot=
e:
>> Hello,
>>
>> I'm writing to you in regards to the files ctypes.c
>> which you have modified part of in the git project.
>>
>> I'm currently working on integrating gitignore pattern matching into
>> the_sivler_searcher(http://github.com/ggreer/the_silver_searcher). P=
R
>> https://github.com/ggreer/the_silver_searcher/pull/614
>>
>> For that i needed wildmatch.c and it's dependencies. That is parts o=
f
>> ctypes.c lines 8 to 31.
>>
>> Unfortunately TSS is Apache licensed wheras git is GPL, those licens=
es
>> are incompatible and thus i ask if you agree that your portion if th=
e
>> code is also licensed under Apache2 for the use in TSS.

That's fine with me.

Ren=C3=A9
