From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] format-patch: Add configuration and off switch for --numbered
Date: Sun, 4 Nov 2007 00:54:49 -0400
Message-ID: <C9FC46B6-AF2E-4E61-A272-2C46BFA33641@silverinsanity.com>
References: <20071104033824.GA56097@Hermes.local> <7vejf6vd17.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 04 05:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoXW2-0001TE-0A
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 05:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbXKDEyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 00:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbXKDEyw
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 00:54:52 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:45120 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXKDEyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 00:54:52 -0400
Received: from [192.168.1.5] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 2BCE21FFC12F;
	Sun,  4 Nov 2007 04:54:51 +0000 (UTC)
In-Reply-To: <7vejf6vd17.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63346>


On Nov 4, 2007, at 12:40 AM, Junio C Hamano wrote:

> The change looks good.  Tests needed.

Thought so.  Somebody's not happy.  ;-)

I was going to modify the existing tests for --numbered, but  
discovered that there were none.  Having nothing to start with, I  
didn't add.

That said, I'll try to hack something up.

~~ Brian
