From: sean <seanlkml@sympatico.ca>
Subject: Re: Selecting the minor revs
Date: Mon, 27 Mar 2006 19:18:43 -0500
Message-ID: <BAYC1-PASMTP1277D14C35B0D95512243BAED30@CEZ.ICE>
References: <BAYC1-PASMTP12827905B389678EB07BDAAED30@CEZ.ICE>
	<0e7d01c651fb$fa11ceb0$a100a8c0@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 02:21:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO1xm-0006no-PR
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 02:21:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWC1AVV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 19:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWC1AVV
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 19:21:21 -0500
Received: from bayc1-pasmtp12.bayc1.hotmail.com ([65.54.191.172]:50780 "EHLO
	BAYC1-PASMTP12.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S1751158AbWC1AVV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 19:21:21 -0500
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP12.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 27 Mar 2006 16:26:44 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 9908E644C28;
	Mon, 27 Mar 2006 19:21:19 -0500 (EST)
To: "Greg Lee" <glee@swspec.com>
Message-Id: <20060327191843.15787836.seanlkml@sympatico.ca>
In-Reply-To: <0e7d01c651fb$fa11ceb0$a100a8c0@casabyte.com>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 28 Mar 2006 00:26:44.0765 (UTC) FILETIME=[4AF374D0:01C651FE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 27 Mar 2006 19:10:09 -0500
"Greg Lee" <glee@swspec.com> wrote:

> > If you're interested in the stable-series releases of the 
> > kernel, unfortunately they're not in the git repository.
> 
> As I feared ... I'm curious, why?

Because the stable-series is maintained by people other than Linus.   

They may have their own git tree, i'm not sure.  Even if they don't, 
you could create a stable-series branch and import the patches
into your git repo if it was something you needed often.

Sean
