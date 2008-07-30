From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] Documentation: Remove mentions of git-svnimport.
Date: Wed, 30 Jul 2008 02:44:40 +0200
Message-ID: <F11D5504-5FA1-4FF7-9D53-032D5027EBB9@ai.rug.nl>
References: <1217378299-733-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 02:45:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNzpB-0006TP-BD
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 02:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689AbYG3Aoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 20:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757635AbYG3Aoy
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 20:44:54 -0400
Received: from frim.nl ([87.230.85.232]:41448 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757599AbYG3Aox (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jul 2008 20:44:53 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.244])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KNzo8-00057T-3y; Wed, 30 Jul 2008 02:44:48 +0200
In-Reply-To: <1217378299-733-1-git-send-email-benji@silverinsanity.com>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90718>


On Jul 30, 2008, at 2:38 AM, Brian Gernhardt wrote:

> +respository.  'git-svn' is especially useful when it comes to  
> tracking
> +repositories not organized in the way Subversion developers recommend
> +(trunk, branches, tags directories).

This is of course not true. Git svn is especially useful when branches  
_are_ organized
that way, but other configurations are somewhat supported. This  
comment still refers
to the comparison with svnimport.
