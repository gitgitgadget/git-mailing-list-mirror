From: Ingo Molnar <mingo@elte.hu>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 12:04:45 +0200
Message-ID: <20050420100445.GA25477@elte.hu>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com> <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com> <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com> <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 12:01:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOC0x-0008P1-Bh
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 12:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVDTKFK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 06:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVDTKFK
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 06:05:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:19100 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261328AbVDTKFG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 06:05:06 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 49C85319028;
	Wed, 20 Apr 2005 12:03:52 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 38F811FC2; Wed, 20 Apr 2005 12:04:53 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
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


* Linus Torvalds <torvalds@osdl.org> wrote:

> So to convert your old git setup to a new git setup, do the following:
> [...]

did this for two repositories (git and kernel-git), it works as 
advertised.

	Ingo
