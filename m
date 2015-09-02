From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2015 is over
Date: Wed, 02 Sep 2015 10:58:07 -0700
Message-ID: <xmqqy4gon1ow.fsf@gitster.mtv.corp.google.com>
References: <vpq8u8qw047.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>, Paul Tan <pyokagan@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Sep 02 19:58:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXCIZ-00062Z-KR
	for gcvg-git-2@plane.gmane.org; Wed, 02 Sep 2015 19:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbbIBR6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 13:58:11 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36626 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbIBR6J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 13:58:09 -0400
Received: by pacwi10 with SMTP id wi10so18596833pac.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 10:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=c6KyhQEJRKT+DDGRLHZBR1ULq1mLC1t9pB5f4oI5DlA=;
        b=WU1XFcAZOcE7rdCsi66uFl75OBKeRa96jWYGOh7MUq679hdlDHY8VXCjV0cuQWEzI1
         khx7fHhFxO9eRnjn+D/X/NzkxpfjT/8pOF6I9AJnuWhF1Hx2TPA/FLl2hX8Hfn7zWkjI
         dhnlfBJYAUgdFeNu53BVoBCWOuoh2E6e/kaT6WGAe4MUY5QmEMTOqXTtlCKD3YaDLuIY
         FjrY9G3vBPiiReTWO/oN1fgBGUYFruWR5hPJgVHgHxjm7pLSiRhjzCF91AKMx4QhLi8o
         uLAPVy73wIkWKTAEg5v3Y6mNrBXiCcGuv/4O5jv41dreUunAkM6vYF8rPE1tVE6fpJxU
         CbkA==
X-Received: by 10.68.220.226 with SMTP id pz2mr59170751pbc.115.1441216689282;
        Wed, 02 Sep 2015 10:58:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2414:9e5f:bc96:1638])
        by smtp.gmail.com with ESMTPSA id n5sm12922211pdk.71.2015.09.02.10.58.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Sep 2015 10:58:08 -0700 (PDT)
In-Reply-To: <vpq8u8qw047.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	01 Sep 2015 18:55:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277112>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I consider this GSoC as a great success and a pleasant experience.
> Congratulation to Paul and Karthik, and a warm "thank you" to everybody
> who contributed: administrators, mentors, reviewers, and obviously
> Junio! (not to mention Google, who made all this possible)
>
> Thanks all!

I've been generally negative about GSoC from past years' experience,
but this year's GSoC made me rethink.  It can work well ;-).

I do not know what made it different this year from years past.  We
may want to ask ourselves what made it a successful year, so that we
can repeat the success factors the next year:

 * The individual qualities of the students we got this year must
   have been a major factor.  This we can indirectly influence by
   having a very engaging microproject period, I think, and we did
   so this year.

 * I cannot say anything about mentor-student interactions, which
   are largely private.  Mentors may want to share tips to get
   students more engaged, or perhaps the level of engagement was
   primarily affected by who the students were.  I dunno.

 * The topics chosen this year were well-sized, not overly nebulous.

 * The reviewers were helpful and probably more active than past
   years.

Thanks.
