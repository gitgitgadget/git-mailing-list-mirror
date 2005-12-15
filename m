From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Tracking files across tree reorganizations
Date: Thu, 15 Dec 2005 18:40:28 +1300
Message-ID: <46a038f90512142140s31fe4a6ay706efb8b1d4c833b@mail.gmail.com>
References: <43A08B8F.1000901@zytor.com> <20051214223656.GJ22159@pasky.or.cz>
	 <Pine.LNX.4.64.0512141538440.3292@g5.osdl.org>
	 <43A0AE6B.3040309@zytor.com> <20051215014453.GN22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 15 06:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emlr3-0001bH-T4
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 06:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbVLOFka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 00:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161127AbVLOFka
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 00:40:30 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:23458 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161128AbVLOFk3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 00:40:29 -0500
Received: by wproxy.gmail.com with SMTP id 57so286017wri
        for <git@vger.kernel.org>; Wed, 14 Dec 2005 21:40:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=duLOs/QT3pOafjcRPNAihhOlmwtX88F9+H62C3Bebf/HJ4fdFQZOGArPzIhclrNOC7ceg+hHm4k+/O5sMqpJQusqEFiuE5MpIsUwMsa7K//n+950wS/la8LdmBA+YFGzjOZlJQXRy/7GNb0cEpbHsLcmhOjM375Tv9RXmVZssFw=
Received: by 10.54.145.12 with SMTP id s12mr698623wrd;
        Wed, 14 Dec 2005 21:40:28 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Wed, 14 Dec 2005 21:40:28 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051215014453.GN22159@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13680>

On 12/15/05, Petr Baudis <pasky@suse.cz> wrote:
> in the next few days, consequently making it trivial to add the
> on-the-fly automatic renames detection to per-file cg-log.

Does it matter? Who makes a big file reorg and doesn't put "big tree
reorganization" in the commit message, and can we shoot him?

cheers,

martin
