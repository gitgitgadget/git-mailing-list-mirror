From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Improve documentation for git-remote-helpers
Date: Mon, 22 Mar 2010 09:08:31 +0530
Message-ID: <f3271551003212038i4239a852g9f9350cb1c93f8db@mail.gmail.com>
References: <f3271551003211026m376b86d6ga915f85a623eddfd@mail.gmail.com> 
	<f3271551003211121o48f502fp954b649ff4ca8f8b@mail.gmail.com> 
	<alpine.LNX.2.00.1003211907390.14365@iabervon.org> <f3271551003212004r4ac7db34vad5b23f5d930476d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 04:38:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtYTh-0006By-1U
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103Ab0CVDiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 23:38:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41684 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754063Ab0CVDiv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 23:38:51 -0400
Received: by gyg8 with SMTP id 8so2501613gyg.19
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 20:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=FzqUYkqtc62fmvRBVdo3Tjdpx006qACjKQObEUs6J4c=;
        b=UbTTtsTzwULDbg+tjHo+nk4u896i+3zYajBSVaKAtyojrJ1MLVHHy51nXtaDzFfudg
         12W3pkkBjjyWYDxL0b4livbm1iu2Lzpu+Qp21Aigh5S5Rdnnl0FKstbaPThrR0go9lVT
         QiyzU1mR5hhQ7yr0+LWzh65+/qiAlP0zCTFk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OXwzGcMkx5OQNfgfhij3uaVXALq0HqhxKh80zE/nitDfaE6WkGQSGv5YR823FhihZS
         J9Vtndht0uiM4krdxaR4qiHIyFvIyMWmlnmOU+No29Phz35IQSBHc9CPhmAE22r/tp7b
         /IgtiolsNPzZ5fAXpPJ+Bc6byrpeQVgszgrAM=
Received: by 10.91.51.19 with SMTP id d19mr3673857agk.101.1269229131069; Sun, 
	21 Mar 2010 20:38:51 -0700 (PDT)
In-Reply-To: <f3271551003212004r4ac7db34vad5b23f5d930476d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142890>

> Every capability doesn't necessarily have a corresponding command with
> the same name, and vice-versa (see refspec spec?). Besides, I think
> it's necessary for the manpage to have a list of capabilities listed
> in one place. I'll think about a better format when we get more
> capabilities/ commands.

I think I might have misunderstood what you said. So, I've posted a
third revision of the patch- is it the desired result?

-- Ram
