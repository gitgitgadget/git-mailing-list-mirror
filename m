From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: cg-clone failing to get cogito latest tree.
Date: Mon, 1 Aug 2005 01:13:51 -0700 (PDT)
Message-ID: <20050801081351.38171.qmail@web53607.mail.yahoo.com>
References: <46a038f905073119492e521bde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Aug 01 10:16:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzVTK-0007HV-95
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 10:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVHAIPb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Aug 2005 04:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbVHAIP0
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Aug 2005 04:15:26 -0400
Received: from web53607.mail.yahoo.com ([206.190.37.40]:47995 "HELO
	web53607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261970AbVHAINz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2005 04:13:55 -0400
Received: (qmail 38173 invoked by uid 60001); 1 Aug 2005 08:13:51 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Gu/sIEeu5RFKlvX047Bl9IyvG1r3ydQ1iRSrApUFPgIc1E1//bBbbIgrT9oie/tn/c2YSX4kEXuaJi8TTW0rdU1O4ZrZEqbvxEc3+7/oZpcCoVnTUWwqRO+WcKzHl/pDRkawLC+9J3g2a7a+nJc4G44YuWW137kQIMEh1/v8Gbg=  ;
Received: from [61.16.170.178] by web53607.mail.yahoo.com via HTTP; Mon, 01 Aug 2005 01:13:51 PDT
To: Martin Langhoff <martin.langhoff@gmail.com>,
	GIT <git@vger.kernel.org>
In-Reply-To: <46a038f905073119492e521bde@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 
--- Martin Langhoff <martin.langhoff@gmail.com> wrote:

> On a new machine, trying to boostrap into latest cogito, I download
> and make cogito 0.12.1, and then...
> 
> $ cg-clone http://www.kernel.org/pub/scm/cogito/cogito.git cogito
> defaulting to local storage area
> 14:48:53

Please try "rsync" method too. Last week http seem to be broken. I have
tried linux-omap tree and "rsync" worked, but "http" was failing.

---Komal Shah

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
