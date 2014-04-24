From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Wed, 23 Apr 2014 22:37:55 -0500
Message-ID: <53588713347b7_59ed83d308cf@nysa.notmuch>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
 <53557071.5040500@gmail.com>
 <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
 <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
 <xmqqk3ah5i55.fsf@gitster.dls.corp.google.com>
 <5356c1a61f6d8_463e11ef310a5@nysa.notmuch>
 <20140422213039.GB21043@thunk.org>
 <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Lang <david@lang.hm>, Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 24 05:48:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdAeB-00078X-6G
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 05:48:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbaDXDsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 23:48:22 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:65239 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaDXDsV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 23:48:21 -0400
Received: by mail-oa0-f48.google.com with SMTP id m1so2020255oag.7
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 20:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=F1Cc7bLB6sV2QXWYwjuztvF3yxxpfEx8RpI5dM0/b3c=;
        b=vvi21S88gM8zW4XMF2a92gcNqwCXu1Z5lwfn0WCklq6bb7mwaE689dhWsqWhDd0r0u
         k/ooSMJDu0NRfI+dvji+aJFbaRDIEFdo4ttIy1yagAPvzLjfNboYTdBMsmNna3UHO7H3
         zCiK8SdG5cPK6/6n6WU71EBqLP1pLVgEoMUyPTs0lMsawsrpXPxuQggZtEaHNBbkKFqI
         VOSnLyMfQJ6mdIzYDOu8bF8McUpybeEyBJ6dWIh2Q6fbV23LMI+R7FV+Hbk+eqXv+Y/r
         L3BvrYKLPG2fHt7lCvp+jXjUpP+Cibvw1sc5mJegz4ajSPSiQmstVkPnSze/cPvRhuoL
         X3BA==
X-Received: by 10.182.79.9 with SMTP id f9mr49697obx.64.1398311301272;
        Wed, 23 Apr 2014 20:48:21 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id or12sm6003427obc.0.2014.04.23.20.48.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 20:48:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1404221523060.14881@nftneq.ynat.uz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246931>

David Lang wrote:
> agreed, of all the things that people complain about regarding learning git,
> the fact that the commands are words instead of cryptic 2 letter
> abberviations is not one of them.

It is when they start to use Git seriously and type them a lot.

> The complaints tend to be far more about how there are inconsistancies
> between commands, or they don't understand what's happening.

Yes, but you don't see anybody trying to improve those, do you?

This is low-hanging fruit we can actually change.

-- 
Felipe Contreras
