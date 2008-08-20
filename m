From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [bug] pull faulty 'not uptodate'
Date: Wed, 20 Aug 2008 23:29:35 +0200
Message-ID: <EAFC48F0-5512-4A83-B9B2-44FF53319285@ai.rug.nl>
References: <1508D1DF-EDE7-4A64-B354-E2F26578E24D@ai.rug.nl> <7v7iabpejv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 20 23:31:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVvGV-0005QA-85
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 23:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbYHTV3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 17:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYHTV3q
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 17:29:46 -0400
Received: from frim.nl ([87.230.85.232]:53138 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753035AbYHTV3p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Aug 2008 17:29:45 -0400
Received: from 113.25-64-87.adsl-dyn.isp.belgacom.be ([87.64.25.113] helo=[192.168.1.15])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KVvFO-0007kq-Av; Wed, 20 Aug 2008 23:29:42 +0200
In-Reply-To: <7v7iabpejv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93057>


On Aug 20, 2008, at 11:22 PM, Junio C Hamano wrote:
> But I also have to wonder why a git-list regular like you are  
> reporting
> this _long after_ v1.6.0-rc1 was released.  Perhaps this is not  
> really a
> big-deal bug spelled in capital letters like you have on your Subject
> line?

I just noticed it and wanted to report it. I thought the usual way to  
do this is to put [BUG] in the subject line. If that is not the common  
way to report bugs, I'm sorry. I can also downcase it ;)

- Pieter
