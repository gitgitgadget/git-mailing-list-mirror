From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [BUG] "stg pull" on qgit tree shows problems, including git-http-fetch segfault
Date: Sat, 20 May 2006 16:26:17 +0200
Message-ID: <e5bfff550605200726q5e23e60cu8885c0898ca10787@mail.gmail.com>
References: <20060520125804.GG6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 20 16:26:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhSPO-00015V-G7
	for gcvg-git@gmane.org; Sat, 20 May 2006 16:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964861AbWETO0T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 10:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbWETO0T
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 10:26:19 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:43400 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964861AbWETO0S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 20 May 2006 10:26:18 -0400
Received: by wr-out-0506.google.com with SMTP id 68so1310838wra
        for <git@vger.kernel.org>; Sat, 20 May 2006 07:26:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PP9SieHQ2szCqruD9NDy2z/1p9MS0HkLoL/8gbwTgf5TadyBsgDxZfsNYxhR+iBNuoJvI8qN4hGkbj1PSDfnCQscWanPd7FpGe4rgUIHJVvIWgBqoKPKcTZVTJ+Ch/hG9Xk419OVicPJZWa5hMfX918IvpRPAXzruBWVPnCkJOU=
Received: by 10.64.180.15 with SMTP id c15mr2122965qbf;
        Sat, 20 May 2006 07:26:18 -0700 (PDT)
Received: by 10.64.142.14 with HTTP; Sat, 20 May 2006 07:26:16 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060520125804.GG6535@nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20381>

On 5/20/06, Yann Dirson <ydirson@altern.org> wrote:
> With "master" branch pointing to tags/qgit-1.2~17 and "origin" to
> 0a327c900530d9dd293cd252894a24913d4172c3, with no patch applied on
> "master" stack, using stgit 0.9 and git 1.3.2:
>

Please reclone qgit repo and try again.

The public repository was broken by a my mistake few days ago. So you
need to reclone.

Thanks
Marco
