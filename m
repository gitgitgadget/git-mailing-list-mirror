From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: [PATCH] Change git-branch to list branches
Date: Wed, 17 Aug 2005 23:15:18 +0300
Message-ID: <871x4s7221.fsf@litku.valo.iki.fi>
References: <20050815204430.GA77829@rossby.metr.ou.edu>
	<87hddplqdu.fsf@litku.valo.iki.fi>
	<87d5odlq6l.fsf_-_@litku.valo.iki.fi>
	<7vslx98ua0.fsf@assigned-by-dhcp.cox.net>
	<87br3w73at.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 22:11:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5UEZ-0005V2-Sy
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 22:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbVHQUJ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 16:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbVHQUJ5
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 16:09:57 -0400
Received: from fep31-0.kolumbus.fi ([193.229.0.35]:20352 "EHLO
	fep31-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751223AbVHQUJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 16:09:56 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep31-app.kolumbus.fi
          with ESMTP
          id <20050817200950.MZZJ4404.fep31-app.kolumbus.fi@litku.valo.iki.fi>;
          Wed, 17 Aug 2005 23:09:50 +0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <87br3w73at.fsf@litku.valo.iki.fi> (Kalle Valo's message of
 "Wed, 17 Aug 2005 22:48:26 +0300")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Kalle Valo <Kalle.Valo@iki.fi> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>> I do not think we have agreed to limit ourselves to a flat
>> namespace under refs/heads without subdirectories.  Something
>> like what git-show-branches-script does when $# == 0, perhaps?
>
> I didn't realise this. I'll send a revised patch soon.

Ah, but you fixed it already. Thanks!

-- 
Kalle Valo
