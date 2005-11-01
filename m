From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git versus CVS (versus bk)
Date: Tue, 1 Nov 2005 14:02:43 +1300
Message-ID: <46a038f90510311702wfb43281rf4464a02e8e3be2@mail.gmail.com>
References: <Pine.LNX.4.64.0510301720390.14972@x2.ybpnyarg>
	 <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.64.0510310804400.27915@g5.osdl.org>
	 <20051031195010.GM11488@ca-server1.us.oracle.com>
	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <20051031213616.GO11488@ca-server1.us.oracle.com>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <7vbr15b4m4.fsf@assigned-by-dhcp.cox.net>
	 <20051101004255.GQ11488@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Nov 01 02:04:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EWkY3-0002sR-PU
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 02:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVKABCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Oct 2005 20:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbVKABCp
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Oct 2005 20:02:45 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:14232 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964859AbVKABCo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2005 20:02:44 -0500
Received: by xproxy.gmail.com with SMTP id i30so1146896wxd
        for <git@vger.kernel.org>; Mon, 31 Oct 2005 17:02:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cCsOqjldha4yBO2QqPyX/lLTRxaD7u83yUfmHnYAZNpGDSofAv8lk5Tkf2Cud+fOqFKojRXO9LkPg4/9yuuoCUlnq41m/OGHojdyLeQiA2T7c/i1T72kIWsPquneaJPEnOAiNvsXZMxNazRTViH3g0xkgCHT7CfREUUe1Gy8oDQ=
Received: by 10.64.10.12 with SMTP id 12mr700292qbj;
        Mon, 31 Oct 2005 17:02:44 -0800 (PST)
Received: by 10.64.232.18 with HTTP; Mon, 31 Oct 2005 17:02:43 -0800 (PST)
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051101004255.GQ11488@ca-server1.us.oracle.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10913>

On 11/1/05, Joel Becker <Joel.Becker@oracle.com> wrote:
> > is possible) offhand.  Sometimes, when you want truly logical
> > steps, you would end up needing intermediate steps that never
> > existed in your true history (i.e. "in the hindsight, my
> > development should have progressed in these steps.")
>
>         Yes, I always do.  But I'm not talking about that sort of large
> feature add or whatever.  I'm talking about merely doing something on a
> small scale, but in a temporary repository.

I'm really surprised that Calalin hasn't chimed in. If you are into
rewriting/merging/splitting your patches, StGIT is your friend. Check
out:  http://www.procode.org/stgit/

cheers,


martin
