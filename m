From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Wed, 2 Nov 2005 12:33:38 +1300
Message-ID: <46a038f90511011533q177328fdrf4b0dd68f188282e@mail.gmail.com>
References: <20051027203945.GC1622@pe.Belkin> <20051028015642.GA31822@vrfy.org>
	 <20051028023833.GA19939@pe.Belkin> <20051101233035.GB1431@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Chris Shoemaker <c.shoemaker@cox.net>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 00:35:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX5dP-0005Fi-6p
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 00:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbVKAXdk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 18:33:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbVKAXdj
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 18:33:39 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:25978 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751439AbVKAXdj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 18:33:39 -0500
Received: by xproxy.gmail.com with SMTP id t5so3307wxc
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 15:33:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=noeByzoij1pTHVNdEmBlQh86QratLFCktXGqHh3MAYLqBuXRz8clwH283Xkh4YDV+LxHHzZnFxJGZOg8yk9SRYgsPv5ziVSGjpdue8MmMRAHXOF+UPLnOUqwgbqIqaZAn9QTf+IFIIXqcug6IfI2IjLzZfve+ksbU4yrX/rpYz0=
Received: by 10.65.22.10 with SMTP id z10mr1486391qbi;
        Tue, 01 Nov 2005 15:33:38 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Tue, 1 Nov 2005 15:33:38 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051101233035.GB1431@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10971>

On 11/2/05, Petr Baudis <pasky@suse.cz> wrote:
> What about having the color indicate the number of affected files (let's
> say on a blue..red scale) and the width the size of patch?

I'm a /little bit/ colour blind on the red scale -- so I vote for 2
bars, each half the heigth of the current bar.  ;-)

martin
