From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] gitk - Handle MouseWheel events on Windows
Date: Sat, 11 Aug 2007 18:58:06 +0200
Message-ID: <6F740E93-EE08-4CBD-9E8E-1E891D82A30B@zib.de>
References: <1186440352826-git-send-email-mdl123@verizon.net> <11865372352543-git-send-email-mdl123@verizon.net> <11865372381125-git-send-email-mdl123@verizon.net> <46BDAA49.40802@verizon.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 18:58:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJuIG-0006Ru-HY
	for gcvg-git@gmane.org; Sat, 11 Aug 2007 18:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbXHKQ6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbXHKQ6V
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 12:58:21 -0400
Received: from mailer.zib.de ([130.73.108.11]:35044 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbXHKQ6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 12:58:20 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l7BGvMUm016758;
	Sat, 11 Aug 2007 18:57:22 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db1a312.pool.einsundeins.de [77.177.163.18])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l7BGvIYZ027619
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 11 Aug 2007 18:57:18 +0200 (MEST)
In-Reply-To: <46BDAA49.40802@verizon.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55614>


On Aug 11, 2007, at 2:23 PM, Mark Levedahl wrote:

> Ping - any chance of getting these two patches into 1.5.3? They fix  
> a pair of long-standing frustrations for
> Cygwin (and now msys/Windows) users:
>
> [PATCH] gitk - enable selected patch text on Windows
> [PATCH] gitk - Handle MouseWheel events on Windows

Both work for me in msysgit.

Would be really, really nice to have them. Missing copy
text from gitk is a bug in my opinion, which is fixed
by the first patch. Support for MouseWheel is also nice
to have.

	Steffen
