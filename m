From: Alfred Perlstein <alfred@freebsd.org>
Subject: Re: [PATCH] Document the 'svn propset' command.
Date: Mon, 13 Jun 2016 15:09:17 -0700
Organization: FreeBSD
Message-ID: <3ba0c800-6e51-fe80-d73a-f45131f9269c@freebsd.org>
References: <20160612191550.GA14160@elvis.mu.org>
 <CAFZEwPM5qnzw7RCUwOkJFo+U982kVGU8_3GUTXvHAypKtvEgTQ@mail.gmail.com>
 <81a197e2-7e0e-176a-c934-0e5f95cfda83@freebsd.org>
 <CAFZEwPNGz18uyLT62PsR-ybF32KJPb5PssQXJXuA4eWUFtPXnw@mail.gmail.com>
 <CAFZEwPO3_gYP1fO1-3S1M0dnSVo1Ji9ALJNTdN-ZrYsNVfX0cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Joseph Pecoraro <pecoraro@apple.com>,
	David Fraser <davidf@sjsoft.com>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 00:09:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCa2v-0002RN-PV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 00:09:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423312AbcFMWJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 18:09:21 -0400
Received: from elvis.mu.org ([192.203.228.196]:54699 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422832AbcFMWJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 18:09:21 -0400
Received: from Alfreds-MacBook-Pro-2.local (unknown [IPv6:2601:645:8003:a4d6:85d2:6cee:fa6a:cfb2])
	by elvis.mu.org (Postfix) with ESMTPSA id 9EE25346DFA9;
	Mon, 13 Jun 2016 15:09:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
In-Reply-To: <CAFZEwPO3_gYP1fO1-3S1M0dnSVo1Ji9ALJNTdN-ZrYsNVfX0cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297248>



On 6/13/16 7:42 AM, Pranit Bauva wrote:
> Hey Alfred,
>
> On Mon, Jun 13, 2016 at 7:54 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Hey Alfred,
>>
>> On Mon, Jun 13, 2016 at 6:22 PM, Alfred Perlstein <alfred@freebsd.org> wrote:
>>> Thank you Pranit.  I thought that "signed off by" is used once someone
>>> approved my patch as opposed to when it's in "proposal" stage.  This was my
>>> first email with a patch for this issue, who should/could I have used for
>>> "signoff"?
>> Signoff is used to indicate that you are OKAY with releasing your
>> patch according to git's license. For more details see the
>> Documentation/SubmittingPatches[1]. To summarize you will have to add
>> this in the end :
>>
>>     Signed-off-by: Alfred Perlstein <alfred@freebsd.org>
>>
>> Though I will still recommend you to go through [1] properly.
> Oops I forgot to put the link.
>
> [1]: https://github.com/git/git/blob/master/Documentation/SubmittingPatches#L239-L307
>
Pranit,

Ah thank you!!!  This clarifies.  I will resend the patch tonight.

-Alfred
