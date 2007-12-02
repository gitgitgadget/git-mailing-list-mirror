From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Sun, 02 Dec 2007 14:41:06 -0800
Message-ID: <7v7ijwu3ct.fsf@gitster.siamese.dyndns.org>
References: <7vk5nwu51x.fsf@gitster.siamese.dyndns.org>
	<m33aukwwtx.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 23:41:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyxVD-0007Gm-Sj
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 23:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXLBWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 17:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbXLBWlL
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 17:41:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41312 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXLBWlK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 17:41:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 28A7E2FA;
	Sun,  2 Dec 2007 17:41:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C31469C362;
	Sun,  2 Dec 2007 17:41:29 -0500 (EST)
In-Reply-To: <m33aukwwtx.fsf@roke.D-201> (Jakub Narebski's message of "Sun, 02
	Dec 2007 14:33:51 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66830>

Jakub Narebski <jnareb@gmail.com> writes:

> Does this mean we should be entering feature freeze?
> Or at least feature freeze for 'master'?

I said "these are not in master but should be before v1.5.4", so master
is not frozen yet in that sense, but on the other hand, I want to stop
taking anything other than I explicitly listed to 'master' from now on.

So please take it as a "rfc feature freeze notice".
