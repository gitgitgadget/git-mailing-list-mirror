From: Soham Mehta <soham@box.net>
Subject: post-rebase hook (correction from Re: post-update hook)
Date: Sun, 07 Jun 2009 06:40:55 -0700
Message-ID: <4A2BC367.7020309@box.net>
References: <4A2BC306.3000001@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 16:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDJ1D-0007jL-7L
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 16:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbZFGOGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 10:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752466AbZFGOG2
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 10:06:28 -0400
Received: from mailrelay.ve.box.net ([209.249.140.142]:63807 "EHLO
	corpmail.ve.box.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751680AbZFGOG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 10:06:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by corpmail.ve.box.net (Postfix) with ESMTP id A26373B1891
	for <git@vger.kernel.org>; Sun,  7 Jun 2009 06:41:00 -0700 (PDT)
X-Virus-Scanned: amavisd-new at box.net
Received: from corpmail.ve.box.net ([127.0.0.1])
	by localhost (mail.box.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id knOUR0cOp1qI for <git@vger.kernel.org>;
	Sun,  7 Jun 2009 06:41:00 -0700 (PDT)
Received: from [192.168.1.67] (host86-159-220-197.range86-159.btcentralplus.com [86.159.220.197])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by corpmail.ve.box.net (Postfix) with ESMTP id F00BD3B1890
	for <git@vger.kernel.org>; Sun,  7 Jun 2009 06:40:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <4A2BC306.3000001@box.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120972>

Oops, I meant post-rebase hook

thus spake Soham Mehta , On 6/7/2009 6:39 AM:
> Wondering why there isn't a post-update (post-reset, post-cherrypick 
> etc) hook in git? Is it only a matter of creating one, or is there a 
> reason?
>
> Thanks.
> -Soham
>
>
