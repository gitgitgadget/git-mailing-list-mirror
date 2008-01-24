From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Check for -amend as a common wrong usage of --amend.
Date: Thu, 24 Jan 2008 20:35:25 +0100
Organization: Home - http://www.obry.net
Message-ID: <4798E87D.8030701@obry.net>
References: <1201198439-3516-1-git-send-email-pascal@obry.net> <alpine.LSU.1.00.0801241818441.5731@racer.site> <4798DE6A.1050201@obry.net> <20080124192532.GA3389@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pascal Obry <pascal.obry@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:36:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI7sF-0004Ko-UK
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 20:36:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756661AbYAXTfh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 14:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756640AbYAXTfc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 14:35:32 -0500
Received: from smtp2e.orange.fr ([80.12.242.111]:14528 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756632AbYAXTf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 14:35:29 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e28.orange.fr (SMTP Server) with ESMTP id D484270007ED
	for <git@vger.kernel.org>; Thu, 24 Jan 2008 20:35:27 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-7-190.w82-120.abo.wanadoo.fr [82.120.149.190])
	by mwinf2e28.orange.fr (SMTP Server) with ESMTP id 73FE67000456;
	Thu, 24 Jan 2008 20:35:27 +0100 (CET)
X-ME-UUID: 20080124193527475.73FE67000456@mwinf2e28.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20080124192532.GA3389@hashpling.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71654>

Charles Bailey a =E9crit :
> Would this be better handled by a commit-msg hook.  E.g.:

I do not agree. Why check this late as this option is boggus? And=20
furthermore I do not want to have to install this commit message hook i=
n=20
all my Git repositories.

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
