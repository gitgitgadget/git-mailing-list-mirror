From: Pascal Obry <pascal@obry.net>
Subject: Re: git-reflog infinite loop
Date: Wed, 11 Jun 2008 07:46:13 +0200
Organization: Home - http://www.obry.net
Message-ID: <484F66A5.6070205@obry.net>
References: <484EBD92.8040603@obry.net> <20080611034718.GB7198@sigill.intra.peff.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 11 07:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6JB7-0007qE-LT
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 07:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbYFKFqU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jun 2008 01:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYFKFqU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 01:46:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:44174 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbYFKFqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 01:46:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2009412fgg.17
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 22:46:18 -0700 (PDT)
Received: by 10.86.80.17 with SMTP id d17mr5411417fgb.33.1213163177621;
        Tue, 10 Jun 2008 22:46:17 -0700 (PDT)
Received: from ?192.168.0.100? ( [90.35.55.221])
        by mx.google.com with ESMTPS id d4sm14515938fga.8.2008.06.10.22.46.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 22:46:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <20080611034718.GB7198@sigill.intra.peff.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84589>

Jeff King a =C3=A9crit :
> I can't reproduce here, so presumably it is some condition in your
> repository;

Yes, I have this problem on a single repository and no problem on the=20
others (~10).

> can you make a tarball of your .git directory available?

No I can't :(

Is there some git-reflog options I can try to help finding this problem=
?

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
