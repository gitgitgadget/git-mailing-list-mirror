From: Paul Gardiner <osronline@glidos.net>
Subject: Re: Best way to specify all local branches and all remote branches.
Date: Mon, 11 Feb 2008 21:00:37 +0000
Message-ID: <47B0B775.1050401@glidos.net>
References: <47B09921.2070109@glidos.net> <m3ir0ve2c1.fsf@localhost.localdomain> <alpine.LSU.1.00.0802112022560.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 22:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOfmB-0003Bx-Um
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 22:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753438AbYBKVAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 16:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753416AbYBKVAn
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 16:00:43 -0500
Received: from mk-outboundfilter-1.mail.uk.tiscali.com ([212.74.114.37]:42416
	"EHLO mk-outboundfilter-1.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753111AbYBKVAm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Feb 2008 16:00:42 -0500
X-Trace: 38717725/mk-outboundfilter-1.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.31
X-SBRS: None
X-RemoteIP: 62.241.162.31
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAGpFsEc+8aIf/2dsb2JhbACqHQ
X-IP-Direction: IN
Received: from galaxy.systems.pipex.net ([62.241.162.31])
  by smtp.pipex.tiscali.co.uk with ESMTP; 11 Feb 2008 21:00:40 +0000
Received: from [10.0.0.24] (81-86-57-226.dsl.pipex.com [81.86.57.226])
	by galaxy.systems.pipex.net (Postfix) with ESMTP id C845FE000087
	for <git@vger.kernel.org>; Mon, 11 Feb 2008 21:00:38 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802112022560.3870@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73582>

Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 11 Feb 2008, Jakub Narebski wrote:
> 
>> git-filter-branch is about single branch;
> 
> No.
> 
>> I'm not sure if it should support --all.
> 
> It does.

Yep, it does. I'd forgotten how to drive the shell. It works if
I put -- --all.

Turns out that isn't what I want though. I want just the local
branches. Still can't find a way to do it other than my cd/ls
thing.
