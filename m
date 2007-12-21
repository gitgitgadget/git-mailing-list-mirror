From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Problem with git-svn
Date: Fri, 21 Dec 2007 16:42:17 +0100
Organization: Home - http://www.obry.net
Message-ID: <476BDED9.1090405@obry.net>
References: <4764FE2C.1010103@obry.net> <20071219082751.GA17787@muzzle> <47690031.7090409@obry.net> <20071220183007.GA26767@untitled> <476AD1AB.8040406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git list <git@vger.kernel.org>
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 16:43:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5k1P-0003TV-R9
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 16:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbXLUPmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 10:42:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbXLUPmX
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 10:42:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:12200 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbXLUPmW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 10:42:22 -0500
Received: by fg-out-1718.google.com with SMTP id e21so181071fga.17
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 07:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=EcMEJ/j5JCUx0t6/6GDjr/+nWmAnzgtuQpSckwjpoXw=;
        b=OjRv60J8+yaZTVU/q5epGn9buUH/79IGYkNf1E0Nk6B/8Lntg1XgWfzl71rkLN1SLqrQ8sYvw44JGrkoD3/CG88dvViPfjk4p1s9YRpVVFca5N51LEwvL9xbXUGsrkC/EfZFPdXNLqhkotlE9fU3o9pxPGcovzcD0apYZtnu2DU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=Dn+UE12CplCmfVh8AKSulDGfzgiEChzeaXQg06e1i9eDnJ/DscJBzFlIhfZsLu2uIBC3gcmoIzCidPOR5kJm6F3pfG8xp3EEP044sk2ep+YhyWaoGqSGL2g8rXXpqhUSv0FmdXG3KcKTUwC1L+CL0pas/HtVMiOvOZ8+kLDhpu0=
Received: by 10.86.66.1 with SMTP id o1mr1254290fga.23.1198251741505;
        Fri, 21 Dec 2007 07:42:21 -0800 (PST)
Received: from ?192.168.0.100? ( [81.249.63.6])
        by mx.google.com with ESMTPS id e20sm1262180fga.1.2007.12.21.07.42.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Dec 2007 07:42:19 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <476AD1AB.8040406@gmail.com>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69068>

Pascal Obry a =E9crit :
> Yes part of it but before the creation of the /importfromcvs/trunk/ t=
hat
> was moved later as /trunk/PROJ.

I meant moved as /trunk/PROJ1 then /trunk/PROJ2... and so on.

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
