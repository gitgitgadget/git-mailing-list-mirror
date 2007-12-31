From: Pascal Obry <pascal@obry.net>
Subject: Re: How to bypass the post-commit hook?
Date: Mon, 31 Dec 2007 10:50:27 +0100
Organization: Home - http://www.obry.net
Message-ID: <4778BB63.6080908@obry.net>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com> <20071230215008.GB20098@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jan 06 02:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBKPl-0001Dq-Q7
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 02:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbYAFBe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jan 2008 20:34:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752945AbYAFBe2
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 20:34:28 -0500
Received: from smtp2b.orange.fr ([80.12.242.146]:37374 "EHLO smtp2b.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752698AbYAFBe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 20:34:27 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2b21.orange.fr (SMTP Server) with ESMTP id 9C87270F3170
	for <git@vger.kernel.org>; Fri,  4 Jan 2008 17:39:46 +0100 (CET)
Received: from [127.0.0.1] (AVelizy-151-1-103-62.w90-35.abo.wanadoo.fr [90.35.81.62])
	by mwinf2b21.orange.fr (SMTP Server) with ESMTP id 6581077D70D4;
	Mon, 31 Dec 2007 10:50:31 +0100 (CET)
X-ME-UUID: 20071231095032415.6581077D70D4@mwinf2b21.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071230215008.GB20098@efreet.light.src>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69699>

Jan Hudec a =E9crit :
> By the way, what is your post-commit hook doing anyway? Modifying the=
 work
> tree *after* a commit does not sound like a common thing to do.

Or just trigger a build via a built robot or record a commit informatio=
n
into an issue tracker...

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
