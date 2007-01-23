From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: A trivial question on GIT
Date: Tue, 23 Jan 2007 21:03:25 +0100
Message-ID: <1169582605.1608.92.camel@localhost.localdomain>
References: <a02278b00701231145l31e1be2dpff0930cbc9d6fb6c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 21:04:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9RsW-0005Z9-Ql
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 21:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965480AbXAWUDz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 15:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965482AbXAWUDz
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 15:03:55 -0500
Received: from elephant.oekohosting.ch ([80.74.144.79]:56004 "EHLO
	elephant.oekohosting.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965480AbXAWUDy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 15:03:54 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by elephant.oekohosting.ch (Postfix) with ESMTP id 03C3862C099;
	Tue, 23 Jan 2007 21:03:39 +0100 (CET)
Received: from elephant.oekohosting.ch ([127.0.0.1])
	by localhost (elephant.oekohosting.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16748-07; Tue, 23 Jan 2007 21:03:36 +0100 (CET)
Received: from [192.168.1.7] (190.123.79.83.cust.bluewin.ch [83.79.123.190])
	by elephant.oekohosting.ch (Postfix) with ESMTP id E8EBE62C051;
	Tue, 23 Jan 2007 21:03:35 +0100 (CET)
To: Allexio Ju <allexio.ju@gmail.com>
In-Reply-To: <a02278b00701231145l31e1be2dpff0930cbc9d6fb6c@mail.gmail.com>
X-Mailer: Evolution 2.8.2.1 
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37563>

On Tue, 2007-01-23 at 11:45 -0800, Allexio Ju wrote:
> Hi,
> 
> I have trivial question on GIT.
> I've made local copy of Linus's linux-2.6.git repository with
> following git command,
> ---
> # git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> linux-2.6.git
> ---
> 
> After this, I would like to know how to synchronize local copy and
> keep updated  with Linus's.
> I guess cloning everyday would be bad idea as it is heavy operation.
> Can someone guide me on how to?
> 

Yes, go into the directory and execute git pull

If you want to know more, a good start is http://git.or.cz/

There you'll find links to tutorials and more.

Matthias
