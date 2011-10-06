From: Pascal Obry <pascal@obry.net>
Subject: Re: What's cooking in git.git (Oct 2011, #01; Tue, 4)
Date: Thu, 06 Oct 2011 19:32:21 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E8DE625.2010103@obry.net>
References: <7vvcs49ofl.fsf@alter.siamese.dyndns.org> <4E8DC01A.8060406@obry.net> <7vlisy119i.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:32:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBro8-0006nE-IH
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:32:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996Ab1JFRc0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Oct 2011 13:32:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34141 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758729Ab1JFRcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:32:25 -0400
Received: by wwf22 with SMTP id 22so4624015wwf.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:32:24 -0700 (PDT)
Received: by 10.216.18.130 with SMTP id l2mr1390160wel.74.1317922344068;
        Thu, 06 Oct 2011 10:32:24 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-64-191.w83-199.abo.wanadoo.fr. [83.199.102.191])
        by mx.google.com with ESMTPS id z9sm11327000wbn.19.2011.10.06.10.32.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Oct 2011 10:32:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7vlisy119i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182996>

Le 06/10/2011 19:24, Junio C Hamano a =E9crit :
> The impression I got from the discussion was quite different, which w=
as
> that the patch was not even "good" by making certain things impossibl=
e to
> do by catering to a narrow corner case.

I have understood that this was not completely fixing all=20
slash/backslash issues (is it even possible?) but in no way there was=20
regressions pointed out. At least a specific error *was* fixed. But I=20
may have missed something, in that case sorry.

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
