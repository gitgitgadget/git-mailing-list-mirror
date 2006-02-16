From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] pg - A patch porcelain for GIT
Date: Thu, 16 Feb 2006 10:33:12 +0000
Message-ID: <b0943d9e0602160233i68fe5879y@mail.gmail.com>
References: <20060213210001.GA31278@pasky.or.cz>
	 <43F1F5CB.10402@citi.umich.edu>
	 <20060214160747.GA6350@diana.vm.bytemark.co.uk>
	 <43F2445A.6020109@citi.umich.edu> <20060214222913.GK31278@pasky.or.cz>
	 <43F2745D.4010800@vilain.net> <20060215003510.GA25715@spearce.org>
	 <20060215041142.GA21048@fieldses.org>
	 <20060215065411.GB26632@spearce.org>
	 <7vbqx7bnz7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,
	Chuck Lever <cel@citi.umich.edu>,
	=?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 11:34:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9gRp-0005bY-Hs
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 11:33:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWBPKdO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 05:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWBPKdO
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 05:33:14 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:41689 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751236AbWBPKdN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 05:33:13 -0500
Received: by xproxy.gmail.com with SMTP id t11so48040wxc
        for <git@vger.kernel.org>; Thu, 16 Feb 2006 02:33:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r/cdZR29HGbSVSRj2cIsUITzdF86eh+m+jyesRfEliAb9BcG6cWQxrbYZEFLHA/HjbHctpoTdkolSqRx7MAutZjpqDZSku4oFrKEEeoVgdYw+gn2FX4F4u99rwac6zI07aWoi0LCWOWV/4qkS05eN/k6Cfm8CeC7KGw4XysuECc=
Received: by 10.70.97.10 with SMTP id u10mr932589wxb;
        Thu, 16 Feb 2006 02:33:12 -0800 (PST)
Received: by 10.70.53.7 with HTTP; Thu, 16 Feb 2006 02:33:12 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqx7bnz7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16291>

On 16/02/06, Junio C Hamano <junkio@cox.net> wrote:
> By the way, please do *not* do this:
>
>     Mail-Followup-To: "J. Bruce Fields" <bfields@fieldses.org>,
>             Sam Vilain <sam@vilain.net>, Petr Baudis <pasky@suse.cz>,...
>             ...

I think that's a "feature" of mutt that I couldn't understand. Every
time I got this header and looked at the mail client, it was... mutt
:-).

--
Catalin
