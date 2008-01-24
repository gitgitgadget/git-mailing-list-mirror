From: Pascal Obry <pascal@obry.net>
Subject: Re: Stripping 'git-svn-id' from commit messages, and switching to
 svn.noMetadata
Date: Thu, 24 Jan 2008 18:36:08 +0100
Organization: Home - http://www.obry.net
Message-ID: <4798CC88.505@obry.net>
References: <877ii0p89b.fsf@adler.orangeandbronze.com> <4797D6C6.207@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: JM Ibanez <jm@orangeandbronze.com>, git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jan 24 18:36:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI60R-0007Oq-3s
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 18:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbYAXRgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 12:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754352AbYAXRgS
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 12:36:18 -0500
Received: from smtp2f.orange.fr ([80.12.242.152]:24968 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291AbYAXRgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 12:36:17 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id C78D67000110
	for <git@vger.kernel.org>; Thu, 24 Jan 2008 18:36:12 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-7-190.w82-120.abo.wanadoo.fr [82.120.149.190])
	by mwinf2f18.orange.fr (SMTP Server) with ESMTP id 6BD9470000A5;
	Thu, 24 Jan 2008 18:36:12 +0100 (CET)
X-ME-UUID: 20080124173612441.6BD9470000A5@mwinf2f18.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <4797D6C6.207@vilain.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71635>

Sam Vilain a =E9crit :
> Use a graft.  in .git/info/grafts, put (expanding to the full SHA1s):

It is not the first time I see somebody talking about graft... I still=20
don't know exactly what it is. Any pointers to literature about this?

Thanks,
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
