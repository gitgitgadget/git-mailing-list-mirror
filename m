From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 1/3] Documentation: lost-found is now deprecated.
Date: Fri, 9 Nov 2007 02:27:58 +0100
Message-ID: <20071109012758.GB5903@diku.dk>
References: <Pine.LNX.4.64.0711072253580.4362@racer.site> <7vlk998u6r.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711080041120.4362@racer.site> <20071108145435.GA18727@diku.dk> <4733249B.9020504@op5.se> <20071108160114.GB20988@diku.dk> <7vzlxo1mga.fsf@gitster.siamese.dyndns.org> <20071109002001.GB5082@diku.dk> <7v7iksz00j.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIfW-00027z-1s
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbXKIB2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbXKIB2G
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:28:06 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:35002 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754330AbXKIB2F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:28:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id DCD7A19BB06;
	Fri,  9 Nov 2007 02:28:02 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23183-03; Fri,  9 Nov 2007 02:28:01 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 351A619BB0F;
	Fri,  9 Nov 2007 02:27:59 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A92F86DFEEB; Fri,  9 Nov 2007 02:27:37 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id CF5115B8001; Fri,  9 Nov 2007 02:27:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7iksz00j.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64107>

Junio C Hamano <gitster@pobox.com> wrote Thu, Nov 08, 2007:
> This makes it possible to mark commands that are deprecated in the
> command list of the primary manual page git(7), and uses it to
> mark "git lost-found" as deprecated.

How about also marking git-tar-tree as deprecated?

-- 
Jonas Fonseca
