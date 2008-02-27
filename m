From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 00/40] MinGW port
Date: Thu, 28 Feb 2008 12:34:14 +1300
Message-ID: <46a038f90802271534p37869c58oe79b959b4919c603@mail.gmail.com>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>
	 <47C5DDC0.8060004@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 00:35:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUVng-000251-Es
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 00:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbYB0XeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 18:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbYB0XeW
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 18:34:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:61262 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760989AbYB0XeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 18:34:21 -0500
Received: by ug-out-1314.google.com with SMTP id z38so19329ugc.16
        for <git@vger.kernel.org>; Wed, 27 Feb 2008 15:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ihb8NardB2cNhEXtmd0tupL7U5v0NpqAbHioOCiFhO8=;
        b=QpgOsUBRW+mHcKDhcOEkKINOa3VeisQYHXIf1aUyJbO2YGmq8DuRsIzMN/y+dQ+ksMwP7vDpTclczX5MKmY0asW6xoOT4rsEyvz3oihuBdJaq3VfWDb7dG7TSpp3s5EHiXLY0hUqM+uzG/8RTLsiF4tUREdgzhUqeW8DY+sEQ8k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HgMlHMjpturqSvbyzKcLGsZAlf5lB1Cw8LIq2twrZhy9SPeNpIxfhtGVxMvz8ZLRMcgL1SKVE0l+lV6fUJFvq8h/uTMNSzz8+nT9AT1QF2hvNBM979WH7WfWwo1pWmiBest2SZ72klDyQHP4UrHU4ljZRYMSSeyIE/JNoeW0C6s=
Received: by 10.67.116.11 with SMTP id t11mr1891666ugm.61.1204155254470;
        Wed, 27 Feb 2008 15:34:14 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Wed, 27 Feb 2008 15:34:14 -0800 (PST)
In-Reply-To: <47C5DDC0.8060004@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75323>

On Thu, Feb 28, 2008 at 11:01 AM, Marius Storm-Olsen
<marius@trolltech.com> wrote:
>  I just have to say, MASSIVE work Hannes! Thank you so much for your
>  efforts in making the MinGW port the great port that it is!
>
>  You too Dscho, and the rest of the MSys Git team! ;-)

Indeed. Amazing stuff. I do some occasional work on Windows, and it is
a sheer pleasure to use msys git. Simple install, it just works, and
it is fast fast FAST. Hats off!



m
