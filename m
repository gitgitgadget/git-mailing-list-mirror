From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Does Git run on Windows ?
Date: Thu, 6 Jul 2006 14:56:04 +1200
Message-ID: <46a038f90607051956w72c5e662g72feb242795e61c4@mail.gmail.com>
References: <01c001c6a0a7$a2783f90$0200a8c0@AMD2500>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 06 04:56:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyK2F-0004jd-6B
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 04:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965142AbWGFC4H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 22:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965140AbWGFC4H
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 22:56:07 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:13347 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965142AbWGFC4G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jul 2006 22:56:06 -0400
Received: by nf-out-0910.google.com with SMTP id x4so85986nfb
        for <git@vger.kernel.org>; Wed, 05 Jul 2006 19:56:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tgs1apu0+GIQTZAHP9eWSBdf24SgprT+xvv+OtNKfzvvAb074Xu3AwKRrmdgiUKtaqhRr+bOfRz9vLLMJK0FpIzApq2Jc0w6WtwEokOm4UercxNYSC8cZv9RVqNA7ZUix53okG06t+EAUQC+B/LoJK0c3SjCOeA1daMefSDV3DE=
Received: by 10.78.97.7 with SMTP id u7mr20293hub;
        Wed, 05 Jul 2006 19:56:04 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Wed, 5 Jul 2006 19:56:04 -0700 (PDT)
To: "Aaron Gray" <angray@beeb.net>
In-Reply-To: <01c001c6a0a7$a2783f90$0200a8c0@AMD2500>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23370>

On 7/6/06, Aaron Gray <angray@beeb.net> wrote:
> This maybe a stupid question but does Git run on Windows ?

Ask google :-) - try "git cygwin" - or look at the git wiki.

> Are there better options ?

Mercurial is quite similar (though not as fast), and may have an
easier time on Windows. Not 100% sure about that.

> This maybe the crunch and reason to use CVS for now :(?)

If you are only supporting some users on Windows, you may be able to
use git-cvsserver for them. Looks like a cvsserver but it is a GIT
repository ;-)

cheers,



martin
