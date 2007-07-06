From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Prefer $EMAIL over auto-generated user@hostname.
Date: Fri, 6 Jul 2007 18:23:57 +0200
Message-ID: <81b0412b0707060923j189f876v96b2c5cd92fd1734@mail.gmail.com>
References: <468E59B3.7080007@nrlssc.navy.mil>
	 <20070706151145.GA15341@informatik.uni-freiburg.de>
	 <468E5E31.8040504@nrlssc.navy.mil>
	 <Pine.LNX.4.64.0707061631560.4093@racer.site>
	 <468E64F9.9080805@nrlssc.navy.mil>
	 <81b0412b0707060859u6a1c3a24p4399a71d84038615@mail.gmail.com>
	 <20070706155902.GA17489@snarc.org>
	 <81b0412b0707060922sf0e3c17wcbd55dd65e1c1e14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Brandon Casey" <casey@nrlssc.navy.mil>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=" 
	<ukleinek@informatik.uni-freiburg.de>,
	torvalds@linux-foundation.org, gitster@pobox.com,
	mkraai@beckman.com, madcoder@debian.org, git@vger.kernel.org
To: "Vincent Hanquez" <tab@snarc.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 18:24:04 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6qbD-0001YM-Ec
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 18:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760575AbXGFQYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 12:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760464AbXGFQYA
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 12:24:00 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:3307 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760365AbXGFQX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 12:23:59 -0400
Received: by wx-out-0506.google.com with SMTP id h31so231283wxd
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 09:23:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DSvtY7wahYoY6W6ULf49DByaJ970rPUNRWoA2rZLqJG94gSNJYcXcA0N+LoD5mWW64PaHUhKzcQjZOB7lXjf2bMMc+39+LmJOo0yJDHrHGEYeccvcaik32H0V2fmzadhb1VdUUaB+ceYiUyrSsAfhQEIs6lkuUmKjYr3d/ga+Vg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GSvJvbD3F1Hh/KEDZqzM/J0IkcNREyuFTGsg9+tnVUVI5e+rq/cYIJgXbPfoPPNfon5nRVBkTGj+RUthrB3YFYJBQtLjqAqpg0akILXy0D1DDFV90Pbi/YkCmvHnJExsHIcXqE1r+lu66eWE5Yh7dnvd4vF4YyEfWpUjALD2dig=
Received: by 10.78.56.19 with SMTP id e19mr379762hua.1183739037997;
        Fri, 06 Jul 2007 09:23:57 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Fri, 6 Jul 2007 09:23:57 -0700 (PDT)
In-Reply-To: <81b0412b0707060922sf0e3c17wcbd55dd65e1c1e14@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51773>

On 7/6/07, Alex Riesen <raa.lkml@gmail.com> wrote:
> >
> > tab isn't 8 spaces. a tab is a tab.
>
> Of course. It is used to indent the text to the next position
> which multiple of 8.
>

Oh, damn... Sorry everyone, for that stupid mail.
I meant to answer only to Vincent.
