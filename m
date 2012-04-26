From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 15:16:15 -0700
Message-ID: <xmqqehra6swg.fsf@junio.mtv.corp.google.com>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
	<20120406023223.GB16264@sigill.intra.peff.net>
	<20120406025457.GA23997@sigill.intra.peff.net>
	<20120406042215.GA3938@burratino>
	<20120406054637.GA25301@sigill.intra.peff.net>
	<7vzkap1gck.fsf@alter.siamese.dyndns.org>
	<BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
	<20120426201921.GA15026@burratino>
	<20120426210251.GA31589@sigill.intra.peff.net>
	<CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	"David E. Wheeler" <david@justatheory.com>, git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 00:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNWz8-0004gw-GA
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 00:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab2DZWQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 18:16:18 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:63682 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab2DZWQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 18:16:17 -0400
Received: by qcsp5 with SMTP id p5so20800qcs.1
        for <git@vger.kernel.org>; Thu, 26 Apr 2012 15:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=w+RspYNf6pUuXAf8ls4cObw0Zx/UE7c1H1zXGQlScms=;
        b=Y+M8vIkdmkwrGQzkFhGCQvkEge3PIvF4ChGQz8+aWUw39SYQfC8h+SvwBJkNennYpj
         mjibe9WRryqq7/jeeeC4gk2eA9r9NNDJ4PRD9YDfXg0H174LzVAFkIc4pTuBTipvbFlw
         T5Su4XsP1gObDhckh6/iElalEGq1mr2/ng8unuc5plvk40S3UJtPlbFxl6zF1XAp8/7+
         fQ4cPch1K9FRbEeaW1puNMYuaFyw1E+lbvsd7Xpfiw1IEkokq+7StAy4I973XAutmLnJ
         mtC3R7pg+vh1BnTP4bfZ3dLX1vA0KjUO2x6pLn0aTe8mD+DdPrsDs8qcY4NQmai6kreG
         v/Ow==
Received: by 10.101.112.3 with SMTP id p3mr3298316anm.0.1335478576620;
        Thu, 26 Apr 2012 15:16:16 -0700 (PDT)
Received: by 10.101.112.3 with SMTP id p3mr3298289anm.0.1335478576447;
        Thu, 26 Apr 2012 15:16:16 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id k54si4375921yhh.5.2012.04.26.15.16.16
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 26 Apr 2012 15:16:16 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 56FCE10004D;
	Thu, 26 Apr 2012 15:16:16 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id F1ECBE125C; Thu, 26 Apr 2012 15:16:15 -0700 (PDT)
In-Reply-To: <CAP2yMa+mjvFmVwXjrB7FRaD2=iMCCPENWAOoCG5TCsqFdsCDxQ@mail.gmail.com>
	(Scott Chacon's message of "Thu, 26 Apr 2012 14:58:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkqgiYvk0WtGgeMtFOB/q8bIbdAEZzvQgyYNQWMbINnmmrHuDYYFhEPETV+1m9UNBQlXLJimtnMX0qLYH3s6gdGceHBDOtkXP6gUwQjOOZYPkZ/Hdgz1kQhcrgV4qI9WUcGn5ImHafJ62MUJLr2mNcWoMceQxN0g0lUpxiRk+p6FV35Eu4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196421>

Scott Chacon <schacon@gmail.com> writes:

> If you want to preview what it's going to look like and the URL
> structure, you can check out the current working version here:
>
> http://git-scm.herokuapp.com/docs/git-fetch

Nicely done.

Is it possible to have a link to Release Notes (not manual pages, which
you already have links to) for each release from "http://site/docs/git"
like we used to have at k.org site?  It is not a big deal, but that is
one thing I miss the most.
