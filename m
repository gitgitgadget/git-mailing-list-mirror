From: Uwe Storbeck <uwe@ibr.ch>
Subject: Re: [PATCH v2] rebase -i: replace an echo command by printf
Date: Tue, 18 Mar 2014 01:10:55 +0100
Message-ID: <20140318001054.GC1971@ibr.ch>
References: <20140314235642.GA6917@ibr.ch>
 <xmqqa9coeikj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 01:11:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPhcT-0007he-U7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 01:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbaCRAK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 20:10:57 -0400
Received: from gate.ibr.ch ([83.150.36.130]:56717 "EHLO gate.ibr.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbaCRAK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 20:10:57 -0400
Received: from bacardi.ibr.ch (bacardi.ibr.ch [172.16.1.1])
	by gate.ibr.ch (Postfix) with ESMTP id CC48417F5F;
	Tue, 18 Mar 2014 01:10:55 +0100 (CET)
Received: from grappa.ibr.ch (grappa [172.16.8.20])
	by bacardi.ibr.ch (Postfix) with ESMTP
	id E73B4153F6; Tue, 18 Mar 2014 01:10:54 +0100 (CET)
Received: by grappa.ibr.ch (Postfix, from userid 1111)
	id 43BFDD0895; Tue, 18 Mar 2014 01:10:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqa9coeikj.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244314>

On Mar 17, Junio C Hamano wrote:
> Will tentatively queue with the above rewrite, but if you feel
> strongly, please send an replacement.

No need for a replacement, your wording is good. I couldn't do
it better.

I'll borrow your commit message for my other patch to fix the
continued title there too. If you already have queued and
rewritten that patch you may keep your version.

Thanks

Uwe
