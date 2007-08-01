From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Git clone error
Date: Wed, 1 Aug 2007 18:37:21 +0200
Message-ID: <846EABB5-19D2-45CA-BD83-4E289DA8508B@zib.de>
References: <C2D5F3B2.2B00%denbuen@sandia.gov> <alpine.LFD.0.999.0708010846360.3582@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Denis Bueno <denbuen@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Aug 01 18:36:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHBm-0005NQ-3U
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 18:36:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbXHAQgn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 12:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbXHAQgm
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 12:36:42 -0400
Received: from mailer.zib.de ([130.73.108.11]:64285 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbXHAQgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2007 12:36:42 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l71GaSE7008706;
	Wed, 1 Aug 2007 18:36:28 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l71GaRsp029083
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 1 Aug 2007 18:36:27 +0200 (MEST)
In-Reply-To: <alpine.LFD.0.999.0708010846360.3582@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54449>


On Aug 1, 2007, at 6:19 PM, Linus Torvalds wrote:

>
> Memory and disk corruption is also a possibility, so running fsck  
> (I have
> *no* idea how you do that under OS X, but I bet others on the list  
> know)
> is a good idea.

AppleJack is the easiest way I know of:

http://applejack.sourceforge.net/


	Steffen
