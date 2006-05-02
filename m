From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: cg-mkpatch use case
Date: Wed, 3 May 2006 10:19:00 +1200
Message-ID: <46a038f90605021519x5ee680b0v78dd5c092e1b191f@mail.gmail.com>
References: <44570E8E.5070402@itaapy.com> <20060502215703.GK27689@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Belmar-Letelier <luis@itaapy.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 03 00:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fb3D7-0005O8-SX
	for gcvg-git@gmane.org; Wed, 03 May 2006 00:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWEBWTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 18:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWEBWTB
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 18:19:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:12048 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S965018AbWEBWTA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 May 2006 18:19:00 -0400
Received: by wr-out-0506.google.com with SMTP id 58so20050wri
        for <git@vger.kernel.org>; Tue, 02 May 2006 15:19:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=k6Ybl5C7HoD0bpM94wvJLGPHca1L2g7foNkcw3R5E1qjy6QztsYUMYffLcBKBwIVmkP/Wj77n9J8BGz5q4cNFaD+N+gQX5IrdHfTA3BSZC24iKmGTtTc+FemErQm98SioG87mG3U5cUsWp0Ek98xiXl38/sFDaFAjcpbtfspPMw=
Received: by 10.54.71.3 with SMTP id t3mr276249wra;
        Tue, 02 May 2006 15:19:00 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Tue, 2 May 2006 15:19:00 -0700 (PDT)
To: "Petr Baudis" <pasky@suse.cz>
In-Reply-To: <20060502215703.GK27689@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19433>

On 5/3/06, Petr Baudis <pasky@suse.cz> wrote:
> not many people actually use it nowadays, I believe. You can apply it
> back using cg-patch (or even patch itself, or git-apply if you are
> lucky), but it won't automagically extract the commit message and
> authorship information.

Erm... I don't personally use it, but cg-patch --long-help tells me...

-c::
        Automatically extract the commit message and authorship information
        (if provided) from the patch and commit it after applying it
        successfuly.

Truth in advertising? ;-)

cheers,


martin
