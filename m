From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Sat, 06 Aug 2011 09:01:45 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E3CE6D9.4050600@obry.net>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net> <7vipqb3g1w.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Theo Niessink <theo@taletn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 06 09:01:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpatN-0007Tq-IC
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 09:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab1HFHBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 03:01:48 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33618 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab1HFHBs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 03:01:48 -0400
Received: by wwe5 with SMTP id 5so44955wwe.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 00:01:46 -0700 (PDT)
Received: by 10.227.27.216 with SMTP id j24mr2568976wbc.97.1312614106610;
        Sat, 06 Aug 2011 00:01:46 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-101-151.w90-2.abo.wanadoo.fr [90.2.59.151])
        by mx.google.com with ESMTPS id em16sm2835454wbb.33.2011.08.06.00.01.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 00:01:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7vipqb3g1w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178830>

Le 05/08/2011 19:48, Junio C Hamano a =E9crit :
> I wonder if these two that are the same as mingw should further be
> consolidated into one implementation, something like below.

=46ine with me.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
