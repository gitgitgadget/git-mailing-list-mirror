From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Thu, 16 Mar 2006 16:27:09 +0200
Message-ID: <20060316162709.6f383f95.tihirvon@gmail.com>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
	<7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
	<20060316075324.GA19650@pfit.vm.bytemark.co.uk>
	<7v64mebxsu.fsf@assigned-by-dhcp.cox.net>
	<slrne1inu0.fr9.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Mar 16 15:25:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJtPs-0006Fy-2z
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 15:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWCPOZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 09:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWCPOZI
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 09:25:08 -0500
Received: from nproxy.gmail.com ([64.233.182.201]:17492 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750999AbWCPOZG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Mar 2006 09:25:06 -0500
Received: by nproxy.gmail.com with SMTP id x29so274324nfb
        for <git@vger.kernel.org>; Thu, 16 Mar 2006 06:25:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OCtwgxKCYEFcsI61BYKoJ+pnTJ0X/JqlqZ1yNcRIHnXnbPzyzbZ34/axI8sNugx9PdZPyAkzkb65VAGI5h+OOcwSgolgoQjvu9FlWXjVgUe0SxhwtlJzouw05OvHJ3cKCHjX8h9WvwP8qJulxweqOoHdNoQ3cJdTEYqSl5Os4D8=
Received: by 10.49.58.18 with SMTP id l18mr833292nfk;
        Thu, 16 Mar 2006 06:25:05 -0800 (PST)
Received: from garlic.home.net ( [82.128.201.160])
        by mx.gmail.com with ESMTP id l27sm3124581nfa.2006.03.16.06.25.04;
        Thu, 16 Mar 2006 06:25:04 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <slrne1inu0.fr9.mdw@metalzone.distorted.org.uk>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17635>

On Thu, 16 Mar 2006 12:53:20 +0000 (UTC)
Mark Wooding <mdw@distorted.org.uk> wrote:

> By the way, am I the only person who /likes/ having all the git-*
> programs on his path?  It makes shell completion work fairly well
> without having to install strange completion scripts which get out of
> date for one thing.

I like git-* for the same reason.  But if git potty had aliases for long
commands then git-* commands would become irrelevant.  Especially
"git co" would be nice.  It even would be faster to type than
git-ch<tab>c<tab>o<tab> ;)

-- 
http://onion.dynserv.net/~timo/
