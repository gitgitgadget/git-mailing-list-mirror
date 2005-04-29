From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: About gitweb.cgi bug
Date: Fri, 29 Apr 2005 17:53:52 +0200
Message-ID: <1114790032.9585.1.camel@localhost.localdomain>
References: <e72f90b8050429062342724335@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 17:50:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRXjh-0005C3-T1
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 17:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVD2PyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 11:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVD2PyE
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 11:54:04 -0400
Received: from soundwarez.org ([217.160.171.123]:64133 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S262127AbVD2Px4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2005 11:53:56 -0400
Received: from dhcp-113.off.vrfy.org (d040074.adsl.hansenet.de [80.171.40.74])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by soundwarez.org (Postfix) with ESMTP id 6CF64283D3;
	Fri, 29 Apr 2005 17:53:52 +0200 (CEST)
To: Tomasz bla Fortuna <tomaszfortuna@gmail.com>
In-Reply-To: <e72f90b8050429062342724335@mail.gmail.com>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-29 at 15:23 +0200, Tomasz bla Fortuna wrote:
>   Hi,
> I've found html injection bug:
> http://www.kernel.org/git/gitweb.cgi?p=%3Cimg%20src=%22http://af.gliwice.pl/p.png%22%3Ecogito%2Fcogito.git;a=log
> May lead to redirection to some pr0n sites using kernel.org address...
> but its nothing.

I've sent a fix for this to the kernel.org master.

Thanks,
Kay

