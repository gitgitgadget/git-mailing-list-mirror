From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible --boundary bug
Date: Fri, 31 Mar 2006 18:39:47 +0200
Message-ID: <e5bfff550603310839u115eb06fj795ebc5cdf5bec24@mail.gmail.com>
References: <e5bfff550603301034r58b38500ie5897ed06fce6e9a@mail.gmail.com>
	 <e5bfff550603301255j52c68963v4b8eebea697eeecf@mail.gmail.com>
	 <7v64lvvyev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, "Paul Mackerras" <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 18:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FPMfA-0005Dm-Ip
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 18:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWCaQjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Mar 2006 11:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751418AbWCaQjs
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Mar 2006 11:39:48 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:10098 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750760AbWCaQjs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Mar 2006 11:39:48 -0500
Received: by zproxy.gmail.com with SMTP id k1so888029nzf
        for <git@vger.kernel.org>; Fri, 31 Mar 2006 08:39:47 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iAUowM7SVlvY92y8WqVGw99PhsG5v4mWDhgcFGZ+qUPDIlxyJzSrtL53Yk5hSQUI1bvcc57pq5dnYauVxJ8YRBCnM1DnEyms3fZVq6U07ZLlCbittWEEenEEpTsj2Yoq7ZFro+YPYFzLLUydpCX9WCpbgR6fpQe/rAuLZ0yP+Xk=
Received: by 10.65.213.10 with SMTP id p10mr322210qbq;
        Fri, 31 Mar 2006 08:39:47 -0800 (PST)
Received: by 10.64.131.14 with HTTP; Fri, 31 Mar 2006 08:39:47 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v64lvvyev.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18227>

On 3/31/06, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Sorry, the good description is below, please ignore the wrong previous one.
>
> I think this patch should fix it.
>

Yes. It works for me.

Thanks
Marco
