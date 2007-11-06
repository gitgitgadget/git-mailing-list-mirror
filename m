From: Francesco Pretto <ceztkoml@gmail.com>
Subject: Re: [Patch] Documentation: enhanced "git for CVS users" doc about
 shared repositories
Date: Tue, 06 Nov 2007 12:14:29 +0100
Message-ID: <47304C95.5090208@gmail.com>
References: <472F99F8.4010904@gmail.com> <7v8x5cmern.fsf@gitster.siamese.dyndns.org> <47303C2E.2070103@gmail.com> <Pine.LNX.4.64.0711061052570.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 12:14:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpMOT-0003f4-9q
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 12:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbXKFLOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 06:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754677AbXKFLOg
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 06:14:36 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27392 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbXKFLOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 06:14:35 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1076415ugc
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=qpmYtavVvnj2MzsZbEizrSNqPPu2+6odZHTlDeoRg3c=;
        b=Qp0NEYuIcC4c6kO1p7ifFnr8eVSDaCf8P30oFmZvPl6WtsZt1CemC0z0hEidnS2eaYqkDS+buR+MANzlMaWTZ5KHtvHOKgVP3QLoZq3q8tM9OV7kKgBaT72HbBpo+uIrCxHpFfYgKy2NWH9uyfGm9nWsMUW0f45MuqSwM9Cw+C0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=FyQsd4izgHihsjWmkRmLSd43Ha2neVLE7amxMEDylTbEhFQDGkUBvxKmMwUtqA26C1R4t7URm9Z7awVX4neFhP9+3GWWjaet0f4qyP6OTggK20IByHZWHy9TtKGNE7jdgvqu0JSAqpWZJu3lyNgyNa8PzWc418X3A3Xxf5O7UA4=
Received: by 10.66.237.9 with SMTP id k9mr573465ugh.1194347674296;
        Tue, 06 Nov 2007 03:14:34 -0800 (PST)
Received: from ?192.168.1.14? ( [87.0.185.143])
        by mx.google.com with ESMTPS id o1sm6151025uge.2007.11.06.03.14.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Nov 2007 03:14:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <Pine.LNX.4.64.0711061052570.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63661>

Johannes Schindelin ha scritto:
> 
> For most people, neither path is correct.

Yeah, I agree. I'll try to reflect this with a neutral wording :-)
In the context of the documentation, we should just take care of logical
following the example.
