From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 09:18:47 +0100
Message-ID: <81b0412b0701180018i208e4158k2dd3e9ecdfa79b13@mail.gmail.com>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	 <87ps9d7j6t.fsf@morpheus.local>
	 <7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	 <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	 <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
	 <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
	 <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com>
	 <20070118080613.GE23124@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Josh Boyer" <jwboyer@gmail.com>, git@vger.kernel.org,
	davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 09:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7SUU-0001Dl-N0
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 09:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbXARITV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 03:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbXARITV
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 03:19:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.233]:44845 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbXARITU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 03:19:20 -0500
Received: by wr-out-0506.google.com with SMTP id i22so102180wra
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 00:19:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d+qqDSLfteZezn25s5651eDcCSB5k1b87rxDXOIx6VZVmDZ0m1UKvrPbTXpyZZm/2ZrPph15n7DSj1yWx8yKtEu3ofQtOtE+fkZDV1+dWncFYa4KOJftF8A7NSezGgF+RQomFfDs5yEyuzVTBKrocB1baUtZRBK2JGtQ1FdWvwo=
Received: by 10.78.181.13 with SMTP id d13mr589015huf.1169108327630;
        Thu, 18 Jan 2007 00:18:47 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 18 Jan 2007 00:18:47 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118080613.GE23124@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37067>

On 1/18/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > Also, how many mail clients know that .patch is actually
> > a text and not application/binary? It'll make patch
> > reviewing harder for some (not sure if I'd like a review
> > of such a person, though).
>
> Patches intended for review should be sent inline, not attached.

There is again this word "should". Are you sure it has any _real_
meaning? For a person who knows about revision management
from something like Perforce?

> Thus the file extension has no impact on how the mail client should
> treat it.

He will attach it. It's typical for outlook users. He will even put it
in HTML-formatted mail, because that's the default format for
outlook messages.

> Don't count people out just because they cannot read a *.patch file

I don't. I just know how hard is it to explain what source is and
why it is better than a "C++ file".

> All constructive feedback is valuable, no matter its source.  Of
> course I did qualify that with "constructive"... ;-)

It is. That's why I did try to explain it to some. That's how I know
about explaining. I'm very pessimistic now, sorry.
