From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: add --full-history to history generation optimization
Date: Sun, 2 Jul 2006 18:38:06 -0700 (PDT)
Message-ID: <20060703013806.29750.qmail@web31805.mail.mud.yahoo.com>
References: <7vu060bmxy.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 03:38:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxDO7-00016t-Ez
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 03:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWGCBiI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 21:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWGCBiI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 21:38:08 -0400
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:64891 "HELO
	web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750762AbWGCBiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 21:38:07 -0400
Received: (qmail 29752 invoked by uid 60001); 3 Jul 2006 01:38:06 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nzW8/Mln+KL6H7EQortoXFyLF52f4os+pNDT/x6RLr4dNFYB3jhRxAwuKLwHcj0AXMHxhaiq9Va75Vju5B7Ga7eCXYr7eQVfUA4ZHMJ0agImW+Umx2Tlzxly3YrRI6fPzCEDvHQob62cZaUmdke+GJDZ3DAau4xxoPMXxaZFnYI=  ;
Received: from [68.186.62.135] by web31805.mail.mud.yahoo.com via HTTP; Sun, 02 Jul 2006 18:38:06 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu060bmxy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23147>

--- Junio C Hamano <junkio@cox.net> wrote:
> Thanks.  I believe I have the same change in "next" already, but
> I had to munge your patches by hand so please holler if there is
> any mistake on my part.

Great, thanks.  I took a look at "next" and it looks good.

   Luben
