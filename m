From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: make tutorial a valid asciidoc article
Date: Mon, 16 Jan 2006 08:21:54 +0000
Message-ID: <b0943d9e0601160021t3b40ba3fp@mail.gmail.com>
References: <1137142486.20073.77.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 09:22:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyPck-0007Ob-9f
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 09:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932242AbWAPIVz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 03:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbWAPIVz
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 03:21:55 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:33367 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932242AbWAPIVz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 03:21:55 -0500
Received: by xproxy.gmail.com with SMTP id i30so858887wxd
        for <git@vger.kernel.org>; Mon, 16 Jan 2006 00:21:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mlGU0ryHungOSdHBZxYtE0WXWkcogWXZfgbTSnf2WzyMdMnno7oNax4KgDw0tWIWrgRP1PMPyyid5l8RhB4gcTWoMNS9QLtJrFGJ2hjgrvysx/YoB+uvv41a1YsjYsPJewH0fYx6BwpSxARfMM+lvH0rLi3qtaEx0YPECTn/7hU=
Received: by 10.70.62.19 with SMTP id k19mr7481285wxa;
        Mon, 16 Jan 2006 00:21:54 -0800 (PST)
Received: by 10.70.53.11 with HTTP; Mon, 16 Jan 2006 00:21:54 -0800 (PST)
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1137142486.20073.77.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14729>

On 13/01/06, Pavel Roskin <proski@gnu.org> wrote:
> There should be only one level 0 title in an article, so lower ranks of
> all headers by one.  Make capitalization uniform in the headers - level
> 1 is capitalized, but level 2 is not.  Create a new level 1 part
> "Technical Information".
>
> Make ".git/ Directory Structure" a level 2 header and rephrase.
> asciidoc doesn't like headers starting with a dot.

I agree with most of this but what's the difference when adding "~~~~"
instead of "----"?

Thanks.

--
Catalin
