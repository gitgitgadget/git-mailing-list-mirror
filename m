From: Sean <seanlkml@sympatico.ca>
Subject: Re: Local clone/fetch with cogito is glacial
Date: Sun, 21 May 2006 21:20:26 -0400
Message-ID: <BAYC1-PASMTP11FDE05B530CFF43C043E5AE9A0@CEZ.ICE>
References: <4470FC21.6010104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 03:26:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhzBe-00040J-Vx
	for gcvg-git@gmane.org; Mon, 22 May 2006 03:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWEVB0U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 May 2006 21:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWEVB0U
	(ORCPT <rfc822;git-outgoing>); Sun, 21 May 2006 21:26:20 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:35793 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932384AbWEVB0U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 May 2006 21:26:20 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 21 May 2006 18:31:10 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 291FF644C28;
	Sun, 21 May 2006 21:26:18 -0400 (EDT)
To: "H. Peter Anvin" <hpa@zytor.com>
Message-Id: <20060521212026.22f36e03.seanlkml@sympatico.ca>
In-Reply-To: <4470FC21.6010104@zytor.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 22 May 2006 01:31:10.0421 (UTC) FILETIME=[67C80050:01C67D3F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 21 May 2006 16:47:45 -0700
"H. Peter Anvin" <hpa@zytor.com> wrote:

> It appears that doing a *local* -- meaning using a file path or file URL 
> -- clone or fetch with cogito is just glacial when the repository has an 
> even moderate number of tags (and it's fetching the tags that takes all 
> the time.)  That's a really serious problem for me.
> 

Peter, does git clone work acceptably for you?

Sean
