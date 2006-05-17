From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [ANNOUNCE] tig - text-mode interface for git
Date: Wed, 17 May 2006 16:53:05 +0300
Message-ID: <20060517165305.07b682b2.tihirvon@gmail.com>
References: <20060517120733.GA14041@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 15:51:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgMQp-00073r-Hg
	for gcvg-git@gmane.org; Wed, 17 May 2006 15:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWEQNvR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 09:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932559AbWEQNvQ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 09:51:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:46208 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932553AbWEQNvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 May 2006 09:51:16 -0400
Received: by nf-out-0910.google.com with SMTP id d4so168435nfe
        for <git@vger.kernel.org>; Wed, 17 May 2006 06:51:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=VFqd8GThRHzGXg4JY0sf42R1+1Q7iEOj5yU7vt2ZCPoarEAsXsQTZT6HxnemLm+cIi0z64f9a9oQb7AY6LfYVCNWGvYiOWQ0j7QkGWAESqaGgTzHj2+OWpB/I62Om2avcUrJdmpEpbyVG+zfqFflxioRrBi9DoWGcXYNCY3dJco=
Received: by 10.48.202.2 with SMTP id z2mr770393nff;
        Wed, 17 May 2006 06:51:11 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id r34sm2105486nfc.2006.05.17.06.51.10;
        Wed, 17 May 2006 06:51:11 -0700 (PDT)
To: fonseca@diku.dk
In-Reply-To: <20060517120733.GA14041@diku.dk>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jonas Fonseca <fonseca@diku.dk> wrote:

> Hello,
> 
> I am pleased to announce tig, a simple git repository browser written
> using ncurses. Basically, it just acts as a front-end for git-log and
> git-show/git-diff. Additionally, you can also use it as a pager for git
> commands.
> 
> Currently, it just provides a minimum support for looking through
> changes. I hope to slowly extend it to also be usable as a front-end for
> git-blame and for tree browsing. Also, it doesn't do any fancy revision
> graph rendering, but I want to at least give it a shot at some point. :)

Thanks.  This makes browsing repositories much easier.  It would be
great if the colors were customizable.

-- 
http://onion.dynserv.net/~timo/
