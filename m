From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Review of git multimail
Date: Wed, 3 Jul 2013 16:32:14 +0530
Message-ID: <CALkWK0mCChJtLqDTiaw8Ji6==7Qh9AoBDpkde-siGVUMArpVpA@mail.gmail.com>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com>
 <51D36BD8.1060909@alum.mit.edu> <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 03 13:03:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuKpv-00042m-07
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 13:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab3GCLCz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 07:02:55 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60505 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932066Ab3GCLCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 07:02:54 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so13898806iea.25
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aUsx649xuY01nTMyHCwVKizBJn6VIFOMWSGUkJ60lS8=;
        b=yZaTZR65Uo3rtSaf6HSRDE0zf4ewzwNs6c1Hw7NgPzZtJnnM2CJRcusfmJuh66qdfE
         Ao4QyzhJF4wFbI084EBO3B1UjqK6VDVFTQ9BZL5N3yaqNEd7G5F2dbBIfSz1K8rJmzl+
         gZky9t6QLeseC4cjJU9LKBBpJYIMjv6hVrdOqW1Yaqb9JxY9hBCKdsbftl1/g3+LMET4
         2V1zn+T56EKzjBVdxERqyVeewailbeUQzF0KWFNIV+6e2qaAHMwCdefJxKY53TQ6QSVU
         CLDdgt/TwmnhQokt959gFl3OjwK3rWCS0FJLkNjq5/e0kM4sovpi9Rsz2YTCDQIMQ94W
         VjXg==
X-Received: by 10.42.190.74 with SMTP id dh10mr194666icb.35.1372849374479;
 Wed, 03 Jul 2013 04:02:54 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Wed, 3 Jul 2013 04:02:14 -0700 (PDT)
In-Reply-To: <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229491>

Ramkumar Ramachandra wrote:
>>> New-style class.  I wonder why you suddenly switched.
>>
>> ?  All of the classes are new-style classes.
>
> When you say class Foo:, aren't you declaring an old-style class by
> default in python2?  New-style classes are those that explicitly
> inherit from object (implicit in python3).

I just noticed that all your classes are new-style.
