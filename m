From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Mon, 19 Jun 2006 10:35:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606191034350.26329@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vpsh75lx1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0606181417090.26803@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060618130837.GN2609@pasky.or.cz> <7vy7vta9ae.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 19 10:35:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsFE3-0005Gl-39
	for gcvg-git@gmane.org; Mon, 19 Jun 2006 10:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWFSIfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Jun 2006 04:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWFSIfJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jun 2006 04:35:09 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:1949 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932330AbWFSIfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jun 2006 04:35:07 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id A9F0AD29;
	Mon, 19 Jun 2006 10:35:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9E1A4D0C;
	Mon, 19 Jun 2006 10:35:06 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 816C1B68;
	Mon, 19 Jun 2006 10:35:06 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7vta9ae.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22120>

Hi,

On Mon, 19 Jun 2006, Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
> > Dear diary, on Sun, Jun 18, 2006 at 02:26:14PM CEST, I got a letter
> > where Johannes Schindelin <Johannes.Schindelin@gmx.de> said that...
> >
> >> Note that this issue is orthogonal to the need for a user-specific config 
> >> file. I still think that this one should go in.
> >
> > I agree as well.
> 
> OK, let's have it then.
> 
> Johannes, this makes your earlier ~/.gitconfig and --no-local
> patches no longer applicable, so I'd drop them from "pu" for
> now.  But I suspect we do want to have per user configuration
> that is used as a fallback for per repo configuration, right?

I'll redo the patches, then.

Ciao,
Dscho
