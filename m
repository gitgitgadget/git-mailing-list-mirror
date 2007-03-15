From: Bill Lear <rael@zopyra.com>
Subject: Re: git protocol over port-forwarding
Date: Wed, 14 Mar 2007 19:32:52 -0600
Message-ID: <17912.41540.361226.683146@lisa.zopyra.com>
References: <17912.16608.852664.321837@lisa.zopyra.com>
	<Pine.LNX.4.64.0703142057300.25422@beast.quantumfyre.co.uk>
	<17912.29057.435478.123662@lisa.zopyra.com>
	<46a038f90703141514q5273e493r87f0ac7f52c1c216@mail.gmail.com>
	<et9vkm$2j4$1@sea.gmane.org>
	<17912.38000.404237.850492@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 15 02:32:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRepr-0002I8-Mt
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 02:32:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXCOBcx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 21:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbXCOBcx
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 21:32:53 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61979 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751964AbXCOBcw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 21:32:52 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l2F1WqT06636;
	Wed, 14 Mar 2007 19:32:52 -0600
In-Reply-To: <17912.38000.404237.850492@lisa.zopyra.com>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42269>

On Wednesday, March 14, 2007 at 18:33:52 (-0600) Bill Lear writes:
>On Thursday, March 15, 2007 at 00:14:32 (+0100) Jakub Narebski writes:
>>...
>>I think it could be done but with _two_ port forwarding, one from git
>>port to ssh port or 5700 port, on your computer (probably reverse tunnel),
>>second from 5700 port to git port... unless you configure git server
>>to use different port...
>
>Ok thanks to all, Jakub, Martin, Julian, for the comments.  I'll
>go give our ssh "expert" hell.

Just wanted to confirm to all that our expert confessed that he had
fat-fingered something (I promise, it wasn't me), and now it works
perfectly.

Thanks again.


Bill
