From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [PATCH] gitweb: only display "next" links in logs if there is
 a next page
Date: Wed, 28 May 2008 01:23:19 +0200
Message-ID: <483C97E7.2020504@gmail.com>
References: <1211927470-21170-1-git-send-email-LeWiemann@gmail.com> <7viqwzz6p7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 01:24:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K18Wu-0008W6-7F
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 01:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760071AbYE0XXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 19:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbYE0XXX
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 19:23:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:36500 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760071AbYE0XXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 19:23:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1634612fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=Z3fzngzAeSqer6FH2uR9H1BBHorJLPb5roBjGkbyJS0=;
        b=FOKpBLedJHwVbs4kRubBgeaxokN1UnyJWcPhdAtzILIjp/in5dg7M3xWpmFrr+edeiV0VbAeDpi7XKFMsWZ6VMJsa/RNPMiSXzaJlNw6rF155su+B2lBEkw5ZkEa28F/+XEy+2yIamdyXD/lWAnMrScud+g09wA3ap2ylkYJy+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=YxKSzxEiipq3Jfk2UNoGqJbPgljs5LIoxd21Q7930EvRxH/QNHfnCzCNL/P9LVHdEZPW5+Bldh0khvS/MiWaINy2jikZ7VOb+6C/IWqDW0InSJtG3bZGepWKCgvzJ33lNH4kWPqq6w1jJNiCsla+lfqV+sjptutzz0uMA/SAYXY=
Received: by 10.86.73.7 with SMTP id v7mr350094fga.37.1211930600304;
        Tue, 27 May 2008 16:23:20 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.209.73])
        by mx.google.com with ESMTPS id 12sm16082770fgg.0.2008.05.27.16.23.18
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 16:23:18 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <7viqwzz6p7.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83061>

Junio C Hamano wrote:
> This looks like a no-op hunk,

Argh!  Apologies, I'm new to git and accidentally only sent my second 
commit -- I should've checked more carefully.  I'll re-send the correct 
patch as a follow-up to this email.  Sorry again! :(

Best,

     Lea
