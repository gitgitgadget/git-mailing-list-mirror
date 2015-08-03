From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Draft of Git Rev News edition 6
Date: Mon, 03 Aug 2015 14:16:06 -0700
Message-ID: <xmqqr3nk6pk9.fsf@gitster.dls.corp.google.com>
References: <CAEcj5uXXe19APhNaV6Kfm_3SNpRmFHToooo07T0_r6McJOrsaQ@mail.gmail.com>
	<xmqqfv4087b8.fsf@gitster.dls.corp.google.com>
	<CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nicola Paolucci <nick@durdn.com>
To: Thomas Ferris Nicolaisen <tfnico@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:16:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMN5i-000873-9o
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449AbbHCVQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:16:09 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33514 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932444AbbHCVQH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:16:07 -0400
Received: by pdbnt7 with SMTP id nt7so78384539pdb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ml3gPhXLY3XzvyhEtwSJFfYpSFxFRXG2LzvDGgcBLY8=;
        b=AnL0OXjuEYl4FWQwOOyfIpsuGpbzgZdICEDuUkh7SRCLlWMUjJAiwP/dm0+hXriaz3
         8nHTCVgYIu2FV1KWq7M1uZDAsuyJ8Awr+p+KCz8X2jjaU/V4gFZxscP+veGHYmlqPwUr
         bm2Mnureac1nc7LdUt8PIQYzUPhqgwhRJQcrHYnpvHobOx8FLHVYFsGGKsbemIRdyQLj
         mdWPHspdYL1RG9R624TMKFH4PFUqmlw+pGyUbxiibbGabAkJxAA4HVVkv/wtNYwuaRfS
         2y6FYLX7FR8X75QwOcyFmgrepcpDz7uBWHQocF8JaAICKvp37khkQo7u8kRSb1O8h5pi
         pD7Q==
X-Received: by 10.70.98.200 with SMTP id ek8mr126990pdb.95.1438636567261;
        Mon, 03 Aug 2015 14:16:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id y6sm18488266pdl.61.2015.08.03.14.16.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 14:16:06 -0700 (PDT)
In-Reply-To: <CAEcj5uUmsV5xzONaahkEEp7R80_zunSAiwTE2UeSxdS6wo1xmg@mail.gmail.com>
	(Thomas Ferris Nicolaisen's message of "Mon, 3 Aug 2015 22:49:49
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275205>

Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:

> I hope we can attract more contributors in the future, so the weight
> of this doesn't lie too much on his shoulders. Perhaps we should send
> out the draft earlier next time, and beckon for more contributions
> from the list.

Yeah, that is probably a good idea.  I was sort of surprised that
you announced to publish it in a few days.
