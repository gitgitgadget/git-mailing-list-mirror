From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn starting with an empty svn repository
Date: Tue, 24 Feb 2009 16:36:35 +0100
Message-ID: <a2633edd0902240736m6b87fd13l22d0420931064f56@mail.gmail.com>
References: <20090224134325.GA10719@mjollnir.org>
	 <a2633edd0902240619v633eacq4ff7ffd20f66da04@mail.gmail.com>
	 <20090224150358.GA18138@mjollnir.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Penny Leach <penny@mjollnir.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:38:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzMH-0003qV-HS
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:38:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789AbZBXPgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 10:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755761AbZBXPgj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:36:39 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:11901 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755749AbZBXPgj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2009 10:36:39 -0500
Received: by ey-out-2122.google.com with SMTP id 25so583930eya.37
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 07:36:36 -0800 (PST)
Received: by 10.210.90.20 with SMTP id n20mr4463095ebb.162.1235489795246; Tue, 
	24 Feb 2009 07:36:35 -0800 (PST)
In-Reply-To: <20090224150358.GA18138@mjollnir.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111296>

Penny,

> Right - and you used this method to import the original history into =
the
> svn-trunk branch, as well as any new patches?

Yes.

> Out of interest - how long is the history you're importing? =A0Mine i=
s about
> 32,000 commits and it takes forever to import into SVN (only to get t=
o a
> broken point and have to start again...)

The repository is having today 28347 commits exactly, so it is close in
size to yours. I have migrated something like 27800 commits initialy,
AFAIR it tooks something like 28 hours to complete.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
