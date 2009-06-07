From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH v2] add a test case for threaded mails without chain-reply-to
Date: Sun, 7 Jun 2009 19:18:20 +0200
Message-ID: <200906071918.21241.markus.heidelberg@web.de>
References: <1244388019-12763-1-git-send-email-markus.heidelberg@web.de> <1244394750-30189-1-git-send-email-markus.heidelberg@web.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 19:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDM0w-0002rF-J7
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 19:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690AbZFGRSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 13:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754328AbZFGRSU
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 13:18:20 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:41670 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029AbZFGRSU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 13:18:20 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate03.web.de (Postfix) with ESMTP id 30D11FEFE860;
	Sun,  7 Jun 2009 19:18:22 +0200 (CEST)
Received: from [89.59.87.118] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MDM0j-0002TD-00; Sun, 07 Jun 2009 19:18:22 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <1244394750-30189-1-git-send-email-markus.heidelberg@web.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/boRG2MFAygA9L4c1NNU0wGa9Wc04bsfOHacjU
	wTAJkS/KdVZrxwZuNCRQf65eZlTfM5vQCnp9kn71VK7eas9pb+
	RXjhv4l9FpKYLZAs8mag==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120988>

Markus Heidelberg, 07.06.2009:
> ---
> 
> --nochain-reply-to instead of
> --no-chain-reply-to
> 
> see commits 3fee1fe8 and 84eeb687:
> t9001: use older Getopt::Long boolean prefix '--no' rather than '--no-'
> 
>  t/t9001-send-email.sh |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)

Ah, the subject should have been [PATCH v2 1/2] and there should have
been a Signed-Off. I'll resend cleanly with some more patches in a
series shortly (I guess :))
