From: lamikr <lamikr@cc.jyu.fi>
Subject: Re: Any news on an Eclipse plugin?
Date: Sun, 12 Mar 2006 21:50:35 +0200
Message-ID: <44147B8B.4050503@cc.jyu.fi>
References: <20060306173229.GA27965@spearce.org> <440D2F4E.9090009@peralex.com>
Reply-To: lamikr@cc.jyu.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 12 21:20:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIWbO-00017z-SD
	for gcvg-git@gmane.org; Sun, 12 Mar 2006 20:51:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCLTvf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Mar 2006 14:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWCLTvf
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Mar 2006 14:51:35 -0500
Received: from posti5.jyu.fi ([130.234.4.34]:5809 "EHLO posti5.jyu.fi")
	by vger.kernel.org with ESMTP id S932167AbWCLTve (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Mar 2006 14:51:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id k2CJoMk9017675;
	Sun, 12 Mar 2006 21:50:22 +0200
Received: from aragorn.kortex.jyu.fi (aragorn.kortex.jyu.fi [130.234.182.44])
	by posti5.jyu.fi (8.13.4/8.13.4) with ESMTP id k2CJoIU1017667;
	Sun, 12 Mar 2006 21:50:20 +0200
Received: from [127.0.0.1] (aragorn.kortex.jyu.fi [127.0.0.1])
	by aragorn.kortex.jyu.fi (Postfix) with ESMTP id 13999468167;
	Sun, 12 Mar 2006 21:50:36 +0200 (EET)
User-Agent: Mozilla Thunderbird 1.0.6-7.5.20060mdk (X11/20050322)
X-Accept-Language: en-us, en
To: Noel Grandin <noel@peralex.com>
In-Reply-To: <440D2F4E.9090009@peralex.com>
X-Virus-Scanned: amavisd-new at cc.jyu.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17526>

Hi

Have you yet made any kind of planning of the features that would be
available or put up the repository?
I use novadays Eclipse basically for all of my editing and something
like CVS/Subclipse plug-ins for git would be cool.
(cdt cross-indexing is still a little bit slow with the amount of files
in kernel so with kernel I have turned that off)

Noel Grandin wrote:

>The subversion plugin (subclipse.tigris.org) might be a good starting
>point since it delegates a lot of it's low-level work through an
>interface called svnClientAdapter. Re-implementing that to talk to git
>should get you something useful in a reasonable time-frame.
>
>Note that an eclipse team plugin is a pretty complicated beast.
>  
>
Yes, but very powerfull for the people like me who have who just have
never bothered to learn VI/Emacs/sed properly
and feel with them like having 5 thumps, code finders, search tools,
refactoring tools, etc. available in Eclipse are very cool.

So if the repository for git plug-ins goes up somewhere I could try to
help a little bit.

Mika
