From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb showing slash r at the end of line
Date: Thu, 02 Feb 2012 12:04:06 -0800 (PST)
Message-ID: <m339atc880.fsf@localhost.localdomain>
References: <1327673954458-7229895.post@n2.nabble.com>
	<m3aa58eskw.fsf@localhost.localdomain>
	<7vvcnwybxj.fsf@alter.siamese.dyndns.org>
	<201201281802.44339.jnareb@gmail.com>
	<1327910140526-7235866.post@n2.nabble.com>
	<m3obtlczmu.fsf@localhost.localdomain>
	<1327939743099-7237025.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ondra Medek <xmedeko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 21:04:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt2tD-000501-9h
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 21:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933241Ab2BBUEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 15:04:09 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56757 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584Ab2BBUEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 15:04:08 -0500
Received: by eekc14 with SMTP id c14so898780eek.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=TdjRgQSZ3cu2T5tGzC2pxTDHeLZaI14WpH4zUo3cFc0=;
        b=ThUIxsFdqwENCvRoSsPm8abPngNkzF4Bc4R0YKunmpjdJ7bzB9YLaV+jZBGoeU7iIB
         q4y6wvdkdx8As/UiPgibypSv7QwF+Y+vyCT5aZjDRbhE4Ui+BddnkBRu6sasXctoa2Ux
         NoAmYkIBUGkle1rK8bGAzcJffGDy4AkfJU0OI=
Received: by 10.14.17.34 with SMTP id i34mr1323748eei.65.1328213047365;
        Thu, 02 Feb 2012 12:04:07 -0800 (PST)
Received: from localhost.localdomain (abwd54.neoplus.adsl.tpnet.pl. [83.8.227.54])
        by mx.google.com with ESMTPS id n17sm12879940eei.3.2012.02.02.12.04.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 12:04:06 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q12K4m9l018155;
	Thu, 2 Feb 2012 21:04:49 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q12K4mLe018152;
	Thu, 2 Feb 2012 21:04:48 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1327939743099-7237025.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189690>

Ondra Medek <xmedeko@gmail.com> writes:

> Thanks for pointing out the [gitweb] section of the config. Should I try to
> make the patch or someone else more skilled would pick this up?

I'll try to pick it up, if you wouldn't be able to...

...subject to finding time for this, of course.

-- 
Jakub Narebski
