X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 14:41:23 +0200
Message-ID: <453F5B73.2050504@op5.se>
References: <20061022074513.GF29927@artax.karlin.mff.cuni.cz>	 <87zmbozau2.wl%cworth@cworth.org>	 <20061022185350.GW75501@over-yonder.net>	 <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>	 <20061023222131.GB17019@over-yonder.net> <ehjgli$lft$1@sea.gmane.org>	 <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>	 <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>	 <20061024002657.GD17019@over-yonder.net>	 <87y7r6zgic.wl%cworth@cworth.org> <845b6e870610241451x578efe9n77017f3a9404e81c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 12:41:52 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <845b6e870610241451x578efe9n77017f3a9404e81c@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30056>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gci4a-0005Gv-Qn for gcvg-git@gmane.org; Wed, 25 Oct
 2006 14:41:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964796AbWJYMl3 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 08:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964802AbWJYMl3
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 08:41:29 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:58815 "EHLO
 smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964796AbWJYMl2 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 08:41:28 -0400
Received: by smtp-gw1.op5.se (Postfix, from userid 588) id 30D2F6BCDB; Wed,
 25 Oct 2006 14:41:27 +0200 (CEST)
Received: from [192.168.1.20] (unknown [213.88.215.14]) by smtp-gw1.op5.se
 (Postfix) with ESMTP id 99FB96BD3B; Wed, 25 Oct 2006 14:41:23 +0200 (CEST)
To: =?ISO-8859-15?Q?Erik_B=E5gfors?= <zindar@gmail.com>
Sender: git-owner@vger.kernel.org

Erik B=E5gfors wrote:
>=20
> Creates the picture you can see at
> http://erik.bagfors.nu/bzr-plugins/dotrepo.png
>=20

Looking at this picture, I found a very annoying thing with bzr's=20
revids: For commits from the same author on the same day, they don't=20
differ in the beginning, making all of them, at a glance, look the same=
=2E=20
I got a headache just trying to figure out how to read them. It might b=
e=20
worth looking into in the future, especially if you decide to show them=
=20
to the users.

Perhaps it's just my git eyes being used to seeing the first 4 chars=20
(which is all I normally look at) being different for each different=20
commit, but having to look up the near-end of the string to find the=20
actual difference in bzr's revids was actually a quite painful experien=
ce.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
