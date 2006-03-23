From: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: Who do I report bugs in the git source web browser thing to?
Date: Thu, 23 Mar 2006 10:51:52 -0600
Message-ID: <625fc13d0603230851r54557c4ai5e65c04fef2bffe5@mail.gmail.com>
References: <200603231143.17762.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 17:53:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMT2u-00029f-Vl
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 17:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWCWQv6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Mar 2006 11:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbWCWQv5
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Mar 2006 11:51:57 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:18161 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751299AbWCWQvx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Mar 2006 11:51:53 -0500
Received: by wproxy.gmail.com with SMTP id 69so491075wra
        for <git@vger.kernel.org>; Thu, 23 Mar 2006 08:51:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SDXksadaPtIl5kWEqtOKWy4875u8OfaL/1ZKSq8geenqrs+59vkJHgq5DSoI8DvtVZHhEfH7E1XxDptvpivD14qNl2l04SznIf2gOywElMO3veZwlhSw2ZV0efzZqTyeb5B8AKCUbfTC4cLc7tfIweCYDJcXF1JNKn2M3oG81cA=
Received: by 10.54.143.9 with SMTP id q9mr1420638wrd;
        Thu, 23 Mar 2006 08:51:52 -0800 (PST)
Received: by 10.54.66.5 with HTTP; Thu, 23 Mar 2006 08:51:52 -0800 (PST)
To: "Rob Landley" <rob@landley.net>
In-Reply-To: <200603231143.17762.rob@landley.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17862>

On 3/23/06, Rob Landley <rob@landley.net> wrote:
> When I go to kernel.org, click the tiny C next to linus's name to get the git
> browser for the tree, click "tree", click the "usr" directory, and then click
> "history" next to the file gen_init_cpio.c, it says this file appeared out of
> thin air 59 minutes ago.
>
> This is not the case.

Linus' tree only goes back to 2.6.12 or so.  I think you're just
seeing the fact that it's the first commit to that file since it was
initially imported.

josh
