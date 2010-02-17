From: Pascal Obry <pascal@obry.net>
Subject: Re: Question about git rebase --onto
Date: Wed, 17 Feb 2010 11:27:51 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B7BC4A7.5070902@obry.net>
References: <4B6865A9.60603@obry.net> <7v636f7biw.fsf@alter.siamese.dyndns.org>	 <4B686CAC.7020103@obry.net> <7vhbpx3it2.fsf@alter.siamese.dyndns.org>	 <4B6AF9EE.3000205@obry.net> <7vr5p1gd2t.fsf@alter.siamese.dyndns.org>	 <4B7BB604.20205@obry.net> <be6fef0d1002170219j27c79877k830f8d853719ea2e@mail.gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 11:27:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhh8J-0007JW-9q
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 11:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689Ab0BQK1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 05:27:46 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49087 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab0BQK1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 05:27:45 -0500
Received: by vws8 with SMTP id 8so637930vws.19
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 02:27:45 -0800 (PST)
Received: by 10.220.124.136 with SMTP id u8mr1746697vcr.145.1266402464735;
        Wed, 17 Feb 2010 02:27:44 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-68-29.w83-204.abo.wanadoo.fr [83.204.186.29])
        by mx.google.com with ESMTPS id 26sm16130093vws.4.2010.02.17.02.27.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 17 Feb 2010 02:27:43 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <be6fef0d1002170219j27c79877k830f8d853719ea2e@mail.gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140228>

Tay,

> Why do you add the last parameter ("HEAD")? If I run the rebase
> without it, it works fine (ie. not on a detached HEAD).

Right, without the final HEAD it is working. But it ought to work with
it too. Hence my report.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
