From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 16:56:38 +0100
Message-ID: <81b0412b0701230756l72066207o920b008554a70f12@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
	 <Pine.LNX.4.64.0701220823260.32200@woody.linux-foundation.org>
	 <Pine.LNX.4.63.0701231220470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0701230736180.32200@woody.linux-foundation.org>
	 <81b0412b0701230745g4b18747ep73d37674a969c1aa@mail.gmail.com>
	 <Pine.LNX.4.63.0701231650560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 16:56:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9O0r-0006ml-1R
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 16:56:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbXAWP4m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 10:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932861AbXAWP4m
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 10:56:42 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:11295 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932793AbXAWP4l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 10:56:41 -0500
Received: by wr-out-0506.google.com with SMTP id 70so1120308wra
        for <git@vger.kernel.org>; Tue, 23 Jan 2007 07:56:41 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YgOppg0mouqaCfdIwJLCvXq6lzB1XIEtQylqsMAslKUkiJmO8hMmEI71O517/UfMNBWfQIUAliwLA2mBbuJ4Jmb6QHpoCB0KyrydGBa9gG+Upa5zvtsE6Us6KtvQf7xRYYHkFmNxy/DdnUAl9VAwwVyl8MxbnwW2aDJwTDCQhC8=
Received: by 10.78.180.18 with SMTP id c18mr430426huf.1169567798571;
        Tue, 23 Jan 2007 07:56:38 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Tue, 23 Jan 2007 07:56:38 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701231650560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37540>

On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I tried to run installers under Wine: nothing worked until the
> > not-to-be-mentioned parts (ok, the whole "Windows" and "Program Files"
> > directories from an existing installation) were provided. I didn't tried
> > cygwin, though.
>
> Since when did you not check? According to Wine's git commit messages
> (yeah!) they worked really hard to get installers going.
>

Since quite a while (some months), I must admit. Have you tried it?
