From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: GPF in index-pack
Date: Sun, 6 Aug 2006 00:22:55 -0400
Message-ID: <9e4733910608052122m7986b04y8eb9c3bbeda5148d@mail.gmail.com>
References: <9e4733910608051805j1192d910hf55393f1dbe1e472@mail.gmail.com>
	 <9e4733910608051944v5af7e552wd6909b9773dd516e@mail.gmail.com>
	 <20060806024858.GC20565@spearce.org>
	 <9e4733910608051958h6144add7td46de70dd8b45a5e@mail.gmail.com>
	 <20060806033222.GD20565@spearce.org>
	 <9e4733910608052100t463e6fb8gba54e4afde1ab19a@mail.gmail.com>
	 <20060806040848.GF20565@spearce.org>
	 <9e4733910608052116u4d58908cj654ea94716b546e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 06:23:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9aAN-0004IK-T6
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 06:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWHFEW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 00:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWHFEW6
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 00:22:58 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:33017 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751520AbWHFEW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 00:22:57 -0400
Received: by nf-out-0910.google.com with SMTP id p46so73270nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 21:22:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g1L+2yULkRGpEVQJaNVn0mhJu0ArYeaV5vwtI6XOMJ12+ZWGFJqsN4UCmOnAU7Z31c2+XLx0TTkafyLk+ZP4lyGTKKGr/zIBcl3Wc/zjGQfv1HGXWkEsIS6hIns6AYuACPUAvSg6VnA+cbz8MzWITtisYFt2fDprulfJ4DeDtgo=
Received: by 10.78.170.17 with SMTP id s17mr1902543hue;
        Sat, 05 Aug 2006 21:22:55 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sat, 5 Aug 2006 21:22:55 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <9e4733910608052116u4d58908cj654ea94716b546e6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24963>

I started another run and added code to record the object_names. I can
use the sort utilities then to figure out how many duplicates there
are. It takes two hours for the run to finish so I won't have results
until tomorrow.

-- 
Jon Smirl
jonsmirl@gmail.com
