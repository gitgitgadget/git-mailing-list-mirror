From: Pascal Obry <pascal@obry.net>
Subject: Re: How to query the version of a file?
Date: Tue, 28 Sep 2010 13:26:53 +0200
Message-ID: <AANLkTi=pTdLA=KerZnNyfWZdWJNHE5xFWarzHQpBpDu_@mail.gmail.com>
References: <AANLkTi=upbiD5EBumxNxG0YvSRZN0mDfvu7LeU0y0Zpw@mail.gmail.com>
	<1285670986056-5578850.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 13:27:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0YLT-0000lp-8U
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 13:27:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab0I1L1S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Sep 2010 07:27:18 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42984 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab0I1L0y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Sep 2010 07:26:54 -0400
Received: by qwh6 with SMTP id 6so4032577qwh.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 04:26:53 -0700 (PDT)
Received: by 10.229.246.194 with SMTP id lz2mr6998788qcb.216.1285673213415;
 Tue, 28 Sep 2010 04:26:53 -0700 (PDT)
Received: by 10.229.29.148 with HTTP; Tue, 28 Sep 2010 04:26:53 -0700 (PDT)
In-Reply-To: <1285670986056-5578850.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157408>

On Tue, Sep 28, 2010 at 12:49 PM, sandy2010 <sandeeptt@yahoo.com> wrote=
:
> I do not see the reply to this thread. I'm unable to find how to find=
 the
> version of a checked out file? Also, how do I view an older version?

No response probably because there is no notion of version of a file in=
 Git.

Each commit is uniquely identified (SHA-1). A file is part of a commit.

I would recommend to read some Git tutorials, books that can be found
on the Web. See Git wiki, or the online Pro Git book:

   http://progit.org/book/

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 T=
eam-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|=A0 =A0 =A0 =A0 =A0 =A0 =A0 http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
