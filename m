From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: repo.or.cz wishes?
Date: Mon, 27 Aug 2007 17:27:29 -0400
Message-ID: <20070827172729.wq6cdxhnk0o408sc@intranet.digizenstudio.com>
References: <20070826235944.GM1219@pasky.or.cz>
	<20070827001634.GB1976MdfPADPa@greensroom.kotnet.org>
	<20070827004153.GN1219@pasky.or.cz>
	<alpine.LFD.0.999.0708271114470.25853@woody.linux-foundation.org>
	<mj+md-20070827.195605.14967.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Petr Baudis <pasky@suse.cz>, skimo@liacs.nl,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Martin Mares <mj@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Aug 28 01:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPmYI-0003tf-4t
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 23:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765049AbXH0V1f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 17:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764996AbXH0V1e
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 17:27:34 -0400
Received: from k2smtpout05-02.prod.mesa1.secureserver.net ([64.202.189.57]:43846
	"HELO k2smtpout05-02.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764968AbXH0V1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 17:27:32 -0400
Received: (qmail 28896 invoked from network); 27 Aug 2007 21:27:32 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout05-02.prod.mesa1.secureserver.net (64.202.189.57) with ESMTP; 27 Aug 2007 21:27:32 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 13F50100587;
	Mon, 27 Aug 2007 21:27:32 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hE5aAR6nj4K7; Mon, 27 Aug 2007 17:27:29 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id 38B0D100A0B; Mon, 27 Aug 2007 17:27:29 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Mon, 27 Aug 2007 17:27:29 -0400
In-Reply-To: <mj+md-20070827.195605.14967.albireo@ucw.cz>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56889>


Quoting Martin Mares <mj@ucw.cz>:

> What does `ssh://what.the.hell.org/some/file' per se mean?
>
> SSH is a protocol, but rather in the sense similar to TLS, not to HTTP.
> If it has some addressable objects, which could be referred to by the
> path part of the URL, they should be the programs to execute at the
> remote server, i.e., in our case the path to the GIT client binary,
> and certainly not the name of the repository, which has nothing to do
> with the SSH protocol.

Not to advocate either way (me being completely new to git), but as  
far as ssh is concerned, I don't think that the addressable objects  
necessarily have to be executables.

Quoting RFC4251:
"The Secure Shell (SSH) Protocol is a protocol for secure remote login  
and other secure network services over an insecure network."

That reads rather vague to me.
-- 
Jing Xue
