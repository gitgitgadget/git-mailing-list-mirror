From: Michael J Gruber <drmicha@warpmail.net>
Subject: Re: [PATCH 2/2] Fix behavior with non-committish upstream references
Date: Thu, 14 May 2009 09:51:11 +0200
Message-ID: <4A0BCD6F.70806@warpmail.net>
References: <1242052974-28184-1-git-send-email-git@drmicha.warpmail.net> <1242052974-28184-2-git-send-email-git@drmicha.warpmail.net> <1242052974-28184-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 09:51:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Vj2-0004eR-7G
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 09:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756914AbZENHvT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 03:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755881AbZENHvT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 03:51:19 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57528 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754365AbZENHvS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 03:51:18 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 7CFED343E53;
	Thu, 14 May 2009 03:51:19 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 14 May 2009 03:51:19 -0400
X-Sasl-enc: LLGt3s4++mlspVB1zbJvSBstwH5SjenM/SWZmJCOBrDD 1242287479
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D39FF4E8F;
	Thu, 14 May 2009 03:51:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1242052974-28184-3-git-send-email-git@drmicha.warpmail.net>
X-Enigmail-Version: 0.96a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119168>

Junio,

I'm sorry: While checking pu I noticed that I failed to rewrite the
subject as intended (I did rewrite the commit message body).
"non-committish" should be "non-commit". Feel free to amend or leave as
is, whatever you prefer.

Michael
