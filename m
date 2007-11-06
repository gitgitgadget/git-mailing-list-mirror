From: Pascal Obry <pascal@obry.net>
Subject: Re: Git-windows and git-svn?
Date: Tue, 06 Nov 2007 18:52:03 +0100
Organization: Home - http://www.obry.net
Message-ID: <4730A9C3.1090006@obry.net>
References: <fgg6cd$3ep$1@ger.gmane.org> <472BABFA.6030200@obry.net> <A35C7C2D-A829-4A16-B81B-8A6DE01FE5DB@zib.de> <472C211C.90907@obry.net> <EE16FE19-8C6C-4438-8E6E-EA6B87A898A7@zib.de> <72D5CB06-9067-47C4-ABDF-4E1F6F4A679D@zib.de> <472C2FF8.2000603@obry.net> <591E16CE-E303-4971-B57D-D84E883BB01D@zib.de> <Pine.LNX.4.64.0711060857140.8577@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>,
	Abdelrazak Younes <younes.a@free.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Nov 06 18:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpSbI-0002sg-ER
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 18:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509AbXKFRwS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Nov 2007 12:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbXKFRwR
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 12:52:17 -0500
Received: from smtp23.orange.fr ([80.12.242.97]:55590 "EHLO smtp23.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284AbXKFRwR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 12:52:17 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2312.orange.fr (SMTP Server) with ESMTP id CD65C7000093
	for <git@vger.kernel.org>; Tue,  6 Nov 2007 18:52:14 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-79-163.w81-249.abo.wanadoo.fr [81.249.105.163])
	by mwinf2312.orange.fr (SMTP Server) with ESMTP id 729777000088;
	Tue,  6 Nov 2007 18:52:14 +0100 (CET)
X-ME-UUID: 20071106175214469.729777000088@mwinf2312.orange.fr
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0711060857140.8577@ds9.cixit.se>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63691>

Peter Karlsson a =E9crit :
> I got errors almost right away when trying that (I need text mode to
> interface with some other programs), so Cygwin-git is a no-go for me =
at

Won't it be possible for you to have a specific mount point using
textmode and one with binmode ? This should allow you to have the best
of both world. Note that I've never done that so I don't know if it is
working fine.

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
