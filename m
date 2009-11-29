From: Pascal Obry <pascal@obry.net>
Subject: Re: What is the best way to backport a feature?
Date: Sun, 29 Nov 2009 17:52:56 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B12A6E8.8050803@obry.net>
References: <loom.20091129T164518-669@post.gmane.org> <20091129164748.GB7921@atjola.homenet>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Weseloh <Peter.Weseloh@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 29 17:53:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEn1D-0007Vx-HR
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 17:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbZK2Qww convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Nov 2009 11:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbZK2Qww
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 11:52:52 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:11093 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbZK2Qww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 11:52:52 -0500
Received: by ey-out-2122.google.com with SMTP id 4so755065eyf.19
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 08:52:57 -0800 (PST)
Received: by 10.216.90.133 with SMTP id e5mr1092521wef.23.1259513575496;
        Sun, 29 Nov 2009 08:52:55 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-43-248.w82-124.abo.wanadoo.fr [82.124.147.248])
        by mx.google.com with ESMTPS id 5sm4138760eyf.8.2009.11.29.08.52.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 08:52:55 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <20091129164748.GB7921@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134025>

Le 29/11/2009 17:47, Bj=F6rn Steinbrink a =E9crit :
> What's unusual there is that you merged from Mainline to Feature_A.
> Usually, the history would look like this:

Right, I missed that! It is indeed very unusual at the point that I=20
missed to read it properly :) So my reply is wrong.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
