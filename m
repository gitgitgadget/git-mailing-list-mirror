From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Fri, 05 Aug 2011 20:39:55 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E3C38FB.4030002@obry.net>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net> <CABPQNSYSzsY-CQdi6iJQftsY1ufMpxkax=eQLgopVxMC6LoxfA@mail.gmail.com> <4E3C29D9.5060305@obry.net> <CABPQNSYQ9D7NO5cx_o3csAe4bQ40kOd1f5gATUXDb7r4n3GhdA@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Aug 05 20:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpPJh-0008Og-EQ
	for gcvg-git-2@lo.gmane.org; Fri, 05 Aug 2011 20:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1HESj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Aug 2011 14:39:59 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45698 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab1HESj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2011 14:39:59 -0400
Received: by wwe5 with SMTP id 5so3197956wwe.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2011 11:39:58 -0700 (PDT)
Received: by 10.216.65.79 with SMTP id e57mr827095wed.77.1312569597968;
        Fri, 05 Aug 2011 11:39:57 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-101-151.w90-2.abo.wanadoo.fr [90.2.59.151])
        by mx.google.com with ESMTPS id gd1sm2491292wbb.44.2011.08.05.11.39.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Aug 2011 11:39:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <CABPQNSYQ9D7NO5cx_o3csAe4bQ40kOd1f5gATUXDb7r4n3GhdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178812>

Le 05/08/2011 19:39, Erik Faye-Lund a =E9crit :
> Are you saying that the built-in Cygwin tools (like ls etc) support
> Windows-style paths (C:\path\to\file)? If that is the case, I
> completely understand the desire to accept Windows-paths.

Exactly.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
