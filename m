From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Fix syntax error in stg status
Date: Mon, 19 Sep 2005 09:28:56 +0100
Message-ID: <b0943d9e05091901287f453611@mail.gmail.com>
References: <20050918181551.21145.53583.stgit@zion.home.lan>
Reply-To: catalin.marinas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 10:29:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHH1O-0005Jb-65
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 10:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbVISI3D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 04:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVISI3D
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 04:29:03 -0400
Received: from xproxy.gmail.com ([66.249.82.207]:56051 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932372AbVISI3B convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 04:29:01 -0400
Received: by xproxy.gmail.com with SMTP id i31so269883wxd
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 01:28:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ajysAKz9NSG+MJX9yeugp+ufDpjONIN0T9hEfgz7laBpqUhOqB2apZpF5GQJnU7U34UUtsi54Kwv6vPkx6/IBCIn82IOEd4bTRffS5Em8N8mbGT/oBDmyCuoQWEyZTDlNKQ9tuu52P1i52+08hvHop93E99LNO1eoCy5vg5Q4ww=
Received: by 10.70.76.5 with SMTP id y5mr1219680wxa;
        Mon, 19 Sep 2005 01:28:56 -0700 (PDT)
Received: by 10.70.27.20 with HTTP; Mon, 19 Sep 2005 01:28:56 -0700 (PDT)
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <20050918181551.21145.53583.stgit@zion.home.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8847>

On 18/09/05, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it> wrote:
> Uff, it's becoming annoying - why things break so often?

Because of the lack of regression testing (and also the Python's
dynamic typing). After I release 0.7 this week, I'll start writing
some tests.

Thanks for the patch.

-- 
Catalin
