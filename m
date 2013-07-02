From: Johan Herland <johan@herland.net>
Subject: Re: What's cooking in git.git (May 2013, #05; Mon, 20)
Date: Tue, 2 Jul 2013 15:02:29 +0200
Message-ID: <CALKQrgdDBft0C7YPEUtE-fu1-qyMMgpzQXnadwndfj3QbwJL1A@mail.gmail.com>
References: <7v38thrxwo.fsf@alter.siamese.dyndns.org>
	<CALKQrgcmmaqAt-oVtFeem_xvqsjehacVoVJ2bYOyfKWTUzV0AA@mail.gmail.com>
	<7vtxlwqrbg.fsf@alter.siamese.dyndns.org>
	<CALKQrge33R9NiQ6isy4xEFaPe7SUmRaDbrXsjPahjtGp9ELG9Q@mail.gmail.com>
	<7vobamaq04.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 02 15:02:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu0EB-0005M4-T5
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 15:02:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751728Ab3GBNCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 09:02:35 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:58451 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab3GBNCf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 09:02:35 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uu0E5-000IpQ-LR
	for git@vger.kernel.org; Tue, 02 Jul 2013 15:02:33 +0200
Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UtyyX-0003Uk-PM
	for git@vger.kernel.org; Tue, 02 Jul 2013 13:42:25 +0200
Received: by mail-oa0-f47.google.com with SMTP id m1so6270627oag.6
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 06:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EUeQyVLtbJhLuJ4eW9gGXGrdKVKDrau3RCIkaTtEzMA=;
        b=dIkumihQBlHbGkbDlm0qjWl6pAjrirug/Axbo8Q7QcxqzWccg885TFPjm75s4xNE+r
         /xGJZnbqJjby+n0Y8W3tWaDB6ZwoLXZna4LFSt/GaWfJk9Pwuo3HZLXWFml8s+HyO0dm
         qi9lflvOcb4mQdxoN3R5Tz7n2OqNh5YJHVna6vYnCrxpTyv1ZSfCL4u5FcSApYcadyaA
         +yTPaymSKsdwP3vnn02Ni573tLfs7CQN9y03dhPbj5fgJBUqikLRyKuYEvZ99waFelAS
         giqjT9Pgd70oss0h542l+gukn4MM7WrM7xO1WvvJI4BBVEirSOTeTnneEHrBu40udP31
         DE3g==
X-Received: by 10.60.97.1 with SMTP id dw1mr11692198oeb.1.1372770149902; Tue,
 02 Jul 2013 06:02:29 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Tue, 2 Jul 2013 06:02:29 -0700 (PDT)
In-Reply-To: <7vobamaq04.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229394>

On Mon, Jul 1, 2013 at 11:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johan Herland <johan@herland.net> writes:
>> On Tue, May 21, 2013 at 5:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> ... I think we can go either way, and the above "I think this is
>>> being rerolld" was primarily keeping the options open.
>>
>> You're right. No point in setting things prematurely in stone. I'll
>> fold jh/shorten-refname into the ongoing series.
>
> Ping?
>
> No need to hurry, but just to make sure this didn't disappear from
> everybody's radar.

Still on my radar, but progress has been slow lately. Will hopefully
make some progress in the coming weeks.

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
