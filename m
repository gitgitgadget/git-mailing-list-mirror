From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [ANNOUNCE] gitkdiff 0.1
Date: Thu, 28 Apr 2005 12:36:55 +0200
Message-ID: <20050428103655.GA14076@elte.hu>
References: <4270711F.7020501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 12:32:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR6JH-0007v8-5p
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 12:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVD1KhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 06:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVD1KhP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 06:37:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25728 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262001AbVD1KhF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 06:37:05 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id C238B31963B;
	Thu, 28 Apr 2005 12:35:42 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 42F101FC2; Thu, 28 Apr 2005 12:37:00 +0200 (CEST)
To: Tejun Heo <htejun@gmail.com>
Content-Disposition: inline
In-Reply-To: <4270711F.7020501@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Tejun Heo <htejun@gmail.com> wrote:

>  Hello, guys.
> 
>  I've hacked tkdiff and made a commit viewing utility.  Just download
> the following tarball and unpack it whereever PATH points to.  It
> assumes that all base git executables are visible via PATH.
> 
>  http://home-tj.org/gitui/files/gitui-200504281405.tar.gz

very nice!

there's only one other utility i'm missing: a tool that does the 
equivalent of 'bk annotate' - and to possibly integrate it with gitkdiff 
and git-viz. That would make 'history browsing' very powerful: to 
flexibly switch between changeset history graph view, annotated file 
view and changeset history within one utility.

	Ingo
