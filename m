From: Luke Diamand <luke@diamand.org>
Subject: Re: zealous git convert determined to set up git server
Date: Thu, 15 Sep 2011 21:59:41 +0100
Message-ID: <4E72673D.7040400@diamand.org>
References: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Git List <git@vger.kernel.org>
To: Joshua Stoutenburg <jehoshua02@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 23:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4JAN-0004ka-Pw
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 23:08:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934921Ab1IOVID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 17:08:03 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63339 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934775Ab1IOVIB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 17:08:01 -0400
Received: by wwf22 with SMTP id 22so4205669wwf.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 14:08:00 -0700 (PDT)
Received: by 10.216.157.18 with SMTP id n18mr1545261wek.105.1316120389287;
        Thu, 15 Sep 2011 13:59:49 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id fr18sm9464800wbb.9.2011.09.15.13.59.43
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 13:59:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <CAOZxsTqtW=DD7zFwQLjknJR8g0nnh0WPUPna6_np4bVoGnSntQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181495>

On 15/09/11 12:38, Joshua Stoutenburg wrote:
> Breaking away from previous conversation "Anybody home?"
>
> I totally didn't see "The Git Community Book".  There's no link for it
> where I was looking: http://git-scm.com/documentation
>
> As for setting up a work station, I found a pretty good guide at GitHub:
> Windows: http://help.github.com/win-set-up-git/
> Linux: http://help.github.com/linux-set-up-git/
>
> Question 1: With both "Pro Git" and "The Git Community Book", has
> anybody noticed any major discrepancies between the pdf and online
> versions?  I'd like to place the pdf versions on my mobile device for
> travel reading.
>
> Question 2: It seems gitolite is the popular choice for git user
> management.  Any reason why?

I use it. Seems good to me:

- Very easy to install (might just be apt-get install gitolite)
- Git users don't need to have real user accounts on the server machine
- Can do quite sophisticated things with permissions


>
> Question 3: So, Gitorious is more than just a repository hosting
> website?  It's also an open source repository hosting platform, which
> powers the Gitorious website?  That's pretty cool.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
