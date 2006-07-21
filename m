From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git BOF notes
Date: Fri, 21 Jul 2006 17:02:02 +0200
Message-ID: <81b0412b0607210802q4d48b277yc4c45d4acbd890a6@mail.gmail.com>
References: <20060719230155.GJ13776@pasky.or.cz>
	 <20060721132111.GD32585@fieldses.org>
	 <20060721143115.GN13776@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 21 17:02:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3wW5-0003Q9-Gu
	for gcvg-git@gmane.org; Fri, 21 Jul 2006 17:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWGUPCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Jul 2006 11:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGUPCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Jul 2006 11:02:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:9397 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750769AbWGUPCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jul 2006 11:02:09 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1313497ugc
        for <git@vger.kernel.org>; Fri, 21 Jul 2006 08:02:07 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IFPh1QkRjtEeeCNQqRd/iSFlXWvdYPQGEJtLTakepLVDg2ZVWyCLI3h7Ym76giNM/ZyUTUm1fGDWy7P0Inh2Urq/wxk4Ndz00JtdJAQMuAMKRBqOeWYTGscG83ntBa5LEz4kQeFaH0/wFjQUh8Uvh55PvSi3kOgv/U9wdhwv5Y4=
Received: by 10.78.177.3 with SMTP id z3mr425223hue;
        Fri, 21 Jul 2006 08:02:07 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Fri, 21 Jul 2006 08:02:02 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060721143115.GN13776@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24057>

On 7/21/06, Petr Baudis <pasky@suse.cz> wrote:
> I don't know if there's a point in being so paranoid - it already makes
> things more painful than necessary. In the tracking branch, you just
> want to have what the other side has anyway, and if the other side
> decided to jump around, why would you care otherwise?

But for the ones who do care, it is much harder to notice. Even if it is
a warning (it gets lost in crontab logs).
