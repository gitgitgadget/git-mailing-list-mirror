From: Pascal Obry <pascal@obry.net>
Subject: Re: Question about git rebase --onto
Date: Thu, 04 Feb 2010 17:46:38 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B6AF9EE.3000205@obry.net>
References: <4B6865A9.60603@obry.net> <7v636f7biw.fsf@alter.siamese.dyndns.org> <4B686CAC.7020103@obry.net> <7vhbpx3it2.fsf@alter.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 17:46:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4qN-0003Xw-Du
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758477Ab0BDQqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:46:09 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:46994 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758469Ab0BDQqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:46:07 -0500
Received: by fxm20 with SMTP id 20so2761796fxm.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 08:46:06 -0800 (PST)
Received: by 10.87.47.3 with SMTP id z3mr220727fgj.70.1265301966246;
        Thu, 04 Feb 2010 08:46:06 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-45-106.w82-124.abo.wanadoo.fr [82.124.149.106])
        by mx.google.com with ESMTPS id e11sm1874790fga.9.2010.02.04.08.46.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Feb 2010 08:46:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <7vhbpx3it2.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138978>

Junio,

> Writing reproducible test case would be a great way to diagnose this.

I just can't reproduce now! I've tried on a second machine starting from
the same repository state and still can't reproduce! So either I was in
really bad shape last night or it was some kind of transient problem on
my Cygwin/Git system.

Sorry for the noise.

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
