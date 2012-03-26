From: Kevin <compufreak@gmail.com>
Subject: Re: [RFH] SoC 2012 Guidelines
Date: Mon, 26 Mar 2012 10:55:26 +0200
Message-ID: <20120326072409.GA2801@ikke-laptop.buyways.nl>
References: <201203241711.30270.jnareb@gmail.com>
 <CALUzUxrZibRf5ERgM7QAxsP4QDNZj-RvuLLh0bW5mqMWQnDcig@mail.gmail.com>
 <4F6F3286.5040803@andrewalker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: =?iso-8859-1?Q?Andr=E9?= Walker <andre@andrewalker.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 10:55:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC5iD-0008HN-Kn
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 10:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab2CZIzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Mar 2012 04:55:32 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64032 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab2CZIzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 04:55:31 -0400
Received: by eaaq12 with SMTP id q12so1445931eaa.19
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 01:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=H12EL6JLWYhzl9ySeOWw8PBOllbhtZsXhIwpASWjmQ0=;
        b=E5PZ8TPmVoel9HASHHJX4VDabSJFY9CXOSqM8cAVwRw8tAykumajTEAvG41zJWitel
         zJewNoSO+AE6SOds4BZ0iK1nT7iBTEFaMUBEBaZLTRlQR5oMYWTCPeGVEacpnK2IS7No
         tXEv+fVBwdEo/n3OoBw8/ah1SjyoS7LjFTS/MA+vSgZehtY8cIQqWA4imNS+DTnDDK9U
         FTGs7GG7Z99mxEO/V0dV2erf7wvA2N7fVg5D5U17GvRwtLvLYoxI2//sV7gX7tioyKf1
         yocVqLYKXsVmN//HIMX63dbLr+k6OHWWj2MbYdR7Pgg3d4QPMtz89QJ+BC07/+LYFkqe
         XlUg==
Received: by 10.213.13.72 with SMTP id b8mr1456946eba.153.1332752130412;
        Mon, 26 Mar 2012 01:55:30 -0700 (PDT)
Received: from localhost (D4B2749A.static.ziggozakelijk.nl. [212.178.116.154])
        by mx.google.com with ESMTPS id p57sm56099010eei.8.2012.03.26.01.55.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 01:55:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F6F3286.5040803@andrewalker.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193900>

Most people go for improving the index, some with parallelisation and o=
ne
or two choose for js improvements for git web.

On Sun, Mar 25, 2012 at 11:58:14AM -0300, Andr=E9 Walker wrote:
> On 03/25/2012 03:19 AM, Tay Ray Chuan wrote:
> >2012/3/25 Jakub Narebski<jnareb@gmail.com>:
> >>  We really should have more ideas, as it looks like students would=
 be
> >>  battling for a few projects (I think there are two would-be stude=
nts
> >>  for any proposed project).  Well, too late now.
> Right. But would there be room for every student anyhow? Or, at
> least, would there be room for more students if there were more
> ideas / projects?
>=20
> >Looking through the ideas page on the wiki, it's not that we don't
> >have enough ideas, it's just that students are all "clustering" arou=
nd
> >a few proposals (or just one, to be exact).
> Which proposal (or proposals) is that?
>=20
> >I wonder if they are aware of this, given that they most probably
> >aren't subscribed to the list and thus wouldn't see "competing"
> >proposals.
> Yes, at least I'm aware :) But I think it would be good to everybody
> if we could manage to get us students to talk and pick one different
> proposal each, specially if there is a possibility to get more
> people to participate in GSoC for Git.
>=20
> Cheers
> Andr=E9
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
