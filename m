From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFH] SoC 2012 Guidelines
Date: Sun, 25 Mar 2012 16:45:47 +0100
Message-ID: <201203251745.48858.jnareb@gmail.com>
References: <201203241711.30270.jnareb@gmail.com> <CALUzUxrZibRf5ERgM7QAxsP4QDNZj-RvuLLh0bW5mqMWQnDcig@mail.gmail.com> <4F6F3286.5040803@andrewalker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: =?iso-8859-1?q?Andr=E9_Walker?= <andre@andrewalker.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 17:46:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBpeC-0000D0-Kr
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 17:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756500Ab2CYPpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Mar 2012 11:45:53 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:43834 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab2CYPpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 11:45:52 -0400
Received: by wejx9 with SMTP id x9so3688348wej.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=EtcFjgdjLUiavMWEtd7O9fcDlsMrssaQWTYJ/er48Sk=;
        b=dpUtAyDorWZ+sscgeRGTF9w6aEfrAEnbokzEPvEhPeWihkkTtCl2RNAEwlO6HnVD/I
         RJtw7aSdSh6oQaEcbdBsB59vd7sMHof4yWoGA49kuxzoxomWawTZ56EmyoQNAkE15iX4
         z/qyDLxRQ3hkvm60oSC2UnYLoqOFfgf94tNtutztGAPDycdTMrd2Bf/dn3DoZY/JjScQ
         4dW1WIq+e1br+x3oeprr40eZ73JwVi+6DUEW0xnJLrSPU2hocXRgLYKs2ZLw/Z653wtE
         L3h3DA4JnTvoycQVPOriamN70p2HWg2WRWyU/DCY7qqppAg0dMBU7N8Ys88Im9Ud7IC5
         t/Fg==
Received: by 10.216.134.24 with SMTP id r24mr10575391wei.84.1332690351132;
        Sun, 25 Mar 2012 08:45:51 -0700 (PDT)
Received: from [192.168.1.13] (addd160.neoplus.adsl.tpnet.pl. [79.184.55.160])
        by mx.google.com with ESMTPS id l5sm32848925wia.11.2012.03.25.08.45.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Mar 2012 08:45:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4F6F3286.5040803@andrewalker.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193871>

Andr=E9 Walker wrote:
> On 03/25/2012 03:19 AM, Tay Ray Chuan wrote:
> > 2012/3/25 Jakub Narebski<jnareb@gmail.com>:
> >
> > >   We really should have more ideas, as it looks like students wou=
ld be
> > >   battling for a few projects (I think there are two would-be stu=
dents
> > >   for any proposed project).  Well, too late now.
>
> Right. But would there be room for every student anyhow? Or, at least=
,=20
> would there be room for more students if there were more ideas / proj=
ects?

I don't know the details of how decision is made on how many project
slots a GSoC organization will get, but in earlier GSoC (see Git Wiki)
we get 2 to 6 projects (IIRC).

One limitation is number of possible mentors.
=20
> > Looking through the ideas page on the wiki, it's not that we don't
> > have enough ideas, it's just that students are all "clustering" aro=
und
> > a few proposals (or just one, to be exact).
>
> Which proposal (or proposals) is that?

"Improving parallelism in various commands" (3-4 proposals), "Designing
a faster index format" (2-3 proposals), "Remote helper for Subversion"
(this has 1 proposal I think), "Modernizing and expanding Git.pm"
(2 proposals), "Use JavaScript library / framework in gitweb"
(2 proposals), 'Complete "Linus's ultimate content tracking tool"'
(0.5 proposal).

That is from what I remember, and from public and not so public info
I have available.  There might be dragons^W errors.
=20
> > I wonder if they are aware of this, given that they most probably
> > aren't subscribed to the list and thus wouldn't see "competing"
> > proposals.
>
> Yes, at least I'm aware :) But I think it would be good to everybody =
if=20
> we could manage to get us students to talk and pick one different=20
> proposal each, specially if there is a possibility to get more people=
 to=20
> participate in GSoC for Git.

BTW. according to Google Summer of Code FAQ there can be more than one
student working on the same project.  Though IIRC it never happened in
history of Git participation in GSoC, isn't it?

--=20
Jakub Narebski
Poland
