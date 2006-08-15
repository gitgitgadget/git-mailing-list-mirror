From: jeffpc@josefsipek.net (Josef "Jeff" Sipek)
Subject: Re: Git network protocol
Date: Tue, 15 Aug 2006 05:14:10 -0400
Message-ID: <20060815091410.GA28369@josefsipek.net>
References: <20060814062117.GC10476@josefsipek.net> <7vk65bg6na.fsf@assigned-by-dhcp.cox.net> <20060814234826.GA21861@josefsipek.net> <7vwt9aak5i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 11:14:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCv09-000442-CP
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 11:14:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbWHOJOR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 05:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965321AbWHOJOR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 05:14:17 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:51436 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S965320AbWHOJOP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 05:14:15 -0400
Received: from relay2.stonybrook.edu (relay2 [172.30.255.14])
	by mrs.stonybrook.edu (8.13.6/8.13.6) with SMTP id k7F9ECdA029838;
	Tue, 15 Aug 2006 05:14:12 -0400 (EDT)
Received: from mailrelay.stonybrook.edu ([172.30.255.14])
 by relay2.stonybrook.edu (SMSSMTP 4.1.12.43) with SMTP id M2006081505141211957
 ; Tue, 15 Aug 2006 05:14:12 -0400
Received: from josefsipek.net (turing.ams.sunysb.edu [129.49.108.158])
	by mailrelay.stonybrook.edu (8.13.6/8.13.6) with ESMTP id k7F9EB74029834;
	Tue, 15 Aug 2006 05:14:12 -0400 (EDT)
Received: by josefsipek.net (Postfix, from userid 1000)
	id 1CCFD1C00DF0; Tue, 15 Aug 2006 05:14:10 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt9aak5i.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25452>

On Mon, Aug 14, 2006 at 05:59:37PM -0700, Junio C Hamano wrote:
> jeffpc@josefsipek.net (Josef "Jeff" Sipek) writes:
> 
> > So, if I understand this correctly, multi_ack allows for multiple branches
> > to be fetched using the same connection?
> 
> The original protocol without extension already allowed it.
> Suppose the global history was like this:
...

Thanks. That helped a lot.

Josef "Jeff" Sipek.

-- 
Linux, n.:
  Generous programmers from around the world all join forces to help you
  shoot yourself in the foot for free. 
