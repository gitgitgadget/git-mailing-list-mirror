From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: master has some toys
Date: Thu, 17 Nov 2005 09:29:03 +0100
Message-ID: <81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>
	 <b0943d9e0511160311k725526d8v@mail.gmail.com>
	 <7vr79g8mys.fsf@assigned-by-dhcp.cox.net>
	 <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 09:30:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ecf94-0006LK-CS
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 09:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161163AbVKQI3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 03:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161164AbVKQI3G
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 03:29:06 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:34295 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161163AbVKQI3E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2005 03:29:04 -0500
Received: by nproxy.gmail.com with SMTP id l37so386936nfc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:29:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GPNvqilkkCCGhc6DZBoLoPTlCgHYvthfkcIKfYSk5e129cr2hHzHmXdymWJNU7spcCTAvKpklWEsrXr0bpXPgGxG2lbAWipDfTErkZC03m0hauN4a53ZjYwMwbxJiMlyBB8clfoLUZKnAkl1vjahrPppuQsF7HVjllayzX7ApbM=
Received: by 10.48.211.11 with SMTP id j11mr132994nfg;
        Thu, 17 Nov 2005 00:29:03 -0800 (PST)
Received: by 10.48.247.3 with HTTP; Thu, 17 Nov 2005 00:29:03 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12090>

On 11/17/05, Junio C Hamano <junkio@cox.net> wrote:
> Along with the git wrapper fixes and git-apply bugfix (it did

cygwin is completely broken. Still debugging, but it looks like the
old "windows can't unlink/rename open files" problem.
