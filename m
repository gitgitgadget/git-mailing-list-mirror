From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: git pull on a branch semantics
Date: Tue, 24 Jan 2006 07:37:03 -0800 (PST)
Message-ID: <20060124153703.53338.qmail@web31804.mail.mud.yahoo.com>
References: <7v7j8sc6wy.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 16:38:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1QEJ-0004Qh-E5
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 16:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWAXPhI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jan 2006 10:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWAXPhI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jan 2006 10:37:08 -0500
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:2147 "HELO
	web31804.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030358AbWAXPhG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2006 10:37:06 -0500
Received: (qmail 53340 invoked by uid 60001); 24 Jan 2006 15:37:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=AUGi9m2uEsAQDQLcrUu49FdJwaOYQF8BqemIKLMwYS4Uc9JNRRkIjWEtDN8df0eWHIbUZGyivOjRmMaE3jKToOJIpxS7Sp81EGt3p+WeI4FsK8CE1KTxBorHMHkoSjM2M2sNm7hUR8AH3sGIBKT+7yqqBzo+2xSk1uPrqIryDos=  ;
Received: from [65.74.248.133] by web31804.mail.mud.yahoo.com via HTTP; Tue, 24 Jan 2006 07:37:03 PST
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j8sc6wy.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15100>

--- Junio C Hamano <junkio@cox.net> wrote:
> You wanted to "git fetch", not "git pull" which is "fetch
> followed by merge into the current branch".

Ah, ok, thanks Junio.

   Luben
