From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: [PATCH 1/1] Tried to fix git-svn's handling of filenames with embedded '@'.
Date: Mon, 29 May 2006 10:47:03 -0700
Message-ID: <m24pz8lo4o.fsf@ziti.fhcrc.org>
References: <m21wuem2xj.fsf@ziti.fhcrc.org> <m2verqkobr.fsf@ziti.fhcrc.org>
	<20060529063543.GA8128@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 19:48:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fklpn-0000eM-K7
	for gcvg-git@gmane.org; Mon, 29 May 2006 19:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWE2RrI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 13:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWE2RrI
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 13:47:08 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:29972 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751112AbWE2RrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 13:47:07 -0400
Received: by wr-out-0506.google.com with SMTP id i7so927599wra
        for <git@vger.kernel.org>; Mon, 29 May 2006 10:47:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=UL1LdKJnhkOdKp8+kpUysUMIAcP0aFRWXhTVBjyG/E921dibcLkOKcoHkElzxy/h0Kpze2lredtU+euLtUvDCNQfBlhT1l1CdylldR9znebzh4NrfAmjJNRRe15JI0bThOn/9uWtyTA+SfoQe7yP9wHPsM6vvc2B9wx1I6Q+Eq0=
Received: by 10.54.83.6 with SMTP id g6mr2364895wrb;
        Mon, 29 May 2006 10:47:06 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id 27sm4642117wrl.2006.05.29.10.47.06;
        Mon, 29 May 2006 10:47:06 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20060529063543.GA8128@localdomain> (Eric Wong's message of "Sun, 28 May 2006 23:35:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20953>

Eric Wong <normalperson@yhbt.net> writes:

> Seth: how does this work?

Your revised patch works for me, thanks.

+ seth
