From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: remove perl from git-commit.sh
Date: Wed, 12 Jul 2006 13:17:52 +0200
Message-ID: <dbfc82860607120417m19c0ecefydb4b3f4cf60d646a@mail.gmail.com>
References: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 12 13:18:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0cj6-0008VN-Os
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 13:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWGLLRy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 07:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWGLLRx
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 07:17:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:5715 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751256AbWGLLRx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 07:17:53 -0400
Received: by wr-out-0506.google.com with SMTP id 58so92322wri
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 04:17:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=SL/+GQkS1+JwjStKFUYXvqfxLsti1nckUavaQrE6Qzm109zRxXRzxAEp1VFawH61aIr3jE+c8eh+ZhpLIhmfT+sZp7rgEFGqH0eevJNxQBcYjpFQ3snQ3255pEdHpwcuknX/dKO6NCf+SJL8LZYEl3WHnS2EOR2h/3iLcXNeh4o=
Received: by 10.82.109.19 with SMTP id h19mr56107buc;
        Wed, 12 Jul 2006 04:17:52 -0700 (PDT)
Received: by 10.78.178.20 with HTTP; Wed, 12 Jul 2006 04:17:52 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 4dbaebe030da4b25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23774>

On 7/12/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> Otherwise I'd better suggest to add another
> quoting style (replacing only \t, \n and backslash)

One could always do the quoting with sed, or am I missing something?

  nikolai
