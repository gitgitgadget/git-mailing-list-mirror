From: Santi <sbejar@gmail.com>
Subject: Re: [PATCH] branch: write branch properties
Date: Sat, 30 Sep 2006 00:47:46 +0200
Message-ID: <8aa486160609291547y583b01fdvd6ba6b0e031d19b@mail.gmail.com>
References: <87r6y06g5h.fsf@gmail.com> <877izs98eu.fsf@gmail.com>
	 <87d59kok0l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 30 00:47:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTR95-0008G1-Cj
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 00:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWI2Wrr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 18:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWI2Wrr
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 18:47:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:26542 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932147AbWI2Wrq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 18:47:46 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1083506wxc
        for <git@vger.kernel.org>; Fri, 29 Sep 2006 15:47:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gFYTIjeq6aRMnGfO39ktSmvpy9yjzkWuvYeuNV1GjCJhU8uBjEsU1aIVIttD1n+v5gNzIxIRjIxqJ+tyGspPv6Gb8AXweuX6LrdicFOyVVyIFTmbR4kOfVCA4YzR9QoM1znYnAY7rf3YCJi8jXPEzPdkRZ/4asJ5CsCGb9UWADM=
Received: by 10.70.52.1 with SMTP id z1mr1296226wxz;
        Fri, 29 Sep 2006 15:47:46 -0700 (PDT)
Received: by 10.70.19.6 with HTTP; Fri, 29 Sep 2006 15:47:46 -0700 (PDT)
To: git <git@vger.kernel.org>
In-Reply-To: <87d59kok0l.fsf@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28135>

> [PATCH] branch: write branch properties
>
> If you want to work in the 'next' branch of git.git:
>
> $ git clone --use-separate-remote git://git.kernel.org/pub/scm/git/git.git
> $ cd git
> $ git branch next origin refs/heads/next
> ... work/edit/commit ...
> $ git pull
>
> and it merges from branch 'refs/heads/next' of origin.
>

Any comments on this?

Possible comments :D
- No comments
- Not interested
- Not interesting
- I like the idea but not the patch because...
- I like the patch but not the idea (?)
- Broken syntax. Could be done in this other way...
- Stop all this crazy things, just config all this manually!
- Start more crazy things, like...
- ...

  Santi
