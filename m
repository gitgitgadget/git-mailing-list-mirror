From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: resolve (merge) problems
Date: Thu, 1 Dec 2005 16:07:15 -0800 (PST)
Message-ID: <20051202000715.8100.qmail@web31810.mail.mud.yahoo.com>
References: <7v3blccqtz.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:09:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhySO-0003pw-J6
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 01:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932568AbVLBAHR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 19:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVLBAHR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 19:07:17 -0500
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:14514 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932568AbVLBAHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 19:07:16 -0500
Received: (qmail 8102 invoked by uid 60001); 2 Dec 2005 00:07:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uunbX5H7hIT8R1NMjX5sJnnykMH3s2kkYvbioebw+AuiQChTc9W6XBMc0lqNlo0u66GBFw9Nv3qy6skogvM4PimgZP1MOZZr1PkthPPSRAR1ayRUYRkLDbnu0S4snEJuyWuo1a1sCfUPO21yPm0i+rKwsqrbhS7GjjfronBPgHc=  ;
Received: from [68.221.13.176] by web31810.mail.mud.yahoo.com via HTTP; Thu, 01 Dec 2005 16:07:15 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v3blccqtz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13089>

--- Junio C Hamano <junkio@cox.net> wrote:
> Easier to read is:
> 
> 	$ git-diff-files --name-status

Ok this is what it shows:

$git-diff-files --name-status
U       arch/arm/configs/poodle_defconfig
D       arch/arm/configs/poodle_defconfig
U       drivers/atm/atmdev_init.c
D       drivers/atm/atmdev_init.c

Unmerged and deleted?  Is this correct?

    Luben
