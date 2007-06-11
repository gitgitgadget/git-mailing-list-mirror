From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC] Teach diff to imply --find-copies-harder upon -C -C
Date: Mon, 11 Jun 2007 19:05:57 -0400
Message-ID: <7ED453D5-E82E-4C73-9C96-908F3152C26A@silverinsanity.com>
References: <Pine.LNX.4.64.0706112109180.4059@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 01:06:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxsxg-0006Xp-9x
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 01:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbXFKXGJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 19:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbXFKXGJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 19:06:09 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:53568 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752662AbXFKXGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 19:06:08 -0400
Received: from [192.168.1.4] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 36C401FFC048;
	Mon, 11 Jun 2007 23:06:06 +0000 (UTC)
In-Reply-To: <Pine.LNX.4.64.0706112109180.4059@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49897>


On Jun 11, 2007, at 4:12 PM, Johannes Schindelin wrote:

>
> earlier, a second "-C" on the command line had no effect. But since  
> I use
> "--find-copies-harder" quite a bit, and it is so long to type, and  
> I am
> an inherently lazy person, I'd like the second "-C" to be a  
> shortcut for
> "--find-copies-harder".


I like it.  "git-diff -C -C ..." reads "git-diff, find copies.  No  
really, find copies."

~~ Brian
