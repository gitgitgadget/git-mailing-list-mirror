From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Thu, 12 Nov 2009 11:00:07 +0100
Message-ID: <a2633edd0911120200l1d7bf848j3fd305a18e70453d@mail.gmail.com>
References: <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com>
	 <20091111202201.GA10351@dcvr.yhbt.net>
	 <20091111203413.GA9648@dcvr.yhbt.net> <4AFB32DC.50505@obry.net>
	 <20091111224454.GA16178@dcvr.yhbt.net> <4AFBADA9.3060401@obry.net>
	 <20091112071121.GA569@dcvr.yhbt.net>
	 <a2633edd0911120011u34d69100p1565ab5bf96a7709@mail.gmail.com>
	 <a2633edd0911120103y688a2b2ah2c33c47de195ee81@mail.gmail.com>
	 <20091112093509.GA617@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 11:03:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8WTP-0004tX-QE
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 11:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbZKLKAE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 05:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbZKLKAD
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 05:00:03 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:45408 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbZKLKAC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 05:00:02 -0500
Received: by bwz27 with SMTP id 27so1999864bwz.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 02:00:07 -0800 (PST)
Received: by 10.204.34.84 with SMTP id k20mr2849089bkd.199.1258020007601; Thu, 
	12 Nov 2009 02:00:07 -0800 (PST)
In-Reply-To: <20091112093509.GA617@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132760>

Eric,

> Yes, you need to recreate all the .rev_map* files if you use
> filter-branch. =A0Just remove them and they should be automatically
> recreated for your case (not using --no-metadata or --use-svm-props)

Thanks for the confirmation, I'll do that.

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
