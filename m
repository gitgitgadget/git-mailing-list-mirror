From: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Mon, 27 Jun 2005 15:51:34 -0400
Message-ID: <20050627195134.GA17107@kvack.org>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org>
	<20050627183118.GB1415@elf.ucw.cz>
	<20050627194031.GK12006@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff Garzik <jgarzik@pobox.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>, mercurial@selenic.com
X-From: mercurial-bounces@selenic.com Mon Jun 27 21:44:07 2005
Return-path: <mercurial-bounces@selenic.com>
Received: from waste.org ([216.27.176.166])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DmzWO-0002XC-8j
	for gcvmd-mercurial@gmane.org; Mon, 27 Jun 2005 21:43:56 +0200
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5RJo7df013699;
	Mon, 27 Jun 2005 14:50:11 -0500
Received: from kanga.kvack.org (kanga.kvack.org [66.96.29.28])
	by waste.org (8.13.4/8.13.4/Debian-3) with ESMTP id j5RJo5qa013685;
	Mon, 27 Jun 2005 14:50:05 -0500
Received: (from localhost user: 'bcrl' uid#63042 fake: STDIN
	(bcrl@kanga.kvack.org)) by kvack.org id <S26622AbVF0Tve>;
	Mon, 27 Jun 2005 15:51:34 -0400
To: Matt Mackall <mpm@selenic.com>
Content-Disposition: inline
In-Reply-To: <20050627194031.GK12006@waste.org>
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: by amavisd-new
X-BeenThere: mercurial@selenic.com
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: mercurial.selenic.com
List-Unsubscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=unsubscribe>
List-Archive: <http://www.selenic.com/pipermail/mercurial>
List-Post: <mailto:mercurial@selenic.com>
List-Help: <mailto:mercurial-request@selenic.com?subject=help>
List-Subscribe: <http://selenic.com/mailman/listinfo/mercurial>,
	<mailto:mercurial-request@selenic.com?subject=subscribe>
Sender: mercurial-bounces@selenic.com
Errors-To: mercurial-bounces@selenic.com

On Mon, Jun 27, 2005 at 12:40:31PM -0700, Matt Mackall wrote:
>  $ export PYTHONPATH=${HOME}/lib/python  # add this to your .bashrc

This needs to be ${HOME}/lib64/python on x86-64.

		-ben
