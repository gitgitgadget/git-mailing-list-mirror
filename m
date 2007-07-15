From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Questions about git-fast-import for cvs2svn
Date: Sun, 15 Jul 2007 20:58:39 +0200
Message-ID: <877A33E8-7C61-4E36-BF07-5819914FCE21@zib.de>
References: <469A2B1D.2040107@alum.mit.edu> <20070715120149.3271b736.seanlkml@sympatico.ca> <F06A5876-BA2A-4172-B2D1-BBCFF92C83EF@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jul 15 20:57:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA9Hx-0007Ro-SK
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 20:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbXGOS5q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 14:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbXGOS5q
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 14:57:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:59855 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751646AbXGOS5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 14:57:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l6FIvcMm003970;
	Sun, 15 Jul 2007 20:57:38 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db10151.pool.einsundeins.de [77.177.1.81])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l6FIvbaG028589
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 15 Jul 2007 20:57:38 +0200 (MEST)
In-Reply-To: <F06A5876-BA2A-4172-B2D1-BBCFF92C83EF@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52579>


On Jul 15, 2007, at 8:51 PM, Steffen Prohaska wrote:

> I'm not sure if merges help to solve the situation described by  
> Michael.
> From my understanding the situation is more like starting a branch and
> later 'cherry-picking' commits from various other branches at  
> different
> times. Michael describes a situation where a branch would need to  
> start
> from multiple commits. I think this is different from merging.

[ Hmm.. should have checked my email another time
to avoid the race condition with Linus ...]

	Steffen
