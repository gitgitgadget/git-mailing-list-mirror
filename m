From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Promoting Git developers
Date: Sun, 15 Mar 2015 09:46:28 +0100
Message-ID: <CAP8UFD2ba3jQSsQrGGWM-8HTfGR+zZhmbkxiEBhSR+Ho=B0MuA@mail.gmail.com>
References: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
	<54FDA6B5.8050505@drmicha.warpmail.net>
	<CAP8UFD0KNbPBB_dOzw_dAj+ws190_cO8g7_jb_V33x1jxgvnqQ@mail.gmail.com>
	<xmqqk2yo22ce.fsf@gitster.dls.corp.google.com>
	<CAP8UFD37v_zOjRkUPLy-ChDs=+NetsDY7Q14-4rYA-WhnTRYyA@mail.gmail.com>
	<xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Kastrup <dak@gnu.org>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 09:46:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YX4By-0002w9-Sq
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 09:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbbCOIqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 04:46:34 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33967 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbbCOIq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 04:46:29 -0400
Received: by igbue6 with SMTP id ue6so14979274igb.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GlJkohTgdQxKqc1saqk1NqWL3Tpyvp+GeOAaC/uWz+s=;
        b=G5xFuS63t+olGnStIQiPF1SdYByinRxugQigaRaK230Z+9KRzGoAdcrqdhaqC3ELU4
         5wZ9gwYGla04n4T+mKtQ0fyElVBxlDtEQ0d1ZiEoMd3hH1pIFS8Z4Rgw9tT90fSvg5J3
         /114q7/GoOa/zdwcPBzbS1fiQm3LhyCbSY4fD/gtSh22CyL6TL6fTz9h58Guk9KyyPsr
         dKn0I8USLqUvFwlZzC8++hj5gwWXlWRpj+iCw/wXKj6LY8Ag0W1Cf/0WPtTEg3dXX2i7
         RlBZlBFO2URaeWLFs/rRVuJ4am4B04zD/Iwln+JTi8qGH5Cx3VBxoSCBBPtjY1tAIch6
         HIVQ==
X-Received: by 10.50.79.163 with SMTP id k3mr124420492igx.30.1426409188114;
 Sun, 15 Mar 2015 01:46:28 -0700 (PDT)
Received: by 10.50.245.144 with HTTP; Sun, 15 Mar 2015 01:46:28 -0700 (PDT)
In-Reply-To: <xmqqfv9b5krc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265486>

On Wed, Mar 11, 2015 at 9:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Tue, Mar 10, 2015 at 6:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> I would suspect that those who agree with you would appreciate if
>>> you or somebody volunteered to act as our CKDO (chief kudos
>>> distribution officer).  I do not think I have enough time to do that
>>> well.  One good place to start might be to scan the list and
>>> summarize something like the following on weekly or monthly basis,
>>> as these are not something you can get by pointing people to "git
>>> shortlog" output.
>>>
>>>  - Those who gave helpful review comments, "how about going this
>>>    way" illustration patches, etc.  Bonus points to those who helped
>>>    onboarding newcomers.
>>>
>>>  - Those who asked pertinent questions on common pain points, and
>>>    those who answered them helpfully.
>>
>> Ok, I can start something about this two points every week or every
>> few week. It would be best if I could get help from at least one
>> person as I think it is a lot of work.
>
> No kidding; even though it may no longer be an impossibly large task
> as in the infrationary epoch reported in the Git Traffic, this forum
> is still a high traffic place.

I wrote something about a potential Git Rev News news letter:

https://github.com/git/git.github.io/pull/15

Peff, could you give me write access so that I don't need to send pull requests?
If some people are interested to contribute even if it is only
sporadically, I would suggest they ask for write access too.

>> I also appreciate very much that you are willing to improve the
>> release notes by adding a summary with people's names.
>
> Just in case you misunderstood, I do not think it is a good idea to
> add names to release notes and I will not do so.
>
> I was and am planning add the list of contributors at the end of the
> e-mail when the release notes is sent out, i.e. in the "Announce"
> message that is sent to the list (and CC'ed to lwn.net).

Ok, that is already very nice.

Thanks,
Christian.
