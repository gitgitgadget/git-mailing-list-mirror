From: Sivaram Kannan <siva.devel@gmail.com>
Subject: Re: Git crash in Ubuntu 12.04
Date: Thu, 18 Apr 2013 17:02:31 +0530
Message-ID: <CAJiNi_FBzz2Tqp_P8BB=X7UnAaHiNH8s0FyzW4K9Xp6WZijECw@mail.gmail.com>
References: <CAJiNi_FfU9Gsr2D9CcC0wWwgO1oKBXwxp87-wBUJBU2kyGaQNQ@mail.gmail.com>
	<87mwt6ltia.fsf@linux-k42r.v.cablecom.net>
	<CAJiNi_EgjgKs7oNJyGcamUFz=ARDAuBTb+bJ0uVsPFBMbZF3YA@mail.gmail.com>
	<20130411170659.a35d2c581cf34ade13448bfa@domain007.com>
	<CAJiNi_Gju2aJkVJJmoxnEAubfPvjaVhVF6DisaLn5kUJ3YRD=w@mail.gmail.com>
	<20130412180525.aa5b8eacd691a427244d6ab5@domain007.com>
	<CAJiNi_GQZf8BRkTR8+j6YjdcqUH1J1NATSrNUjZ=65V+ip6okQ@mail.gmail.com>
	<CACsJy8AfVjhsBtfwJomRmoYsA3EMPja--y5Twq=T7-bCUQRU-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 13:32:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USn51-0005gt-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 13:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936228Ab3DRLcj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 07:32:39 -0400
Received: from mail-vb0-f41.google.com ([209.85.212.41]:34198 "EHLO
	mail-vb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965340Ab3DRLcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 07:32:33 -0400
Received: by mail-vb0-f41.google.com with SMTP id f13so2265405vbg.28
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=anLYu3CaCIwY81sM/vpph/GcMHJaMH6XXb/hUMQMtcQ=;
        b=VQw1FSz3WnOd88vybPsbrc9R4ac6G3xlS5+bT6zF2LTmoonQ3+oC3yX5oEaJLuSAHT
         1yermWufYQT2909CwvWy6klGDEO2Rh6mZ5YvhoObCqRw4RbzgpMzBy4XmHPdf1/+UmqD
         4PCtBh8077Wi7dBRxJal66IveWtHBImDNsO+CntYQeVTm+vKoMJAkvdm3XtHxm2OnzcG
         TqyCMvlBU30ZlxN0j02ejzAapia/3fqWG6zU6AxD5L172lntRiT0eefq8Dn7KI9hW+Hx
         jyad2tzDS61Kupua2vch5WhzzZ+oSOogoebeQFr4wJ+MqtdHgtt79hijWtIve4VYmNw9
         o4Pw==
X-Received: by 10.52.93.78 with SMTP id cs14mr6877686vdb.17.1366284751707;
 Thu, 18 Apr 2013 04:32:31 -0700 (PDT)
Received: by 10.221.3.131 with HTTP; Thu, 18 Apr 2013 04:32:31 -0700 (PDT)
In-Reply-To: <CACsJy8AfVjhsBtfwJomRmoYsA3EMPja--y5Twq=T7-bCUQRU-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221652>

Hi,

> Probably not because there are no debugging symbols. Not sure how
> ubuntu packages these symbols..

Would recompiling the source packages and debugging would give
different results?

>
> Any chance you could publish the repository that causes the crash?
> --
> Duy

I don't think I can publish the repo online. But I am willing to try
any steps on the repo to get more info. Most likely I would restore
the latest repo to the stanby server I tested which works with any
crash. Let me know what I can do to get more information.

./Siva.
