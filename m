From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: Project Hosting with git ?
Date: Sat, 12 Jan 2008 13:08:23 -0500
Message-ID: <9b3e2dc20801121008l73a7b357q1acb28718511c03c@mail.gmail.com>
References: <912ec82a0801120553u3621c991u7c4cb4793960159c@mail.gmail.com>
	 <9b3e2dc20801120845n15d59fe6q178ba257c12a28e0@mail.gmail.com>
	 <4788FBDE.6090903@gbarbier.org>
	 <9b3e2dc20801120954k24f7ccb6vf019f30843ff1b84@mail.gmail.com>
	 <47890078.3050809@gbarbier.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Gr=E9goire_Barbier?=" <devel@gbarbier.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:09:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDkmy-0005x1-To
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbYALSIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 13:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbYALSIZ
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:08:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:2306 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742AbYALSIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 13:08:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1282506rvb.1
        for <git@vger.kernel.org>; Sat, 12 Jan 2008 10:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4+H1ZtzkBAQar6c7Uf0Y+C3k5ncpNLk+cK5R4gkF+LQ=;
        b=U1kbBwx5/UUDCFFN7LP77qCA/5+GHLlh3VbR6DGM5YVrOh3fAl5nxajtTx5OhLxqYmAqCuUPeMr2nqgS+30FSt8EZbOohXcTpUTlCYNZv+IkCb4ZdydenIzzHs6GbF2dqR130dqrsL51TF4m+387V5OAQrX/N/3oSzo+cwcDCDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LGVASoTJPuoxxP7QPGxqIW7igpoDRpe52QE58E3fg2VAZk30P3MQVGbp93W+JmgpkmW7wyAma0YRNrZpwTGGzlryTJWmhTSLj+b9oj/jb+KtY4oVDFMgAMOWfbdFSwhkx/AC7VqO/WB8q4Oqmm1MnP9c33We+Rxkx8SeidUSqGo=
Received: by 10.140.201.1 with SMTP id y1mr2787900rvf.246.1200161303464;
        Sat, 12 Jan 2008 10:08:23 -0800 (PST)
Received: by 10.140.188.1 with HTTP; Sat, 12 Jan 2008 10:08:23 -0800 (PST)
In-Reply-To: <47890078.3050809@gbarbier.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70340>

> I don't think so. A working http-push over webdav would be a dumb
> protocol (passive filesystem upload).

I see.  Not having read your whole thread, I assumed you intended
http-push to be active, more like the svn counterpart.  My bad.
That said, I think having an active http-push would be pretty useful.
A passive http-push would be useful mainly for getting past http proxy
servers I guess.  Definitely could be nice for that.

Steve
