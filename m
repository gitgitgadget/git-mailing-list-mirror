From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 23:34:10 +0100
Message-ID: <20090129223410.GA1465@elte.hu>
References: <49814BA4.6030705@zytor.com> <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:36:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfUL-0006P3-CB
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605AbZA2WeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753689AbZA2WeV
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:34:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60036 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbZA2WeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:34:20 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LSfSd-0000hD-Pi
	from <mingo@elte.hu>; Thu, 29 Jan 2009 23:34:17 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 524AB3E21AA; Thu, 29 Jan 2009 23:34:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107741>


* Junio C Hamano <gitster@pobox.com> wrote:

> But that is just a conjecture from a cursory looking at the current 
> code. I do not remember (or did not know from the beginning) some 
> details of it. And that is why I asked you if "git fsck --full" reports 
> it missing in my earlier response to you.

sorry i did not follow up on that detail. I ran --full yesterday already 
(before we reported this), and besides taking a lot longer to finish it 
reported the same screenful of problems.

Should i send the output of it? (i started it, it will take some time to 
finish)

	Ingo
