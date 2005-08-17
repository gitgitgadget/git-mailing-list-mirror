From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: [PATCH] Change git-branch to list branches
Date: Wed, 17 Aug 2005 22:48:26 +0300
Message-ID: <87br3w73at.fsf@litku.valo.iki.fi>
References: <20050815204430.GA77829@rossby.metr.ou.edu>
	<87hddplqdu.fsf@litku.valo.iki.fi>
	<87d5odlq6l.fsf_-_@litku.valo.iki.fi>
	<7vslx98ua0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 21:43:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5Top-00066e-A0
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 21:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVHQTnU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVHQTnU
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 15:43:20 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:3705 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751224AbVHQTnU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 15:43:20 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep32-app.kolumbus.fi
          with ESMTP
          id <20050817194310.CEBJ6653.fep32-app.kolumbus.fi@litku.valo.iki.fi>;
          Wed, 17 Aug 2005 22:43:10 +0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslx98ua0.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Tue, 16 Aug 2005 14:08:07 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> I do not think we have agreed to limit ourselves to a flat
> namespace under refs/heads without subdirectories.  Something
> like what git-show-branches-script does when $# == 0, perhaps?

I didn't realise this. I'll send a revised patch soon.

-- 
Kalle Valo
