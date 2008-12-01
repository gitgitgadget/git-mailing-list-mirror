From: Pascal Obry <pascal@obry.net>
Subject: Re: how to hide some branches
Date: Mon, 01 Dec 2008 11:20:11 +0100
Organization: Home - http://www.obry.net
Message-ID: <4933BA5B.2030300@obry.net>
References: <493261C9.4040608@obry.net> <4932F2FD.9030603@pcharlan.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 11:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L75uU-0001XD-P0
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 11:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbYLAKUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2008 05:20:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbYLAKUX
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 05:20:23 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:10600 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbYLAKUW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 05:20:22 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1005818eyi.37
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 02:20:17 -0800 (PST)
Received: by 10.86.92.7 with SMTP id p7mr6137967fgb.74.1228126817027;
        Mon, 01 Dec 2008 02:20:17 -0800 (PST)
Received: from ?10.10.127.189? (dhcp-guest.act-europe.fr [212.99.106.127])
        by mx.google.com with ESMTPS id 3sm160438fge.1.2008.12.01.02.20.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Dec 2008 02:20:15 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.18) Gecko/20081105 Thunderbird/2.0.0.18 Mnenhy/0.7.5.0
In-Reply-To: <4932F2FD.9030603@pcharlan.com>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102015>

Pete Harlan a =E9crit :
>>From a suggestion by Jakub Narebski, I use an alias "lb" that shows
> the most recently-active 8 branches:
>=20
>   for-each-ref --format=3D'%(refname:short)' \
>        --sort=3D-authordate --count=3D8 refs/heads/

Thanks, I like this one. Probably the best approach to me.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
