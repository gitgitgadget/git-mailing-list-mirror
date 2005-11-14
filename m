From: Franck <vagabon.xyz@gmail.com>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 15:13:01 +0100
Message-ID: <cda58cb80511140613s51676f8eu@mail.gmail.com>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>
	 <437870AF.8060607@op5.se>
	 <cda58cb80511140322v686e4ee0g@mail.gmail.com>
	 <43787831.3030404@op5.se>
	 <cda58cb80511140355q1add0ba5n@mail.gmail.com>
	 <Pine.LNX.4.63.0511141442310.8531@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 15:15:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebf5A-0001ar-TP
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 15:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbVKNOND (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 09:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVKNOND
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 09:13:03 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:49814 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751130AbVKNONB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 09:13:01 -0500
Received: by zproxy.gmail.com with SMTP id 14so1276784nzn
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 06:13:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QabjjYC7aCukr+6HmBLJ6afYaqEj4AjIe28dcuaNZlU45Pzt6uNRcRxl0sB2jVCs+3jWPi+UK/0lfMa7LMX7IWy8G/HTdyux6Kcc5eqDpU5FRUfK+3lrP/ATRxkn0zTzZpBdPGlls1G8FhOginN5/jlW9ZCrgYGxogFcJNuCd8Q=
Received: by 10.36.101.20 with SMTP id y20mr4157476nzb;
        Mon, 14 Nov 2005 06:13:01 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Mon, 14 Nov 2005 06:13:01 -0800 (PST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0511141442310.8531@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11800>

Hi Johannes

2005/11/14, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> Hi,
>
> On Mon, 14 Nov 2005, Franck wrote:
>
> > nope every commands I'm running are not run as root. $HOME/bin is in my
> > path.
>
> Is it possible that your wish is stripping away $HOME/bin from your PATH?
> Could you try the following?
>
>         $ wish
>         % git-rev-list
>

That's what I'm thinking too, but what you suggested is failing as
well (I added HEAD parameter to giv-rev-list command thought).

thanks
--
               Franck
