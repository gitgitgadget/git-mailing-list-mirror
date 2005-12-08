From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] gitk: add Update menu item.
Date: Thu, 8 Dec 2005 08:52:42 +0100
Message-ID: <81b0412b0512072352q6ceaee16l8599b12b56fa112f@mail.gmail.com>
References: <20051123222003.GA16290MdfPADPa@greensroom.kotnet.org>
	 <20051129211551.GF8383MdfPADPa@greensroom.kotnet.org>
	 <17294.58317.317337.145932@cargo.ozlabs.ibm.com>
	 <20051201130724.GV8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Dec 08 08:53:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkGa7-0004YB-Al
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 08:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbVLHHwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 02:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVLHHwo
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 02:52:44 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:26235 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750722AbVLHHwo convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 02:52:44 -0500
Received: by nproxy.gmail.com with SMTP id x29so176989nfb
        for <git@vger.kernel.org>; Wed, 07 Dec 2005 23:52:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mJ3yz9lepF1i3i1RJlU+miG0+Bb53TVC3enQBt1DU6TLTh3TMgKU603rRp7EC2olprWzWhMpCHhZMfAPy2uqUke4/CiJSAAKMc8EUVlLHVKQwDqhJs9v+TVvXD8c1RqEu7A4gpr6v3Z/i0LfAoSUAzi62R1COAfizWYNZE4gHsU=
Received: by 10.49.2.16 with SMTP id e16mr204342nfi;
        Wed, 07 Dec 2005 23:52:42 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Wed, 7 Dec 2005 23:52:42 -0800 (PST)
To: skimo@liacs.nl, Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <20051201130724.GV8383MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13362>

On 12/1/05, Sven Verdoolaege <skimo@kotnet.org> wrote:
> > I tried removing some commits (using git reset --hard) and then doing
> > selecting update from the menu, and it redrew everything, but the
> > removed commits were still shown.
>
> Hmmm...  I'll have look at this over the weekend (unless you beat
> me to it).

Also the removed references are not removed.
