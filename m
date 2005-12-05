From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 7/9] Add the accurate changeset applyer
Date: Mon, 5 Dec 2005 18:53:19 +0000
Message-ID: <46a038f90512051053p66923112l237e4ab80ecb0cca@mail.gmail.com>
References: <46a038f90511170126l5f04f4e0ta578fc2cb375db68@mail.gmail.com>
	 <20051124074739.GB4789@mail.yhbt.net>
	 <20051124074857.GC4789@mail.yhbt.net>
	 <20051124075027.GD4789@mail.yhbt.net>
	 <20051124075133.GE4789@mail.yhbt.net>
	 <20051124075243.GF4789@mail.yhbt.net>
	 <20051124075355.GG4789@mail.yhbt.net>
	 <20051124075504.GH4789@mail.yhbt.net>
	 <46a038f90512010902lb11c326p99af9ff99dacf9b4@mail.gmail.com>
	 <20051203025150.GA13179@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>,
	Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Dec 05 19:53:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjLSp-000496-WE
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 19:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbVLESxW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 13:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVLESxW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 13:53:22 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:21801 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751411AbVLESxV convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 13:53:21 -0500
Received: by wproxy.gmail.com with SMTP id i32so86057wra
        for <git@vger.kernel.org>; Mon, 05 Dec 2005 10:53:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZWNKt4IeQo/C70cpbOorQs9uqgWiTSekImNUjyOuZkQqJinLxFtlQj/PflrvuF8pe38THavW/WGMqAZ9NjuAAbctQ44NmQLvflC9yYcx70JjMo8D/CNdIiahzaPhkmcoxm5vcelLb7hg8U0gGmRgkonWla4P5kpN6l4OxwlQo70=
Received: by 10.64.150.8 with SMTP id x8mr3089627qbd;
        Mon, 05 Dec 2005 10:53:19 -0800 (PST)
Received: by 10.64.242.12 with HTTP; Mon, 5 Dec 2005 10:53:19 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051203025150.GA13179@mail.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13222>

On 12/3/05, Eric Wong <normalperson@yhbt.net> wrote:
> Rerunning it doesn't seem to pull anymore.  IIRC, My previous times
> only imported around ~150 patchsets.  The time it took to run this
> was certainly longer than the last run (~4 hours here, vs ~2 hours
> I mentioned in <20051124074605.GA4789@mail.yhbt.net>, so there may
> be a bug somewhere...  Unfortunately, I no longer have those old
> trees around.
>
> I've imported several trees with >1000 revisions without problems,
> mpd-uclinux is among them:
>
> http://mpd.bogomips.org/mpd-uclinux.git/

Haven't been able to retest an import and have it finished without my
ssh session dropping (should have used gnu screen). I'll be able to
test it more thoroughly in a couple of days. Very sorry about the
delay.

cheers,



martin
