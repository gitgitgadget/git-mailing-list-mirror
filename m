From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: irc usage..
Date: Thu, 1 Jun 2006 10:03:44 +1200
Message-ID: <46a038f90605311503o1526c664qe61b0f3f40929b92@mail.gmail.com>
References: <Pine.LNX.4.64.0605201016090.10823@g5.osdl.org>
	 <447B6D85.4050601@gentoo.org>
	 <46a038f90605291521q37f34209wd923608bdebb9084@mail.gmail.com>
	 <447B7669.8050805@gentoo.org>
	 <46a038f90605301531g4f8b37c7qab9a717833c64ebc@mail.gmail.com>
	 <Pine.LNX.4.64.0605301604130.24646@g5.osdl.org>
	 <46a038f90605301804u3beabf4ct97c8a0ea6ef7b995@mail.gmail.com>
	 <447D043D.1020609@gentoo.org>
	 <46a038f90605302305g7a969a62r277af1724b912069@mail.gmail.com>
	 <447DA028.3040606@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Donnie Berkholz" <spyderous@gentoo.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Yann Dirson" <ydirson@altern.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Matthias Urlichs" <smurf@smurf.noris.de>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 01 00:04:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlYnW-0005mW-1m
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 00:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWEaWDr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 18:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965199AbWEaWDq
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 18:03:46 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:30923 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965198AbWEaWDp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 May 2006 18:03:45 -0400
Received: by wr-out-0506.google.com with SMTP id i31so135090wra
        for <git@vger.kernel.org>; Wed, 31 May 2006 15:03:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=N43/6db5wrIvLxENw5s+MS+rp7RS1S6/HpRZCpWW5euIEgJMHRTgHn5Yt1dcGD/UBKqW3VKNHYEoffgcK3GaHN49HzjIafEbN4ABqN+AIp7Ll9r5ad4vezT6s4e5dz6C6bSlVNCVUtgtRo0h9IwPLGdlOqh847BwL0GGTml+elI=
Received: by 10.54.156.10 with SMTP id d10mr584734wre;
        Wed, 31 May 2006 15:03:44 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Wed, 31 May 2006 15:03:44 -0700 (PDT)
To: antarus@gentoo.org
In-Reply-To: <447DA028.3040606@gentoo.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21093>

On 6/1/06, Alec Warner <antarus@gentoo.org> wrote:
> I have a dual opteron with 4gb of ram "on loan" from work :)
>
> It still dies though, using git cvsimport or parsecvs.

The machine I am running this is more constrained than that, and it
doesn't die. It just takes maybe 30hs. Make sure it's not a bad cvs
binary you got there (latest from gentoo seems to leak memory).

And if it's still dying... give us some more details ;-)

cheers,


martin
