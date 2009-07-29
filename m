From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Pro Git Book
Date: Wed, 29 Jul 2009 02:34:00 -0700 (PDT)
Message-ID: <m34osv3kah.fsf@localhost.localdomain>
References: <d411cc4a0907271056x458d7b15lc1b2868a46884175@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:34:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5Y4-0004eG-Tw
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbZG2JeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 05:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbZG2JeE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:34:04 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:62871 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086AbZG2JeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 05:34:03 -0400
Received: by bwz21 with SMTP id 21so566602bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:user-agent:mime-version:content-type;
        bh=dmQW1ADoAE54fMZezqA97yJ14aTgbamhbI2OdBG9NCA=;
        b=asMXR8m5PDTOPYv1oJAYajrwhTMOwS2mWRiFJZfvZJwEHhYFxQr8Kf8peNQ6Lr+lla
         1n/T3Tq4yUzkouf33FFM7LsmX8tpoW/Xhy/D3oLEe3pudRuJhGQ8UOQfVLmFAD7eGirW
         WqgpLsUrBp4Mks+QZanAkVfA3g+TS97hDSaMc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :message-id:lines:user-agent:mime-version:content-type;
        b=VQMxm+rciEs/wUX+wkr3u7qEeNXDEBKPXsHQm6cfcpv5uIqnwHMAX2bJS3pbECWBEQ
         fbBSMHf0FduKJgYplbZIyBk/QugjKyjCXsBRAmw07MSNKe1S/c0GWDZF4VKlTh9lqayn
         jR97u/X2NiWHODnPqLxraiIvVewIJc0YK3+oo=
Received: by 10.204.102.76 with SMTP id f12mr5383735bko.137.1248860040934;
        Wed, 29 Jul 2009 02:34:00 -0700 (PDT)
Received: from localhost.localdomain (abvm110.neoplus.adsl.tpnet.pl [83.8.210.110])
        by mx.google.com with ESMTPS id y15sm2074792fkd.47.2009.07.29.02.33.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 02:34:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6T9Xwdc018345;
	Wed, 29 Jul 2009 11:33:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6T9Xw10018342;
	Wed, 29 Jul 2009 11:33:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124338>

Scott Chacon <schacon@gmail.com> writes:

> Just a heads up - I've been working on a book on Git being published
> by Apress called "Pro Git", which is being licensed under a CC 3.0
> license and as I've just finished some of the final reviews, I've put
> the entire content of the book online at:
> 
> http://progit.org
> 
> It should be shipping at the end of August, I think, but I just wanted
> to let people know that there is another resource out there to help
> learn Git.  This one was actually technically edited by Shawn, too, so
> hopefully not too many serious errors of mine got through.
> 
> I've added a link to it on http://git-scm.com under the Books section,
> in case you want to point any newbies there.  Hope this helps take
> some teaching load off some of your plates.

Wonderfull news!  Thanks a lot for publishing it under Creative
Commons (CC-BY-NC-SA 3.0) license for all to see (and improve).

I'll send a few comments later (BTW. would you prefer to have it here,
or private?).  

One comment about on-line version: it might be better to have one
chapter and not one (sub)section per HTML page.  There are some
sections that are not enough to even fill one single page.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
