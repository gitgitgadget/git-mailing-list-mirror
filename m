From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 16:24:30 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610231623340.3962@g5.osdl.org>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>  <453A7D7E.8060105@utoronto.ca>
  <20061022074513.GF29927@artax.karlin.mff.cuni.cz>  <200610221105.26421.jnareb@gmail.com>
  <845b6e870610220256u39d3d06wefd4f71851670812@mail.gmail.com> 
 <87zmbozau2.wl%cworth@cworth.org>  <20061022185350.GW75501@over-yonder.net>
  <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org>  <20061023222131.GB17019@over-yonder.net>
 <ehjgli$lft$1@sea.gmane.org> <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="21872808-1726897703-1161645870=:3962"
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 01:25:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc99v-00022u-No
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 01:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWJWXYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 19:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbWJWXYk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 19:24:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19345 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752019AbWJWXYj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 19:24:39 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9NNOXaX014106
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 Oct 2006 16:24:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9NNOUqg010855;
	Mon, 23 Oct 2006 16:24:31 -0700
To: =?ISO-8859-1?Q?Erik_B=E5gfors?= <zindar@gmail.com>
In-Reply-To: <845b6e870610231614y681e64eu33bb0806f530c742@mail.gmail.com>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29901>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--21872808-1726897703-1161645870=:3962
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 24 Oct 2006, Erik Bågfors wrote:
> 
> I don't see any problem doing a "gitk --all" equivalent in bzr.

The problem? How do you show a commit that is _common_ to two branches, 
but has different revision names in them?

Do you _finally_ see what is so wrong with this whole per-branch naming?

		Linus
--21872808-1726897703-1161645870=:3962--
