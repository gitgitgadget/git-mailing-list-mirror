From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Mar 2010, #03; Wed, 10)
Date: Fri, 12 Mar 2010 17:40:54 +0100
Message-ID: <201003121740.55042.trast@student.ethz.ch>
References: <7v7hpj4k7w.fsf@alter.siamese.dyndns.org> <201003111209.10445.johan@herland.net> <7v1vfr2h01.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 17:41:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq7vS-00031N-SO
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 17:41:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916Ab0CLQlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 11:41:21 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:36155 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756755Ab0CLQlU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 11:41:20 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 17:41:19 +0100
Received: from thomas.localnet (213.55.131.184) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Fri, 12 Mar
 2010 17:41:01 +0100
User-Agent: KMail/1.13.1 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.1; x86_64; ; )
In-Reply-To: <7v1vfr2h01.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142040>

Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> >> * tr/notes-display (2010-03-10) 13 commits
> >> ...
> >> Re-rolled.  I think this is ready for 'next'.  Comments?
> >
> > I just reviewed it, and it looks good to me.
> 
> Thanks.  There still are a few niggles as you pointed out (e.g. I share
> the feeling that the auto-initialization should go and be replaced with a
> BUG()), but most of them are minor and not showstopper, I think.
> 
> Thomas, I am Ok with a replacement series, or incremental updates on top
> of what we have now.  Please let me know which way you prefer.

I'll send a replacement shortly :-)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
