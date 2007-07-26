From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 07:29:06 -0400
Message-ID: <fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
	 <a1bbc6950707251926t11e1d0f7p8e8cd8c936f7ff72@mail.gmail.com>
	 <7vps2fc196.fsf@assigned-by-dhcp.cox.net>
	 <20070726031838.GO32566@spearce.org>
	 <7v6447bxc1.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0707260614500.14781@racer.site>
	 <46A8378A.6050201@xs4all.nl>
	 <Pine.LNX.4.64.0707260737170.14781@racer.site>
	 <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Dmitry Kakurin" <dmitry.kakurin@gmail.com>
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Thu Jul 26 13:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE1Wr-0004gZ-UW
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 13:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758558AbXGZL3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 07:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758407AbXGZL3K
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 07:29:10 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:58429 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758358AbXGZL3I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 07:29:08 -0400
Received: by wx-out-0506.google.com with SMTP id h31so444616wxd
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 04:29:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nFttd0ut+oZaCe/yfo889yUDyI4U1mrZCRCxPpvkuoUg2nEBz8BzmIbOWkk/vs84Bg0Cc633utO6GH8aTwFSsd7HLX0xTfyrjWTSgtnFjbGk7D5Ql7JAyvPfm31FyXd5Fek5MkOXuHcEgmQlPW6gjzSW1TKJzSZRwJrWQyo3FUs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mLfHeuaxSKhwhtomZNr09F9X0vVeFvYI35iR1VINyczSA1lftA/SE4RsTNPi2raPgqxOMgj0OC5VEfRAj+xwsyY+ttllimY1sdqGhKXJ66LEg4taeJ5AkD45JVFSePL8UBnXrK8c6SpS5DBIveTzrAhtIQiipvtMWTSZU34nAcE=
Received: by 10.100.11.7 with SMTP id 7mr1099557ank.1185449346939;
        Thu, 26 Jul 2007 04:29:06 -0700 (PDT)
Received: by 10.100.127.17 with HTTP; Thu, 26 Jul 2007 04:29:06 -0700 (PDT)
In-Reply-To: <f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53819>

On 7/26/07, Han-Wen Nienhuys <hanwenn@gmail.com> wrote:
> 2007/7/25, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Hi,
> >
> > [Funny, you quoted me, but culled _me_ from the Cc: list]
>
> It's because gmane does not do SMTP
>
> > > If you supply me with a shell script that will x-compile bash, I'll
> > > hapily code the python spec. IMO the real problem is that bash is a unix
> > > shell (tied to unix internals) and therefore, compiling it for something
> > > as horrid as windows is far from trivial.
> >
> > Will do.
> >
> > Did you succeed in adding perl?
>
> God forbid no. Perl is enormous, and I shudder at the thought of
> making all those modules compile, or even worse, writing actual perl
> code.

microperl [1] maybe? I haven't tried it yet.

[1] http://www.foo.be/docs/tpj/issues/vol5_3/tpj0503-0003.html
-- 
Duy
