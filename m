From: Hendrik Visage <hvjunk@gmail.com>
Subject: Re: git vs git
Date: Tue, 31 Jan 2006 07:05:55 +0200
Message-ID: <d93f04c70601302105v426201dbhac6abd41cdc4050c@mail.gmail.com>
References: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com>
	 <46a038f90601301216n793f0eb5k34a2b5a7c4e7491e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@dgreaves.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 06:06:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3niX-00007t-7i
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 06:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030336AbWAaFF6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 00:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWAaFF6
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 00:05:58 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:54964 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030336AbWAaFF5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 00:05:57 -0500
Received: by uproxy.gmail.com with SMTP id s2so121400uge
        for <git@vger.kernel.org>; Mon, 30 Jan 2006 21:05:56 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gW2hx6wMoGNcAg2LDcOTJ2Q1oflO77CJUmaJc4EbJva8VDHwI0qo0ugEgnCU5RXS6htVUcnClhcFZsN6vkSzIawHja469ysWfs9IZfYpSohQuieZAByWRM9hlx8/TcCGEZ/nzTjiKTIgBU5dKI6YxWUuD7hfav2XX4ug0HKtTZM=
Received: by 10.66.244.10 with SMTP id r10mr1611002ugh;
        Mon, 30 Jan 2006 21:05:55 -0800 (PST)
Received: by 10.66.250.17 with HTTP; Mon, 30 Jan 2006 21:05:55 -0800 (PST)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601301216n793f0eb5k34a2b5a7c4e7491e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15301>

On 1/30/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 1/31/06, Hendrik Visage <hvjunk@gmail.com> wrote:
> > git isn't
> > working because the wrong git is in the right place :(
>
> Well, I just hit this yesterday on a colleage's machine who was trying
> to get going with git.His first try was to `apt-get install git` and
> as that didn't lead anywhere he fetched the git (scm) sources and
> built them.
>
<snip>

> Not sure how to deal with this. Packages already record (or can
> record) it as a conflict, but source built stuff is different. Perhaps
> during `make install` we should try and exec git --version towards the
> end and print a big fat warning?

Or stop the egos and do a name change as would be the honourable way
especially as gitscm is less than a year old...

--
Hendrik Visage
