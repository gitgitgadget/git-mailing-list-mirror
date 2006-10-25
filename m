X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Wed, 25 Oct 2006 14:41:05 -0400
Message-ID: <453FAFC1.2040801@utoronto.ca>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<453A7D7E.8060105@utoronto.ca>	<20061022074513.GF29927@artax.karlin.mff.cuni.cz>	<200610221105.26421.jnareb@gmail.com>	<845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> 	<87zmbozau2.wl%cworth@cworth.org>	<20061022185350.GW75501@over-yonder.net>	<Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>	<20061023222131.GB17019@over-yonder.net>	<ehjgli$lft$1@sea.gmane.org>	<845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com> <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Wed, 25 Oct 2006 18:41:31 +0000 (UTC)
Cc: =?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
In-Reply-To: <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
X-Enigmail-Version: 0.91.0.0
X-Panometrics-MailScanner: Found to be clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30089>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcngl-00078q-79 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 20:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932272AbWJYSlP convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006 14:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWJYSlP
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 14:41:15 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]:14236 "EHLO
 server4.panoramicfeedback.com") by vger.kernel.org with ESMTP id
 S932272AbWJYSlO (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006
 14:41:14 -0400
Received: from server4.panoramicfeedback.com ([66.216.124.41]
 helo=[192.168.2.19]) by server4.panoramicfeedback.com with esmtp (Exim 3.36
 #1 (Debian)) id 1Gcnga-0002zs-00; Wed, 25 Oct 2006 14:41:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Linus Torvalds wrote:
>=20
> On Tue, 24 Oct 2006, Erik B=E5gfors wrote:
>=20
>>I don't see any problem doing a "gitk --all" equivalent in bzr.
>=20
>=20
> The problem? How do you show a commit that is _common_ to two branche=
s,=20
> but has different revision names in them?

If you're talking about the old-style single-integer revnos, each
revision only has one of those, because that revision dictates the path
you must take to the origin when determining its revno.  Many others ma=
y
share that revno, but each revision has only one.

The new-style dotted-series-of-ints revnos, I agree, will change.
They're not something I use.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFFP6/B0F+nu1YWqI0RAs76AJ9nE4BnL2tLDPQwqjQvCi6okDTdpQCdFQ9V
GoL1BWO+L2FxjLjRrCjKtuY=3D
=3DyQ6t
