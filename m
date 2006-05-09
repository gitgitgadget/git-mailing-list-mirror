From: "Bertrand Jacquin" <beber.mailing@gmail.com>
Subject: Re: git-feed-mail-list.sh
Date: Tue, 9 May 2006 02:55:48 +0200
Message-ID: <4fb292fa0605081755m22e8239cjda0b1ac74b84c0d9@mail.gmail.com>
References: <1146678513.20773.45.camel@pmac.infradead.org>
	 <7vmzdy9zl2.fsf@assigned-by-dhcp.cox.net>
	 <1147131877.2694.37.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "David Woodhouse" <dwmw2@infradead.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 02:55:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdGW1-0006zR-Gt
	for gcvg-git@gmane.org; Tue, 09 May 2006 02:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058AbWEIAzv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 May 2006 20:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWEIAzv
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 20:55:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:54382 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751047AbWEIAzu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 May 2006 20:55:50 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1088084nfe
        for <git@vger.kernel.org>; Mon, 08 May 2006 17:55:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RrC+QgjGLWCmYar1jOTSTA888U/HPYIoy288uDrtNgg8ZdWYbVdPIvfKCDzJU8yFyQWxK2if7Ij9g5HoFr8UiIp32oHQhV6+bO1lZBJ8jJ/XfOGcbBcQcxw+bTiFX9ARNrxJeB4TYqMBCopO5NNr/itsk0wou2OuA4St1nAJxVM=
Received: by 10.48.162.20 with SMTP id k20mr1632754nfe;
        Mon, 08 May 2006 17:55:48 -0700 (PDT)
Received: by 10.49.2.19 with HTTP; Mon, 8 May 2006 17:55:48 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605081715270.3718@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19795>

On 5/9/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> Ie you could probably more easily parse the data from something like
>
>         git show -B --patch-with-stat --pretty=fuller $commit
>

Is there a way to track merge like that ? Documentation is not very
clear and near from empty.

--
Beber
#e.fr@freenode
