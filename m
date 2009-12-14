From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 23:03:26 +0100
Message-ID: <fabb9a1e0912141403hb728974sc50b9e8dbb08925d@mail.gmail.com>
References: <1260822484.9379.53.camel@localhost> <20091214211142.GC9364@coredump.intra.peff.net> 
	<1260825629.9379.56.camel@localhost> <20091214212343.GA11131@coredump.intra.peff.net> 
	<1260827790.9379.59.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKJ1f-0006qX-MR
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 23:04:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758562AbZLNWDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 17:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbZLNWDu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 17:03:50 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:44136 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758561AbZLNWDr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 17:03:47 -0500
Received: by vws30 with SMTP id 30so775384vws.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 14:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=sBrIIyJ1PJEuRqlO3vn4JjT/WAIHangAEGN+3V3CbrA=;
        b=bdxArAhlHh5HvnLxWxHB1OJBsFVjNVX8jhbc5PdljSUhO2qGNNqibYvQp4L9EKemBK
         cA+GatVKJcIFe/QrPFhyKZcw1HhxMNofxdXPeFfIZrDYKed7sS9jGMLC3X7adEdp4vcg
         Ll+Ni+Aq8LexH17uhuyeVT2Jv8RDQwQHzmoGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Y1iI2vtPrsT5AQpFmUrqVwp2mi6GobXrYhcXjcKJuUWXhmNVg44SspxSM4JUgebaTi
         G0qJOqTs4l4RRPhWRpN38SYa+2VjZV1wKsv6VIWxUDFObNJv6N9GFgHvjFq1Rz9AkOvK
         MLMWSCwhw1oXRyd0Eg1LZn/svMmH5jZC5uqmk=
Received: by 10.220.122.215 with SMTP id m23mr1004454vcr.42.1260828226069; 
	Mon, 14 Dec 2009 14:03:46 -0800 (PST)
In-Reply-To: <1260827790.9379.59.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135247>

Heya,

On Mon, Dec 14, 2009 at 22:56, Eric Paris <eparis@redhat.com> wrote:
> Just started pushing the 1.3G file.
>
> Maybe having a .git directory that large is the problem?

What did you say this repository contained again? Your home video's?
Ah, well that explains ;).

-- 
Cheers,

Sverre Rabbelier
