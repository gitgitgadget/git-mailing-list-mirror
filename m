From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Mon, 22 Jan 2007 23:25:57 +0100
Message-ID: <46d6db660701221425i672e826coc9eef4bd8d22ae9d@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 23:26:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H97cC-0004N6-3i
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 23:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbXAVW0H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 17:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbXAVW0H
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 17:26:07 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:34308 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932544AbXAVW0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 17:26:06 -0500
Received: by an-out-0708.google.com with SMTP id b33so488516ana
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 14:26:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PyRUQ82MF5984F8NFfCtvtuvzykJi2WCeYHFQFIdAwPnPSLOPYsPvA3g5D688GlYH1o6ekN3X2a42tXko4PjU9zDqcNOcZXEtqJQoLPzqWtBxb9wY0ABkneisDKgLhYGsaALlxEAu84TwfVacMO/RYEU5xbFclFxA7U07cu0BKI=
Received: by 10.48.217.11 with SMTP id p11mr73131nfg.1169504757354;
        Mon, 22 Jan 2007 14:25:57 -0800 (PST)
Received: by 10.78.183.8 with HTTP; Mon, 22 Jan 2007 14:25:56 -0800 (PST)
To: "Linus Torvalds" <torvalds@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37464>

On 1/22/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Anyway. I have no idea of Windows or MinGW, or what you did to make it all
> compile, so..
>
>                 Linus
>

thanks Linus for your suggestions. the kudos for making it work go to
Johannes Sixt and Johannes Schindelin!

the only recent alternative on Windows I came with was to run git
through coLinux and share directories using cofs.

now I can use the "content tracker from Hell" on Windows. :)

--
Christian
