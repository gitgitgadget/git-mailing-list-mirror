From: Kevin <ikke@ikke.info>
Subject: Re: Links broken in ref docs.
Date: Tue, 30 Oct 2012 09:04:22 +0100
Message-ID: <CAO54GHBvWoqZRbDwhQnmjGsBLKfGiv-JTpAakrAjiqEXYHHXPQ@mail.gmail.com>
References: <CAJr+XPGm4djBh+vacG5Ff=Y6aYmWbcUXOV9x2jekgnsGsk4b-g@mail.gmail.com>
 <CAH5451nFf_SY4K2DS52vhP6VeXSmeikUrc0zy8HK3xmGgs+UGg@mail.gmail.com>
 <CAJr+XPETQ2Jifns3_dfoB-sLLru2=Jkofb5RrBxLE4Fa9Aqp7A@mail.gmail.com> <CAP2yMaKzLHiqpUtfcNtSFo8aqnbvS9RvCzC-DZvQMBgXvte5jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mike Norman <mknorman@gmail.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	git <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:05:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TT6op-000861-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 09:05:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755992Ab2J3IEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 04:04:49 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61640 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab2J3IEo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 04:04:44 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so4249990wgb.1
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 01:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=X/IE7aaYRrxCY53TWFdbM9IxG0zwAvCIm+ZaJOQCjdk=;
        b=0l/KCZi6gOfHDtzkPx1oBtoDh4EujB3Pn6c0wOMVfuPiZ7pfTPdV7PvQv1BDlUg2mP
         IXATPGu5IRwxsCKp5ZpgF4CxdM7cGsKxnyh6jC4/fmLz/NYrEK0mlXrB5Lh8KBbg1qQj
         vtboSRJJ0bDOIZntzzCcYeYD4FIfYR7E8tVuPoZq6esjmj5vCa07lSkN9mHeyF0F1qhR
         P31oBqd4GeLK5Y5Exb4pzcm5MVmtAl5kynQCrs8k5nd1Eud7JHpiJgoPu1+oNVLveEQG
         UfQS41MEBsm/45ifkagWZp9hHPsF+XnhuXO/EwKEI3FaWsqXNBgZ+M4fj/O7vbrdPEYS
         g4eg==
Received: by 10.216.145.227 with SMTP id p77mr15884184wej.58.1351584282738;
 Tue, 30 Oct 2012 01:04:42 -0700 (PDT)
Received: by 10.227.29.101 with HTTP; Tue, 30 Oct 2012 01:04:22 -0700 (PDT)
In-Reply-To: <CAP2yMaKzLHiqpUtfcNtSFo8aqnbvS9RvCzC-DZvQMBgXvte5jw@mail.gmail.com>
X-Google-Sender-Auth: C5bk8nwPfuphl7bR42pSukflEqw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208684>

Any follow-up on this?

On Tue, Oct 23, 2012 at 7:11 AM, Scott Chacon <schacon@gmail.com> wrote:
>
> So, this is due to the major AWS outage today.  git-scm.com is hosted
> on Heroku and thus on AWS.  Heroku is continuing to bring up their
> database systems in the wake of the massive AWS outage.  Once that is
> back online, git-scm.com will also be back online.
>
> As for the git-fetch issue, we'll look into it once Heroku is back online.
>
> Scott
