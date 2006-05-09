From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 9 May 2006 02:53:24 +0200
Message-ID: <4fb292fa0605081753r1d9e7cb6u3a9b513bcbf2404a@mail.gmail.com>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	 <1147131877.2694.37.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
	 <1147134522.2694.45.camel@shinybook.infradead.org>
	 <7vu080c9uv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "David Woodhouse" <dwmw2@infradead.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:53:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGTn-0006YY-PY
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998AbWEIAx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWEIAx2
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:53:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:25706 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750995AbWEIAx2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 20:53:28 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1087804nfe
        for <git@vger.kernel.org>; Mon, 08 May 2006 17:53:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pdPkwcIB+8NTgiE2XAfbVtF/7wuwNoOaCxwCTb5n1VtBGK0sX12myQFn12pULFlNgyJoP6YzFKxlGQRzFJLQhg3vbOEhzQXZKTL0Dyta07ex9w7h7qqMDgWsz86z7xbflu3iZ3RewOpXyCUtqvPdt6jkFQIeGxnL8IUnrKstbG8=
Received: by 10.49.92.2 with SMTP id u2mr1636635nfl;
        Mon, 08 May 2006 17:53:24 -0700 (PDT)
Received: by 10.49.2.19 with HTTP; Mon, 8 May 2006 17:53:24 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vu080c9uv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19792>

On 5/9/06, Junio C Hamano <junkio@cox.net> wrote:
>
> If you are going to parse it anyway, this would probably be easier.
>
>         $ git show --patch-with-stat --pretty=fuller --parents "$commit"
>
> Why would you want -B, by the way?

What is --parents for ?

Is there a way to have a --pretty=fuller with date append to Author
and Commiter name and email instead of have 1 lign after each ?

--
Beber
#e.fr@freenode
