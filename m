From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t3200 (branch): modernize style
Date: Thu, 21 Mar 2013 01:27:35 +0530
Message-ID: <CALkWK0nNjvtomirbQ5D5CqL3c2gRwmp5KcDfbGz6DrF7tkwspw@mail.gmail.com>
References: <1363782612-19260-1-git-send-email-artagnon@gmail.com> <CAPig+cSAzCM893kunUO=FM5Qh0-+5YON1KfbG4rUiDjZ8CvV4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 20:58:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIP9T-0007GK-CG
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 20:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757851Ab3CTT54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 15:57:56 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:47245 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab3CTT54 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 15:57:56 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so2606195ieb.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=HD59QEVXzqBKwiDZ2GqmHBYneZY4vQCXIKTPkvg56cE=;
        b=Sao7afKfZi3BnSPs5T8Ep9/4CzA9YaslBiYv8u+qX3SzQZyuMvtUT6zmhmt2zTCP+e
         H0Kh1n1a1GhJKQR06gey8AeYj9X/o0u8szyCL3Pe1hWJbTHIci0urpvNCNJcPH512mDD
         59Ct/p1DjXhVPS2sflUSPXI2qQBtrh70A74YY42quYqDIf8h8QJoSi55N0XwdD4sNl1V
         vRXOIzlbCNqpfj3MoyR0DXZHEMRK4WRMPjFpdmpWWtrwiT6sLkR26fztWbpC8r8gO+Sm
         AUVpOLJXGcNfXmbrXnNtZYh+m4qyh/3J97ccxlYAjeJ32oSoYhDh4SQZxUg5pzUsAhVF
         jsvw==
X-Received: by 10.50.17.71 with SMTP id m7mr303148igd.14.1363809475728; Wed,
 20 Mar 2013 12:57:55 -0700 (PDT)
Received: by 10.64.166.33 with HTTP; Wed, 20 Mar 2013 12:57:35 -0700 (PDT)
In-Reply-To: <CAPig+cSAzCM893kunUO=FM5Qh0-+5YON1KfbG4rUiDjZ8CvV4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218671>

Eric Sunshine wrote:
> On Wed, Mar 20, 2013 at 8:30 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Style is inconsistent throughout the file.  Make the following
>> changes:
>>
>> 1. Indent everything with tabs.
>>
>> 2. Put the opening quote (') for the test in the same line as
>>    test_expect_succcess, and the closing quote on a line by itself.
>
> s/succcess/success/

Thanks, much appreciated.  I really need to set up some Flyspell hooks.
