From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: emacs and git...
Date: Fri, 23 Mar 2007 09:32:50 +0100
Message-ID: <38b2ab8a0703230132j64cf0b94x7c210593f3f31387@mail.gmail.com>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	 <86lkhpmftt.fsf@blue.stonehenge.com>
	 <38b2ab8a0703230029h7f3faa95u1e2ccb6a9ee4be5e@mail.gmail.com>
	 <864poch0xl.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 09:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUfD2-00057j-Ob
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 09:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422692AbXCWIcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 04:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422710AbXCWIcz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 04:32:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.236]:11944 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422692AbXCWIcy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 04:32:54 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1181757wxd
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 01:32:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FnOxu6zD8EwNc0VCAb/8yK3Sj1S1hrOGeCL3jpT2EB7uP9YwIflR0LFQujA7O+kJJHrzlZlsBK6UscU2KXgzGx5jO4kixxWZ4velRCsjJy4bJMhQcKtdSU2hKZKqgNJBgd+vit24qa4o1nxk9UlS5lKYwmTWyzaSUdILicmHVOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xpo6ydRQZtPoE1pxNRQuN/62nr6ztZ69xO07oskPsOpo9cR7V+TayXgNwwbG0xK9cAqoTVyZ1g9ZTFwlfGjHR5h/iwkaL89nWPUIZi9OvTFBA8rUWjUiB5YXY0TkDMf02i0514s97++H4AgSZbfUq3swIvvxXcQw0KCZQ7YXy2E=
Received: by 10.115.17.1 with SMTP id u1mr1075792wai.1174638770688;
        Fri, 23 Mar 2007 01:32:50 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Fri, 23 Mar 2007 01:32:50 -0700 (PDT)
In-Reply-To: <864poch0xl.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42912>

On 3/23/07, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> >>>>> "Francis" == Francis Moreau <francis.moro@gmail.com> writes:
>
> Francis> $ PAGE=cat git diff HEAD^
>
> PAGE?  or PAGER?
>

PAGER

But I actually know it doesn't print anything, because I put 'HEAD'
instead of 'HEAD^', sorry for the wrong alert.

Can't git make 'cat' the default pager when run on a dumb terminal ?

thanks
-- 
Francis
