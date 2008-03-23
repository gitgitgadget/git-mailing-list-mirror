From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: List all SHA1 hashes in repo
Date: Sun, 23 Mar 2008 15:21:28 +0100
Message-ID: <7B06FEDE-799E-431B-8F35-C1B6AE40BE8D@ai.rug.nl>
References: <c6c947f60803230617if9606baxea21fa99dc3df37c@mail.gmail.com> <alpine.LSU.1.00.0803231459100.4353@racer.site>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:45:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdRSI-0007gd-MX
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755029AbYCWOoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbYCWOoz
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:44:55 -0400
Received: from frim.nl ([87.230.85.232]:58755 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753279AbYCWOoy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 10:44:54 -0400
X-Greylist: delayed 1397 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Mar 2008 10:44:54 EDT
Received: from ip63-33-210-87.adsl2.versatel.nl ([87.210.33.63] helo=[192.168.1.9])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1JdR4p-0005fv-9n; Sun, 23 Mar 2008 15:21:35 +0100
In-Reply-To: <alpine.LSU.1.00.0803231459100.4353@racer.site>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77912>


On Mar 23, 2008, at 2:59 PM, Johannes Schindelin wrote:
>> The git rev-list --all gives nice list, but, as I understand, that is
>> only commit objects, and there are much more of SHA1 hidden inside.
>
> Just add --objects.

I thought --all --objects only shows reachable objects?

- Pieter

(Dscho, sorry for the double post)
