From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash completion: Support "divergence from upstream"
	messages in __git_ps1
Date: Wed, 23 Jun 2010 15:54:57 -0700
Message-ID: <20100623225457.GG14847@spearce.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org> <7veifxe63j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Thu Jun 24 00:55:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORYql-0007f5-W2
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 00:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816Ab0FWWzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 18:55:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:59890 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777Ab0FWWzB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 18:55:01 -0400
Received: by pvg2 with SMTP id 2so100881pvg.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 15:55:00 -0700 (PDT)
Received: by 10.143.86.9 with SMTP id o9mr7913389wfl.303.1277333700045;
        Wed, 23 Jun 2010 15:55:00 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id q10sm4993704rvp.20.2010.06.23.15.54.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 15:54:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7veifxe63j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149555>

Junio C Hamano <gitster@pobox.com> writes:
>
> * tr/rev-list-count (2010-06-17) 2 commits
>  - bash completion: Support "divergence from upstream" messages in __git_ps1
>  - rev-list: introduce --count option
>
> I'd like an Ack/Nack on the tip one from people involved in the completion
> scripts.

Tip commit Acked-by: Shawn O. Pearce <spearce@spearce.org>

-- 
Shawn.
