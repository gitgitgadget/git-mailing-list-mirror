From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Wed, 25 May 2005 10:31:43 +0200
Message-ID: <20050525083143.GA27025@elte.hu>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> <7vekbwru6x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 10:31:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DarHg-0002Og-Qz
	for gcvg-git@gmane.org; Wed, 25 May 2005 10:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVEYIcL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 04:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVEYIcL
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 04:32:11 -0400
Received: from mx1.elte.hu ([157.181.1.137]:9929 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261400AbVEYIcH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 04:32:07 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id B2B3C3233C6;
	Wed, 25 May 2005 10:30:19 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 93B5E1FC2; Wed, 25 May 2005 10:31:54 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org>
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

> Hmm. According to that logic, ">" and ">=" is superfluous.
> 
> Also, what language do you actually speak? Every human language I know 
> (admittedly, apart from Finnish they are all related) tends to say 
> things like "if you have more than four children, you're in trouble", 
> rather than saying "if four is less than the number of children you 
> have".

[ add Hungarian to that short list - there it's a pretty natural thing 
to say "if four is less than the number of ..." in everyday life :-| 
Interestingly, having an insanely complex wacko weird language helps 
kids learn abstraction early, and results in an unusually high per 
capita proportion of scientists. If China adopted Finnish as a second 
language the global domination of the US would be history in 50 years
;-) ]

	Ingo
