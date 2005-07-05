From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Add script for patch submission via e-mail.
Date: Tue, 5 Jul 2005 19:39:10 +1000
Message-ID: <2cfc40320507050239605e8d3a@mail.gmail.com>
References: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
	 <20050705093441.GD6191@pasky.ji.cz>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 11:40:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dpjtx-0000LW-ME
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 11:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVGEJjU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 05:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVGEJjU
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 05:39:20 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:62241 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261784AbVGEJjM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 05:39:12 -0400
Received: by rproxy.gmail.com with SMTP id i8so831794rne
        for <git@vger.kernel.org>; Tue, 05 Jul 2005 02:39:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BxHRqogGPyOPhJTA0be512e8qlWBQkqWAprzNEvGuT0KToC8DhIID13DhzQVaOBbFIrgsAiAw8PsmTCdSWrpkX1uS0dTQBKwAoPH9gj57kX2GpZWpkbc5r9d72yPNMIu/sXyC6TZC+/GJm2ahoXtLI6N5/AyrthqO6QwyNlVMWo=
Received: by 10.38.11.27 with SMTP id 27mr3447013rnk;
        Tue, 05 Jul 2005 02:39:10 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Tue, 5 Jul 2005 02:39:10 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050705093441.GD6191@pasky.ji.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 7/5/05, Petr Baudis <pasky@suse.cz> wrote:
> 
> Any reason why this was not applied? It appears kind of cool. Well, I
> will probably take it and extend cg-mkpatch with it so I don't need it
> in Git, but I'm so altruistic and want to bring at least a bit of light
> to the gloomy dark world of the poor core Git plumbing users.  ;-)

As one who inhabits that dark world, I second that!

jon.
