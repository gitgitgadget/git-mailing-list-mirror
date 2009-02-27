From: Pascal Obry <pascal@obry.net>
Subject: Re: [WARNING] Proposed future changes that are backward incompatible
Date: Fri, 27 Feb 2009 21:54:43 +0100
Organization: Home - http://www.obry.net
Message-ID: <49A85313.70404@obry.net>
References: <20090227192708.6266.qmail@science.horizon.com> <alpine.DEB.1.00.0902272046040.6600@intel-tinevez-2-302>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: George Spelvin <linux@horizon.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:28:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdAFm-0004Kp-E9
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 22:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759122AbZB0V0O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 16:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758828AbZB0V0M
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 16:26:12 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:65221 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761030AbZB0V0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 16:26:10 -0500
Received: by fxm24 with SMTP id 24so1239788fxm.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 13:26:07 -0800 (PST)
Received: by 10.86.94.11 with SMTP id r11mr3651890fgb.53.1235768087553;
        Fri, 27 Feb 2009 12:54:47 -0800 (PST)
Received: from ?192.168.1.11? (ARouen-256-1-36-182.w90-51.abo.wanadoo.fr [90.51.163.182])
        by mx.google.com with ESMTPS id h1sm4637126nfh.56.2009.02.27.12.54.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 12:54:47 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.19) Gecko/20081209 Thunderbird/2.0.0.19 Mnenhy/0.7.5.0
In-Reply-To: <alpine.DEB.1.00.0902272046040.6600@intel-tinevez-2-302>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111720>

Johannes Schindelin a =E9crit :
> I use "git grep" in subdirectories extensively, and I like that it do=
es=20
> _not_ search the whole repository.

Count me too! I find this feature very important.

> After all, since you propose a change in behavior, it is _your_ duty =
to=20
> provide ways for those who want the old behavior to get at it easily!

Agreed.

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
