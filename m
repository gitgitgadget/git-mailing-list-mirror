From: Douglas Mencken <dougmencken@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Wed, 14 Nov 2012 11:19:16 -0500
Message-ID: <CACYvZ7jwjVsW4=QSbxFVL8N269DE4=tv8_WvZ0gVOw6B+WLP=w@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<50A2978D.6080805@ramsay1.demon.co.uk>
	<50A2B2DF.1080704@web.de>
	<m2pq3h9ll1.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 17:19:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYfga-0006ih-RQ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 17:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811Ab2KNQTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 11:19:18 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50126 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807Ab2KNQTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 11:19:17 -0500
Received: by mail-lb0-f174.google.com with SMTP id gp3so536309lbb.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 08:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+a2Dm9f44aqZEohIaxfRab+siJUNjlaDfPmsK/5DiHk=;
        b=NOYIAegMUPMuF2s7qpZyA5YMeGCeNqCsEsAincAluPvjfSHLlJff0e3BDEewUx53rq
         AjiiEyClTpx3Xw/DcV7WuP9i6F3fKN0+dUDTeGtUtzDSQFz4EbmEnkFvj57frWUlwiAM
         HDKFO0T3R2TO0L0ouEIR0f+TOOWG78klL0LJags65JeeRhKCr8fOeCX5TcH1M2EFC/ds
         sNAF4Cknjvr/+D8KNc5/hcfa4PlZfUdejhVhhJINaijqRX8OPzd1jz/nUTIz1o4Adsee
         P+18/wFV0Vblk67nq8R/xmil9uHlkoI9OhgJdseohCzETfiwgGE6CBljrGPmtCKqY3E0
         4uLA==
Received: by 10.112.48.133 with SMTP id l5mr11024236lbn.53.1352909956197; Wed,
 14 Nov 2012 08:19:16 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Wed, 14 Nov 2012 08:19:16 -0800 (PST)
In-Reply-To: <m2pq3h9ll1.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209723>

> I cannot reproduce the problem (on openSUSE 12.2).

You do need multiple CPU/multi-core machine, as I got it.
