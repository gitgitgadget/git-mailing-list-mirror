From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [EGIT PATCH Series] Cleanups and javadocs
Date: Tue, 5 Feb 2008 22:47:47 +0100
Message-ID: <200802052247.47744.robin.rosenberg@dewire.com>
References: <1202170534-15788-1-git-send-email-robin.rosenberg@dewire.com> <47A87C26.2070307@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Dave Watson <dwatson@mimvista.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Feb 05 23:06:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMVvT-0002Me-24
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 23:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760191AbYBEWE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 17:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761246AbYBEWE4
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 17:04:56 -0500
Received: from [83.140.172.130] ([83.140.172.130]:29106 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1762578AbYBEWEx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 17:04:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A4379800694;
	Tue,  5 Feb 2008 23:04:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K1MjRkHvOfWQ; Tue,  5 Feb 2008 23:04:51 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 008DE800686;
	Tue,  5 Feb 2008 23:04:50 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47A87C26.2070307@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72704>

tisdagen den 5 februari 2008 skrev Roger C. Soares:
> 
> Robin Rosenberg escreveu:
> > Here is a number of small enhancements that reduce the number of warnings
> > displayed and raises the standard on comments. We now get javadoc comments
> > on all public and protected methods which hopefully will make it slighly
> > easier to get on the train for those interested in helping out with Egit/Jgit.
> >
> > Disabling the else-warning is probably fairly uncontroversial. Disabling some
> > warning about boxing/unboxing of integers might be as might be requiring
> > javadoc comments.
> >
> >   
> Hi Robin,
> 
> [2, 3, 5 and 6] - looks fine to me.
Thanks for looking.

> [1] - What about something like "nothing to be done here" and/or 
> "implementing interface method"?
"Empty" is a marker that the block is *intentionally* empty, which
is the point here.

> [4] - Some typos:
Thanks

-- robin
