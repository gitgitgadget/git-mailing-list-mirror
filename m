From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: Question about commit message wrapping
Date: Wed, 14 Dec 2011 16:07:35 -0500
Message-ID: <65F00919-FFF9-4196-99EA-8E8C318BE47F@sidneysm.com>
References: <35A5A513-91FD-4EF9-B890-AB3D1550D63F@sidneysm.com> <m3zkf1hnh9.fsf@localhost.localdomain> <E085218D-9287-4F82-B34C-8379742F818A@sidneysm.com> <201112102030.15504.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 22:07:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raw3G-0003fZ-4n
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 22:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150Ab1LNVHj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Dec 2011 16:07:39 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:48130 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142Ab1LNVHh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2011 16:07:37 -0500
Received: by qadb15 with SMTP id b15so857028qad.19
        for <git@vger.kernel.org>; Wed, 14 Dec 2011 13:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=GhNsqAZHy15rk2xswweX7TP7CSoEUP5SOcZmGs7j38k=;
        b=R3IsqR366qvqt+SGjSYOQEmWaOG/d3D1PkdJBCI3I2qTeza2OyoUUHvXYg6K5W+Vjg
         lNcri1W9QyKcRR2KxP0xPngzaLJmBA0OPGPI967ajcJZ9jll6vsfL28ln062kRdFo+Ag
         SGjv9WLOsK3Ztgw1IAVTAUKN0fatIf5E1h7hQ=
Received: by 10.224.198.10 with SMTP id em10mr634137qab.44.1323896856143;
        Wed, 14 Dec 2011 13:07:36 -0800 (PST)
Received: from [172.20.1.57] (rrcs-184-75-21-194.nyc.biz.rr.com. [184.75.21.194])
        by mx.google.com with ESMTPS id du5sm8047717qab.14.2011.12.14.13.07.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Dec 2011 13:07:35 -0800 (PST)
In-Reply-To: <201112102030.15504.jnareb@gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187167>

On Dec 10, 2011, at 2:30 PM, Jakub Narebski wrote:

> BTW. In Polish (and Czech) typography there is rule that you don't le=
ave
> single-letter prepositions like 'i' ('and' in English) hanging at the=
 end
> of the line... automatic wrapper cannot ensure that.

I meant to ask=85 how is that rule followed by browsers/on the web?