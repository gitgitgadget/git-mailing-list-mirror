From: Pascal Obry <pascal@obry.net>
Subject: Re: What's cooking in git.git (Aug 2011, #03; Thu, 11)
Date: Thu, 18 Aug 2011 23:02:11 +0200
Organization: Home - http://www.obry.net
Message-ID: <4E4D7DD3.2000701@obry.net>
References: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 23:02:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu9jK-0002vR-Rk
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 23:02:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab1HRVCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 17:02:18 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56866 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1HRVCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 17:02:17 -0400
Received: by wwf5 with SMTP id 5so2491751wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 14:02:15 -0700 (PDT)
Received: by 10.216.65.203 with SMTP id f53mr6030431wed.54.1313701335112;
        Thu, 18 Aug 2011 14:02:15 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-15-192.w82-124.abo.wanadoo.fr [82.124.198.192])
        by mx.google.com with ESMTPS id fd4sm2055904wbb.64.2011.08.18.14.02.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 14:02:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7vr54rpogf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179628>


Junio,

> * po/cygwin-backslash (2011-08-05) 2 commits
>   - On Cygwin support both UNIX and DOS style path-names
>   - git-compat-util: add generic find_last_dir_sep that respects is_dir_sep
>
> I think a further refactoring (no, not my suggestion) was offered?

I think the current patchset is fine. It is always possible to improve 
things but the current patch goes in the right direction. So to me it is 
ready as-is.

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
