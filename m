X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Chris Riddoch" <riddochc@gmail.com>
Subject: Re: [DRAFT] Branching and merging with git
Date: Fri, 17 Nov 2006 15:36:25 -0700
Message-ID: <6efbd9b70611171436t1e0cadf2j7e9387ca77f85538@mail.gmail.com>
References: <20061116221701.4499.qmail@science.horizon.com>
	 <20061117153246.GA20065@thunk.org>
	 <BAYC1-PASMTP07C8A8D8E5E78173953CA9AEE80@CEZ.ICE>
	 <fcaeb9bf0611170819j57cda9e1ia4ecd4cd13956447@mail.gmail.com>
	 <20061117113404.810fd4ea.seanlkml@sympatico.ca>
	 <20061117165333.GR4842@pasky.or.cz>
	 <20061117120154.3eaf5611.seanlkml@sympatico.ca>
	 <20061117213125.GG7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 17 Nov 2006 22:36:33 +0000 (UTC)
Cc: Sean <seanlkml@sympatico.ca>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q/b0/od7gYQfQty7+CVNvx1Mi+7gjqoYaJ/tuFiM3ifJYBZ/K4nAcd3BeEjVcCcYehxyMj5w2ngG536xLaLPvQ0RRDP9vN8oXkvNbt7WPi2dXd7wAppHAIQ9T7EBs90Lf81UUblkZu3lt74gJdkDg/KlVCVV/HfULIQU/hyO5SU=
In-Reply-To: <20061117213125.GG7201@pasky.or.cz>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31736>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlCJy-0006MU-BB for gcvg-git@gmane.org; Fri, 17 Nov
 2006 23:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751803AbWKQWg0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 17:36:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbWKQWg0
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 17:36:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:41605 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1751803AbWKQWgZ
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 17:36:25 -0500
Received: by wx-out-0506.google.com with SMTP id s7so1097528wxc for
 <git@vger.kernel.org>; Fri, 17 Nov 2006 14:36:25 -0800 (PST)
Received: by 10.70.35.1 with SMTP id i1mr3965002wxi.1163802985220; Fri, 17
 Nov 2006 14:36:25 -0800 (PST)
Received: by 10.70.59.14 with HTTP; Fri, 17 Nov 2006 14:36:25 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/17/06, Petr Baudis <pasky@suse.cz> wrote:
> If someone writes a crash course in pure Git covering the same grounds
> as the current ones (possibly by just extending/retouching the tutorial)
> (it does not necessarily need to be a "refugee" crash course, it can
> build up from scratch), I can add it on the web. If it becomes as easy
> to use and with as mild learning curve as Cogito, it means Cogito got
> mostly obsolete and I'll happily remove the Cogito crash courses from
> the web.

As a relatively new user myself, I ran into the same confusion when I
came to the website for the first time.  One of the most prominent
things on the front page is the "Git Crash Courses."  Clicking on that
gives me the crash courses, all of which are about Cogito, not for
Git.  So why doesn't the front page say "Cogito Crash Courses"
instead?

And I don't think it matters much whether Cogito makes things easier
or not -- the Git website really should make Git's documentation more
prominent than Cogito's.  I'd expect the opposite of Cogito's website.

It *is* unnecessarily confusing.

-- 
epistemological humility
