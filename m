From: Stefan Beller <sbeller@google.com>
Subject: Re: GSoC 2016: applications open, deadline = Fri, 19/2
Date: Wed, 10 Feb 2016 09:44:07 -0800
Message-ID: <CAGZ79kbSrUv4d5wZgeGh7BY1KCr35YRZ+uWb-ADoHmNS86WHTQ@mail.gmail.com>
References: <vpqoabox66p.fsf@anie.imag.fr>
	<alpine.DEB.2.20.1602101208550.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 10 18:44:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTYoI-000663-5m
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 18:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbcBJRoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 12:44:09 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36559 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbcBJRoI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 12:44:08 -0500
Received: by mail-ig0-f172.google.com with SMTP id xg9so18843966igb.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 09:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=JapYUkxUAw9Xwx6CR4EiI+avv9lXcDi26vwnzH0FCLs=;
        b=YuZ5CfoJbavXX3/vZ7CMu3mVdGB1iOjN974Ky+wxPQtPnWnd77gYW/lRw4W23UmRQW
         rl5L8+6zYpBg3QtE8J3VL6crQbPO4hA9Do/FQu6q18tVlBFmlp+LUhylQcsxqRy2wwn8
         6m4TMJbb2MkyHbgRz4pt69GUDsYO8Z7I3LLg0mt6QCkOWO+GD/YzEJWhEA+f3ZOz+3/k
         r9cJC/q23yPCoBAqcO55sAYMWbLXzFaSka7YzRVK8IuMDETdxjtcsIXQ6SS3ShY26fjP
         pKAh7h1G3aePRATwqvftwIssHj/IVRIuJMBhua+ci4GKgB9hdVdZXM5Mu2u+f9Epmgj4
         iCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=JapYUkxUAw9Xwx6CR4EiI+avv9lXcDi26vwnzH0FCLs=;
        b=PeZ87yypTgUNp6TaLKIvk3sxUeWCFRuv8VFr+VCpzqZSXQ4caXouBF2PZZkIriYpug
         zcXXVbV7KsB0vEdvZEWO+WwlR9ANernlpGxMQakEthjvkkdGWUDSlYHoyWZ7326P7t/5
         M9shXtLf/95xu4eBB/xCrBy6LhjCQ7/PC/8Vhk9hasqjXWHE94UM4EknHTo2UMiTzlAU
         3EMuxcFKHIRo6T40xul+Ie/brJYha2i1PwAP8ZCAjXIX8nh9j2I0RT33FNRb0Cp1tPii
         rGxMEGTgeYMFCNlawD47j7x5R1kpWSzjwoa1jgRxqkhkqc4xCASNAFTfZSsxMr6/nyJo
         5ZkQ==
X-Gm-Message-State: AG10YORjvvRuMrpiLHzBeQ2v3qEmwH3ciyf4GhCMQfUsmN4DzbPeTe2rB7v/6vjLYkUY2xOox37fCm6aB/E0P+MO
X-Received: by 10.50.138.76 with SMTP id qo12mr11588618igb.85.1455126247797;
 Wed, 10 Feb 2016 09:44:07 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Wed, 10 Feb 2016 09:44:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602101208550.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285917>

On Wed, Feb 10, 2016 at 3:09 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Matthieu,
>
> On Wed, 10 Feb 2016, Matthieu Moy wrote:
>
>> I think participating is a good thing, but it needs mentors, ie. people
>> and time.

I am people and I have time! ;)

>
> I am available for mentoring. Stefan, it was really fun to co-mentor with
> you, would you be willing to repeat the exercise?

Sure thing.

>
> Ciao,
> Dscho
