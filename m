From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: any info getting a birdview of Git and its test suite?
Date: Sun, 18 Mar 2007 11:57:51 -0400
Message-ID: <CCA1B104-B1AB-45C0-8EFD-B0408E2C5CED@silverinsanity.com>
References: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: F <ff.pptux@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 18 16:58:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSxlf-0003Mb-AP
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 16:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbXCRP54 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 11:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbXCRP54
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 11:57:56 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:40956 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932463AbXCRP5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 11:57:55 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id BDA231FFC02B;
	Sun, 18 Mar 2007 15:57:54 +0000 (UTC)
In-Reply-To: <3b051c1a0703180043n1dec45by90e5cee3393d2b4d@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42501>


On Mar 18, 2007, at 3:43 AM, F wrote:

> So is there any infomation getting a birdview of architecture of  
> Git and
> its test suite? Or the only way is to read the code?

The code is a great place to find out details, but I find it a little  
confusing if you don't have some understanding.  Thankfully, the  
documentation is actually pretty thorough.  And the existing tests  
use the git commands is ways similar to a user, so it's a good way to  
get a grasp.  Any questions about a specific section of git can be  
directed to the list or IRC.  We're a pretty educational bunch (in a  
variety of ways).

~~ Brian
