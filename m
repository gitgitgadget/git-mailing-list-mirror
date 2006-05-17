From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Re: Fwd: [OT] Re: Git via a proxy server?
Date: Tue, 16 May 2006 20:56:39 -0700 (PDT)
Message-ID: <20060517035639.40450.qmail@web32004.mail.mud.yahoo.com>
References: <4469CF92.2010002@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 05:56:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgD9O-0003jE-W6
	for gcvg-git@gmane.org; Wed, 17 May 2006 05:56:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWEQD4k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 23:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWEQD4k
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 23:56:40 -0400
Received: from web32004.mail.mud.yahoo.com ([68.142.207.101]:23688 "HELO
	web32004.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751215AbWEQD4j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 23:56:39 -0400
Received: (qmail 40452 invoked by uid 60001); 17 May 2006 03:56:39 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Z0ftBaPCgMeCNyfKqS8WqvQoQXFAqwqyT6M2kzTfF8wK4NRGL2suAeNy0Ob5SAGTgEn1Bp6Wu+bY5IP5WT8hMaWPrao6v/aQQJVbsAECFbsBgyEZL29gtGXr98L+YhzebywAh95QJ75ga3zd4KdpUfXsUCq2lRLhUw7rP3RKozk=  ;
Received: from [61.152.162.133] by web32004.mail.mud.yahoo.com via HTTP; Tue, 16 May 2006 20:56:39 PDT
To: Petr Vandrovec <petr@vmware.com>
In-Reply-To: <4469CF92.2010002@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20160>

Petr Vandrovec <petr@vmware.com> wrote:
> Best to test this is to start 'socket 192.168.40.99
> 80' from command line and 
> then type these two lines above, plus one empty
> line.  You should get back '200 
> OK', empty line, and then you can start
> communicating using git protocol - if 
> you can do that...

I cannot run "socket" and "CONNECT" on Fedora Core 3.
It simply told me that no such command. How could I 
do this task in my case?

> As far as I can tell, http_proxy is ignored
> (Debian's git 1.3.2-1/cogito 0.17.2-1).

Seems you tried proxy-cmd.sh on Debian. Which 
distribution did you use? 

Thanks a lot,

Sam


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
