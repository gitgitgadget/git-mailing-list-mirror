From: "Thomas Harning Jr." <harningt@gmail.com>
Subject: Re: Track /etc directory using Git
Date: Fri, 14 Sep 2007 13:31:06 -0400
Message-ID: <e47324780709141031t79981b04q3a91984668ea723e@mail.gmail.com>
References: <38b2ab8a0709130511q7a506c5cvb0f8785a1d7ed7ad@mail.gmail.com>
	 <20070913123137.GA31735@piper.oerlikon.madduck.net>
	 <38b2ab8a0709140108v2a9c3569i93b39f351f1d4ec3@mail.gmail.com>
	 <20070914091545.GA26432@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Francis Moreau" <francis.moro@gmail.com>
To: "martin f krafft" <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:49:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWF0a-00072e-Nt
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 19:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531AbXINRbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 13:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753449AbXINRbI
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 13:31:08 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:16808 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856AbXINRbH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 13:31:07 -0400
Received: by py-out-1112.google.com with SMTP id u77so1887005pyb
        for <git@vger.kernel.org>; Fri, 14 Sep 2007 10:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=pGJWnIIojhzMTLIl4MLfMWXXigzSKgTLVKoRglIsSdA=;
        b=iPQbTDSvUZvLH1ndfJQfSlLe/jzs47EwUiL4eLNqnl1sgX81CI6vmqJdGRvMkXEYqLpCOCQYXUDNy7AGCBWDt1aHMjXLDio+hxa9S/V7uOvLlKHavaWFY4aMRK1iLdgQtgo0Q/7+7Ktot2GzEOrRReiSeIMUqo3cRk6waI4eVOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KgyOeeOzXCw0CM/rAOe8DOhy/Cir29GU+ysG/RzjHlKbuUz59pdU63Yt8g995MNH+7kq2w2XNXT1aW8QXVVkdY1VfsBOWXbhL97oIuAs44xsoKEi1sws0AE/96V6ml7WkMcsBuBOuZx47xm7KcU+C923h/iHMp29++jVvhz2j/w=
Received: by 10.65.196.2 with SMTP id y2mr4701684qbp.1189791066344;
        Fri, 14 Sep 2007 10:31:06 -0700 (PDT)
Received: by 10.65.43.10 with HTTP; Fri, 14 Sep 2007 10:31:06 -0700 (PDT)
In-Reply-To: <20070914091545.GA26432@piper.oerlikon.madduck.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58167>

On 9/14/07, martin f krafft <madduck@madduck.net> wrote:
> also sprach Francis Moreau <francis.moro@gmail.com> [2007.09.14.1008 +0200]:
> > Did you find an alternative to git in this case ?
>
> No, and I did not look anywhere, but I know of no other VCS that can
> adequatly track permissions.
Has anyone checked out metastore?  http://repo.or.cz/w/metastore.git
... there's an XML error in there somewhere, so its not loading the
'main' page, but http://repo.or.cz/w/metastore.git?a=shortlog should
work.

It looks like it could work.... any thoughts on this?


-- 
Thomas Harning Jr.
