From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Is the stgit project still alive?
Date: Wed, 28 Jan 2009 10:37:35 +0000
Message-ID: <b0943d9e0901280237g2d6b1533ha5b42dfa77596bfa@mail.gmail.com>
References: <20090128-041237.sv13413.72217@gna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: J Robert Ray <jrobertray@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 11:39:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS7p2-0007Ys-KL
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 11:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbZA1Khj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 05:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbZA1Khj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 05:37:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:16543 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751453AbZA1Khi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 05:37:38 -0500
Received: by fg-out-1718.google.com with SMTP id 13so502538fge.17
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 02:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c8NxFv5OQHh1imHw0A6csboOk/kMvPWuqCNsayAuVxo=;
        b=oHjsEmreBddMTralJKw74DBmX9u2wwGM5N+u+WrMRvvHK8FZO89rgZpkiqJw0dpX1A
         +B3oURqPW5NVWfIJQFhQyKI6OOg6keocfGgpoyGbVw3vJsdw6rSU0t3BVXTtvfdFwi3J
         xgfodQuKhqCnflH3dSRtU1JCd3LqCipAz8o1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ky7PRH/h2P+XhfX1y9nPvStasrgAZRRca0/FsVK1607lUG2m0VuT/W77p+j8iXvrxd
         B4jc4W2Fo9Mw9TuVBrkS9RRspmiZ6xiG0vikQPRRHupUVBCV7zf1tGCpYSFD7egC2+16
         Abe0igQjODIsE34k43TNYTFpPgMyZ0uU4T43A=
Received: by 10.223.113.195 with SMTP id b3mr973427faq.79.1233139056025; Wed, 
	28 Jan 2009 02:37:36 -0800 (PST)
In-Reply-To: <20090128-041237.sv13413.72217@gna.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107524>

(I cc'ed the git list as well for the information)

2009/1/28 J Robert Ray <jrobertray@gmail.com>:
> The project website appears to have died.

I noticed this as well. I was hosting the website at freezend.com and
they seem to have problems:

http://www.freewebspace.net/forums/showthread.php?p=1049536

I moved it somewhere else yesterday and http://www.procode.org/ works
now but I still have to transfer the StGit files as well, sometime
this week.

The project page is fine - https://gna.org/projects/stgit/ - and
developing activity going on (I was just too busy to fix some of the
bugs logged and release a new version;we'll hopefully get one in
February).

-- 
Catalin
