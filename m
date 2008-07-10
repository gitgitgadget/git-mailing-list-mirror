From: Stephan Hennig <mailing_list@arcor.de>
Subject: Re: git pull is slow
Date: Thu, 10 Jul 2008 17:45:14 +0200
Message-ID: <48762E8A.7070203@arcor.de>
References: <g5570s$d5m$1@ger.gmane.org> <48762B27.90004@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 17:48:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyO1-0003ce-GY
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527AbYGJPrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757725AbYGJPro
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:47:44 -0400
Received: from main.gmane.org ([80.91.229.2]:59198 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758457AbYGJPrn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:47:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGyMs-0003yF-4v
	for git@vger.kernel.org; Thu, 10 Jul 2008 15:47:38 +0000
Received: from dialin-145-254-066-222.pools.arcor-ip.net ([145.254.66.222])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 15:47:38 +0000
Received: from mailing_list by dialin-145-254-066-222.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 15:47:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-066-222.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
In-Reply-To: <48762B27.90004@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87985>

Johannes Sixt schrieb:
> Stephan Hennig schrieb:
>> I am observing very large data transfers when pulling from the 
>> repository at <URL:http://repo.or.cz/w/wortliste.git>.  This
>> repository contains one 13 MB text file that compressed is roughly
>> 3 MB large.
> 
> Do you by any chance use a http URL to pull? Don't do that. Use git
> protocol.

No, I'm already using git+ssh.

Best regards,
Stephan Hennig
