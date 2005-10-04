From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGit command completions - and Git ones?
Date: Tue, 4 Oct 2005 08:23:11 +0100
Message-ID: <b0943d9e0510040023h287b9d44w@mail.gmail.com>
References: <200510021303.44960.blaisorblade@yahoo.it>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 04 09:24:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMh94-0007YS-27
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 09:23:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVJDHXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 03:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbVJDHXN
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 03:23:13 -0400
Received: from xproxy.gmail.com ([66.249.82.194]:31380 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932461AbVJDHXM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 03:23:12 -0400
Received: by xproxy.gmail.com with SMTP id i30so305440wxd
        for <git@vger.kernel.org>; Tue, 04 Oct 2005 00:23:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D3iKVT/rIb1qdaKF5/G9VxCkMNEKY7M85QaXhOA2F90wYHvSEXui8x4cfp6pls+auEFuD3y8uiscHJhdFcNEaUzrzkcXSvhB39GReH+HwNCvj/mP2uHQlGvMK2ZulyWkQAiko8gH8IsTY3SZq9gu3oEngc2GOFu961voO4TlZrw=
Received: by 10.70.62.5 with SMTP id k5mr676272wxa;
        Tue, 04 Oct 2005 00:23:11 -0700 (PDT)
Received: by 10.70.31.3 with HTTP; Tue, 4 Oct 2005 00:23:11 -0700 (PDT)
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200510021303.44960.blaisorblade@yahoo.it>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9666>

On 02/10/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> I noticed in your TODO you talk about adding command line completions. I've
> been doing it for my needs, and the thing is still very incomplete, even if
> it's not a "XXX hack hack hack", and I wanted to send this first draft.

Thanks, I will have a look at it.

FYI, the tla-contrib package has a script which automatically
generates the bash completion script from the help messages (well,
only for tla, but can be adapted).

--
Catalin
