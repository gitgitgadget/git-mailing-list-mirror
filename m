From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: change push's refspec behavior to match rev-parse
Date: Sun, 14 Oct 2007 11:04:55 +0200
Message-ID: <3CEDD64B-8E6F-4D95-BEDA-BE7CA2898705@zib.de>
References: <11923520851713-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 11:05:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgzP8-0008Aj-Re
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754644AbXJNJEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 05:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754649AbXJNJEq
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:04:46 -0400
Received: from mailer.zib.de ([130.73.108.11]:58756 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbXJNJEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:04:44 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9E93OHQ026274
	for <git@vger.kernel.org>; Sun, 14 Oct 2007 11:04:43 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db109af.pool.einsundeins.de [77.177.9.175])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9E93Or6022461
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 14 Oct 2007 11:03:24 +0200 (MEST)
In-Reply-To: <11923520851713-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60815>


On Oct 14, 2007, at 10:54 AM, Steffen Prohaska wrote:

>
>
>  [PATCH 1/6] push, send-pack: fix test if remote branch exists for  
> colon-less refspec
>
> 	This is a bug fix that should go to maint. All following patches  
> modifying
>         the push test script require this.
>
>  [PATCH 4/6] push, send-pack: support pushing HEAD to real ref name
>
> 	Requires 1/6.

These two patches got mixed. I'll send updated versions in a minute.

Sorry for the noise,
	Steffen
