From: Pascal Obry <pascal@obry.net>
Subject: Re: why is my repo size ten times bigger than what I expected?
Date: Sat, 05 Mar 2011 11:49:54 +0100
Organization: Home - http://www.obry.net
Message-ID: <4D721552.4090205@obry.net>
References: <AANLkTimi+OnpdX+Y7jx1JaOmGbZc_XEgJFeK0PKLpu2o@mail.gmail.com> <AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ruben Laguna <ruben.laguna@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 05 11:50:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pvp3o-00014X-4Q
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 11:50:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238Ab1CEKuA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Mar 2011 05:50:00 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:58225 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab1CEKt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 05:49:59 -0500
Received: from [192.168.0.100] ([90.2.73.184])
	by mwinf5d09 with ME
	id FNpu1g00G3yZrEa03NpvHM; Sat, 05 Mar 2011 11:49:55 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <AANLkTi=V3nEamocowbHovvV0U69nZgD70fysu1CQOwrR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168484>

Le 05/03/2011 11:05, Ruben Laguna a =C3=A9crit :
> Is there any other thing I could do to reduce and audit  the reposito=
ry size?

    $ git gc

?

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
