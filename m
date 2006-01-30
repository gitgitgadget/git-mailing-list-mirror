From: Hendrik Visage <hvjunk@gmail.com>
Subject: Re: git vs git
Date: Mon, 30 Jan 2006 18:09:47 +0200
Message-ID: <d93f04c70601300809v2f18221bxb4ddb495a6f2f47f@mail.gmail.com>
References: <d93f04c70601300714i4b7b3b58qa5aa151e3e42a413@mail.gmail.com>
	 <20060130153715.GE30671@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: david@dgreaves.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 17:10:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3bbI-0005vh-Au
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 17:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWA3QJu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 11:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWA3QJu
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 11:09:50 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:34388 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932353AbWA3QJu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 11:09:50 -0500
Received: by uproxy.gmail.com with SMTP id h2so558680ugf
        for <git@vger.kernel.org>; Mon, 30 Jan 2006 08:09:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PvaRjnU89uZ3oJyJTXSwwZKDekrdxNM01e6LX/xLPqyAbNrv47GO/M8XtCIksFh3+CRAi43DJShh02J9UgvonbdOVLHpijBAnpw5VrlUHrhsGUfZ2Js5aUtl/RGZb9I9NlxPgtuaicIZbTw/PR0MtLCfxK9Z/+Y3T1QKx3iX6BQ=
Received: by 10.67.26.19 with SMTP id d19mr2754874ugj;
        Mon, 30 Jan 2006 08:09:47 -0800 (PST)
Received: by 10.66.250.17 with HTTP; Mon, 30 Jan 2006 08:09:47 -0800 (PST)
To: Erik Mouw <erik@harddisk-recovery.com>
In-Reply-To: <20060130153715.GE30671@harddisk-recovery.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15279>

On 1/30/06, Erik Mouw <erik@harddisk-recovery.com> wrote:
>
> Yes, this has been discussed in the past.

Hmm... liked to know the search terms to use :(

> GNU git development is dead. The last release is from March 13, 2000.

That doesn't mean it's not used extensively :)

> > Could the name git perhaps be reconsideredto something like SCT? or GnuSCT?
>
> I don't think that will happen. The number of source control git users
> outnumbers the number of GNU git users, so consider it a lost case.

Okay, this is the point where the "number of git developers outnumber the number
of GNU git developers" is more correct :(

> > Just asking, as it do cause hassles when an environment is using git
> > and suddenly
> > need to load git to download newer drivers etc. and then git isn't
> > working because the wrong git is in the right place :(
>
> I think we found the only GNU git user in the world! ;-)

You might be surprised, it much nicer IMO than mc

> A simple workaround would be to install git in a directory not in your
> path and put a shell script "sct" in your path that just calls git.
> Something like (untested):

The problem is that the distro people are having troubles deciding how to
make this work and us users are having to suffer this :(

Actually it's at the point where I can't use/install cogito because I
already have GNU git installed, and the name clashes... so I can't do
disecting searches on my AMD64 with problems in a certain device
driver since 2.6.13 :(

--
Hendrik Visage
