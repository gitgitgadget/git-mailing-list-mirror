From: Jan Hudec <bulb@ucw.cz>
Subject: Re: On running git via proxy
Date: Mon, 10 Dec 2007 21:42:58 +0100
Message-ID: <20071210204258.GC3517@efreet.light.src>
References: <fcf013560712072113s6b41b437t3176412356e258a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Assim Deodia <assim.deodia@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 21:43:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1pTX-0001Jt-89
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 21:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbXLJUnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757022AbXLJUnI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 15:43:08 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:39970 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756818AbXLJUnG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 15:43:06 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id A239A57430;
	Mon, 10 Dec 2007 21:43:05 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id s5dYN+ZUOP+g; Mon, 10 Dec 2007 21:43:01 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 3942E57489;
	Mon, 10 Dec 2007 21:43:01 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J1pSs-0001hg-Gh; Mon, 10 Dec 2007 21:42:58 +0100
Content-Disposition: inline
In-Reply-To: <fcf013560712072113s6b41b437t3176412356e258a6@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67755>

On Sat, Dec 08, 2007 at 10:43:40 +0530, Assim Deodia wrote:
> I am a newbie to git. I am running git on my virtual machine which has
> the internet access via proxy through the host machine.

What exactly do you mean by internet here? Aren't you confusing it with the
web?

> I am unable to configure git to run via proxy. system proxy seems not
> to be working for git..

Depends on what kind of proxy it is. IMAP proxy won't work for git, mainly
because git is not using IMAP.

> Can you please guide me for the same?

Depends on what you want to do.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
