From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 14:26:37 +0200
Message-ID: <8fe92b430710220526i65ecb862ie1037e9d94d93b83@mail.gmail.com>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>
	 <Pine.LNX.4.64.0710130130380.25221@racer.site>
	 <1192827476.4522.93.camel@cacharro.xalalinux.org>
	 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Oct 22 14:26:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjwMt-0002HM-Af
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 14:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828AbXJVM0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 08:26:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751939AbXJVM0k
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 08:26:40 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:30995 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbXJVM0j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 08:26:39 -0400
Received: by nz-out-0506.google.com with SMTP id s18so400224nze
        for <git@vger.kernel.org>; Mon, 22 Oct 2007 05:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=sXMqWLMX0vY/CJlbjjBjvSKHKcBbsRQt5oMcWwfNAjo=;
        b=iMjWoK4L5FNxSeq45cOoMRV6eMjz3u8ej8wq9MDMM8lgZs14pldjCAnBJwB5fKWIQuMnN/2YzPd1K9z26rUt9fTWORvPSfL7Q4pKgwkT1INPnkZ7dMRKCMPgq7459qVhYMoPC2f7GuYW6NIYV6itqHOdQF4DgSNMkNVuCMZuvjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JzZunRGqflHhXLF4HOx8aMs5FX6v7YBECDn8bPIjqPORyjBqaXlHkUaKrt8ysoLt8MQeGywZgjY4fKO+IadFwo3aLq8YCMC4wgrdyqh0gEJfN0evfyZTq/MTBUQo2sKilS6BsBelA0wOVJsscFuZBYKgc2HyPOFxcHI5/OJAHao=
Received: by 10.114.12.9 with SMTP id 9mr5184625wal.1193055997640;
        Mon, 22 Oct 2007 05:26:37 -0700 (PDT)
Received: by 10.114.160.12 with HTTP; Mon, 22 Oct 2007 05:26:37 -0700 (PDT)
In-Reply-To: <471C586A.9030900@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61997>

On 10/22/07, Andreas Ericsson <ae@op5.se> wrote:
[...]
>>>>> On 10/20/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>>>>
>>>>>> Maybe we could group commands into more categories?

> Similarly, it might be helpful to have help topics the gdb way, like
> "git help patches". It's one of those things that people have come to
> expect from a software tool, so perhaps we should humor them? Given gits
> "every help topic is a man-page" idiom, this shouldn't require any real
> technical effort.
>
> Such topics should probably include
> merge/merges/merging - overview of various ways of putting two lines of
> development back together
> patch/patches - how to create, send and apply
> tags/branches/refs - what they are, why they're good, link to merging

Very good idea. It is definitely something that can be worked on.

By the way, what do you think about "spying" version of git, specially
marked release which gathers statistics of porcelain used, with
frequency of its use, and git-sendstats command added in this release?

-- 
Jakub Narebski
