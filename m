From: Asheesh Laroia <asheesh@asheesh.org>
Subject: Re: 'git gc' always run, on old kernel repo?
Date: Thu, 28 Feb 2008 12:34:39 -0800 (PST)
Message-ID: <alpine.DEB.1.00.0802281233570.30784@alchemy.localdomain>
References: <47C71233.4050705@garzik.org> <47C715EB.3060303@garzik.org> <alpine.DEB.1.00.0802281231060.23558@alchemy.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 21:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUpTX-0004dK-Hs
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 21:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759279AbYB1Uet (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 15:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758862AbYB1Ues
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 15:34:48 -0500
Received: from wide-rose.makesad.us ([203.178.130.147]:52184 "EHLO
	rose.makesad.us" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754096AbYB1Uer (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 15:34:47 -0500
Received: from alchemy (localhost [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rose.makesad.us (Postfix) with ESMTP id 1FCAB3342DD;
	Thu, 28 Feb 2008 15:34:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by alchemy (Postfix) with ESMTP id 3E8FA6EAE2;
	Thu, 28 Feb 2008 12:34:40 -0800 (PST)
X-X-Sender: paulproteus@alchemy.localdomain
In-Reply-To: <alpine.DEB.1.00.0802281231060.23558@alchemy.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75445>

On Thu, 28 Feb 2008, Asheesh Laroia wrote:

> On Thu, 28 Feb 2008, Jeff Garzik wrote:
>
>> Will the 'git gc' never end???
>
> sudo ln -sf /usr/bin/git-gc /bin/echo

Er, the other way around.  Must have had too much crack this morning.

*blushes*

-- Asheesh.

-- 
Your boss is a few sandwiches short of a picnic.
