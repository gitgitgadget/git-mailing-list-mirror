From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Jan 2013, #03; Sun, 6)
Date: Mon, 7 Jan 2013 09:30:19 +0000
Message-ID: <20130107093019.GI6440@serenity.lan>
References: <7vip79lnnb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 10:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts9AI-0003nG-HV
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 10:38:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab3AGJiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 04:38:23 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:42856 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180Ab3AGJiW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 04:38:22 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Jan 2013 04:38:22 EST
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 4070F22FD9;
	Mon,  7 Jan 2013 09:30:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IeGAdBJgp7JC; Mon,  7 Jan 2013 09:30:26 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id A0AD923058;
	Mon,  7 Jan 2013 09:30:26 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 52E0E161E559;
	Mon,  7 Jan 2013 09:30:26 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HUEBzgQy3xuc; Mon,  7 Jan 2013 09:30:26 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 5006A161E53A;
	Mon,  7 Jan 2013 09:30:20 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vip79lnnb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212890>

On Sun, Jan 06, 2013 at 06:42:16PM -0800, Junio C Hamano wrote:
> * jk/maint-fast-import-doc-dedup-done (2013-01-05) 1 commit
>  - git-fast-import(1): remove duplicate "--done" option
> 
>  Will merge to 'next' and 'master' as a quick "oops" fix.
> 
>  The "logical order" reorganization can come after that is done and
>  can cook longer in 'next'.

I was going to re-send this to change the quoting of 'done' to `done`,
which is what the original version had.  Is there still time for that or
should I send a separate patch?


John
