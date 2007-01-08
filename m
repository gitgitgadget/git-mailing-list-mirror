From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport: skip commits that are too recent
Date: Mon, 8 Jan 2007 15:13:32 +1300
Message-ID: <46a038f90701071813g7b892af1y2cfa620ef2656657@mail.gmail.com>
References: <1168218683853-git-send-email-martin@catalyst.net.nz>
	 <7virfiz3at.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 03:13:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3k1I-0004BQ-Cs
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 03:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbXAHCNe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 21:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030446AbXAHCNe
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 21:13:34 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:29455 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030445AbXAHCNd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 21:13:33 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7873815wxd
        for <git@vger.kernel.org>; Sun, 07 Jan 2007 18:13:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=auCc2Vi8SzNG7JdKy8At+2T0CHTwYG1MKe4abmhsfrPOfBkm4fSV6beRghWG/jfTexchv1PAmFasIrkiJrLkCGEWGxXEUc+NLYfp8TTidTEd4E3FylJ2fzuhM/vkqxNm13V1pcMfVYjoEfqZ7ICxCStOCDXag+jt6Ez28a1wQjQ=
Received: by 10.90.75.10 with SMTP id x10mr1772240aga.1168222413021;
        Sun, 07 Jan 2007 18:13:33 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Sun, 7 Jan 2007 18:13:32 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7virfiz3at.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36222>

On 1/8/07, Junio C Hamano <junkio@cox.net> wrote:
>  Almost immediately
> after that, I do another incremental cvsimport so that I can
> rebase the remainder of my branch on top of what I made public.

That probably means I should have added a
--force-fetch-all-and-i-mean-it flag to override the cautious
behaviour. I'll repost ina few hours, with doco too.

 ...

> Which means that you did not give me a new excuse to take a
> coffee break and work on git stuff instead of my day job project
> to my management but that is Ok.  I'll find other ways ;-).

I'll try harder next time ;-)

cheers


martin
