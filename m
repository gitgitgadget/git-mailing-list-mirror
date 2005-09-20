From: Stefhen Hovland <stefhen.hovland@gmail.com>
Subject: Re: "git pull" on cogito broken?
Date: Tue, 20 Sep 2005 14:41:50 -0400
Message-ID: <7c278d0c050920114178860c9c@mail.gmail.com>
References: <863bnzd2eu.fsf@blue.stonehenge.com>
Reply-To: stefhen.hovland@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 20:44:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHn41-0000Ca-Ji
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 20:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVITSlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 14:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVITSlz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 14:41:55 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:64163 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965067AbVITSly convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2005 14:41:54 -0400
Received: by xproxy.gmail.com with SMTP id s14so17713wxc
        for <git@vger.kernel.org>; Tue, 20 Sep 2005 11:41:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eyJdZS6YH+EahJHVurPowjrXi/1bv1v2yMPxz4ywAw16Wr8qU6s18zS6YTNzkBwSEn8Ma6kI6k6rkTD2fGe0F4Q3xMo+OW7bc80eDfNaDqysZcJ5yCrqfOtr68pcXgYQJc51AmEEKjeRo4MsJRsdxnbz6fDe/ekhIyZyhxakwSc=
Received: by 10.70.16.16 with SMTP id 16mr2091151wxp;
        Tue, 20 Sep 2005 11:41:50 -0700 (PDT)
Received: by 10.70.12.11 with HTTP; Tue, 20 Sep 2005 11:41:50 -0700 (PDT)
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <863bnzd2eu.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9014>

I dont even see the cogito/cogito.git repository availiable like usual
from gitweb, looks like it is missing:

http://www.kernel.org/git

On 20 Sep 2005 11:23:05 -0700, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
> 
> I got this this morning:
> 
>     Fetching refs/heads/master from http://www.kernel.org/pub/scm/cogito/cogito.git using http
>     Getting pack list
>     Getting alternates list
>     error: Unable to find 69ba00668be16e44cae699098694286f703ec61d under http://www.kernel.org/pub/scm/cogito/cogito.git/
> 
>     Cannot obtain needed object 69ba00668be16e44cae699098694286f703ec61d
>     while processing commit 0000000000000000000000000000000000000000.
> 
> Something broken there?
> 
> --
> Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
> <merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
> Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
> See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
