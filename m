From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.16.1
Date: Mon, 20 Sep 2010 22:08:29 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C97BF3D.5090006@obry.net>
References: <20100919183556.GA22302@diku.dk> <20100920023036.GB2548@debian.b2j>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 20 22:09:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oxmfd-0005Vy-8u
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 22:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab0ITUI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Sep 2010 16:08:28 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45936 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754824Ab0ITUI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 16:08:28 -0400
Received: by wyf22 with SMTP id 22so4707005wyf.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 13:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=j91Csrxj1lVaXCRe/sOGmxEXV87ZTZ8uGtymoRBpqZQ=;
        b=MF4D0/u3J2wb0QK10LYxtXogEsKnoLA/SlL3LKxsOTFUYr1039I8q0hkVuGKEKHChF
         qP1SYcORppja0rykDtdBoFq4SFyhQLutGW+MfmJxXOAjPzlFbey6DOaNGA7UL8D60yXo
         JwKcm+jJLzV+OntFHdfSS45prLLVhA1EZ3OMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        b=O8c879yY+z5HLMnihrmxs93MNCFRbsjpAOxcZjjEbhEIi5NrJjNJANs8O97BK82lnC
         534nYu7KGM3wWr7+mqpO0fn949iWz+nHdC/qnDWWevH93OTASiYSrIMvbhEymxnm7kqA
         bHdWG7TpM3g17QFKnVe6kzT9TOa5DXWOwUGxU=
Received: by 10.216.154.131 with SMTP id h3mr4774825wek.74.1285013306770;
        Mon, 20 Sep 2010 13:08:26 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-101-165.w90-2.abo.wanadoo.fr [90.2.59.165])
        by mx.google.com with ESMTPS id r18sm5434182weo.24.2010.09.20.13.08.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 13:08:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20100920023036.GB2548@debian.b2j>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156657>

Le 20/09/2010 04:30, bill lam a =E9crit :
> BTW, do you plan to port tig to windows?  Although I seldom use windo=
w but
> I know ncurses is available as pdcurses.

Note that tig is working fine on cygwin.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
