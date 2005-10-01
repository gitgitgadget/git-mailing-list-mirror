From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git on OpenBSD
Date: Sat, 1 Oct 2005 21:57:52 +1200
Message-ID: <46a038f90510010257s53c1e3eas64b3fb9e57b594a1@mail.gmail.com>
References: <20051001062348.GA7903@boetes.org>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 01 11:59:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ELe8A-0005qI-0v
	for gcvg-git@gmane.org; Sat, 01 Oct 2005 11:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbVJAJ5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Oct 2005 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVJAJ5y
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Oct 2005 05:57:54 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:31570 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750783AbVJAJ5y convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 1 Oct 2005 05:57:54 -0400
Received: by qproxy.gmail.com with SMTP id z1so71028qbc
        for <git@vger.kernel.org>; Sat, 01 Oct 2005 02:57:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QjKzev/wMBwH8CVFPddTfplvLS7GgDLMW/XtwBYzaifyNshOn8Lr9+3aOs5cX23knHjijyOC54EpXA1RIThpSxhpI9y8dQTiYhm3IikM34bL4jujjgEKYV8ku+Ne1baPHIse7MOjiIp5ATcSmB1aVNA0tUB0A8yCvtyaepANJ8c=
Received: by 10.64.184.2 with SMTP id h2mr44475qbf;
        Sat, 01 Oct 2005 02:57:52 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Sat, 1 Oct 2005 02:57:52 -0700 (PDT)
To: Han Boetes <han@mijncomputer.nl>
In-Reply-To: <20051001062348.GA7903@boetes.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9595>

Hi,

There is an old version in the ports, but too old to be useful. A guy
at work got it going on NetBSD without a problem. I think the only
thing we changed was the shebang line in gitk because /bin/wish is
just a stupid script that complains and tells you to call
wish<version>.

cheers,


martin
