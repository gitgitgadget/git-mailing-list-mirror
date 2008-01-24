From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Thu, 24 Jan 2008 19:52:26 +0100
Organization: Home - http://www.obry.net
Message-ID: <4798DE6A.1050201@obry.net>
References: <1201198439-3516-1-git-send-email-pascal@obry.net> <alpine.LSU.1.00.0801241818441.5731@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 19:53:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7CC-0004U6-H7
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbYAXSwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 13:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbYAXSwb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:52:31 -0500
Received: from smtp28.orange.fr ([80.12.242.99]:13146 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753201AbYAXSwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:52:30 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2801.orange.fr (SMTP Server) with ESMTP id 274497000139
	for <git@vger.kernel.org>; Thu, 24 Jan 2008 19:52:29 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-7-190.w82-120.abo.wanadoo.fr [82.120.149.190])
	by mwinf2801.orange.fr (SMTP Server) with ESMTP id D58F870000A7;
	Thu, 24 Jan 2008 19:52:28 +0100 (CET)
X-ME-UUID: 20080124185228874.D58F870000A7@mwinf2801.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0801241818441.5731@racer.site>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71648>

Johannes Schindelin a =E9crit :
> That is ugly.  In a source file which is by no means specific to=20
> git-commit, you cannot possibly mean to check for "amend".

Agreed :( I'll try to come with something better.

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
