From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: git-log -p --raw broken?
Date: Tue, 6 Nov 2007 20:03:33 -0300
Message-ID: <f329bf540711061503u4f5ba006p10d4e518812ae893@mail.gmail.com>
References: <f329bf540711061448iab9d4a9q37e13b846dbc5ff1@mail.gmail.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 00:04:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpXTX-0007iw-Cc
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 00:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbXKFXDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 18:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbXKFXDf
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 18:03:35 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:41692 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398AbXKFXDe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 18:03:34 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1883761rvb
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 15:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Bbh3lFDAHyT4WMGxW07e8fSb2vuTxrsN+7S+JSfJ8sY=;
        b=VcOx+qguxKgZVSIQY6uE7bV6mPOtNhW0PrUs57QT/Jb3czmjGwH8KiLNPF+sixQFbURrawAczFyHbWQ7af2qb6SCEomKi3OXdD8KCil6s0CvkGilmviWy13LBBoa8i7MQutxyP7qKs+N1ZGc3DuNvxXKaY7GWYqBI8lFKayfzNY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MMW8xq3lh7BPUTjPBn/cpZojlZOGT99+HQGCKj6MXbg8DRVXv1eMsyaq/diItkDhYdc/cU5N66NUD8QaS59qoaCGtINqvK1R/Xo43y4Imh9k2dSnc/McEopmtw/BqvMVObR/I2TNBKJl0t9cJF6I+5WQ0O8ysiSDO8rlNzVJEws=
Received: by 10.115.108.1 with SMTP id k1mr43284wam.1194390213882;
        Tue, 06 Nov 2007 15:03:33 -0800 (PST)
Received: by 10.114.76.4 with HTTP; Tue, 6 Nov 2007 15:03:33 -0800 (PST)
In-Reply-To: <f329bf540711061448iab9d4a9q37e13b846dbc5ff1@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63743>

2007/11/6, Han-Wen Nienhuys <hanwenn@gmail.com>:

> I'm trying to get a list of
>
>   git diff-tree -t -r --raw COMMITTISH
>
> [..]

> Am I missing something?

I probably am, never mind this message.
\
-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
