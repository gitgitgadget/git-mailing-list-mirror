From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: Re: more merge strategies : feature request
Date: Wed, 3 Dec 2008 17:59:56 -0500
Message-ID: <81bfc67a0812031459g4c30908ew46e4cf2bd6445f64@mail.gmail.com>
References: <81bfc67a0811290848m6cb219c0y71a7266001096f2d@mail.gmail.com>
	 <4933AC03.6050300@op5.se>
	 <ee2a733e0812011849l1b319c96u9abbb4e8dd4f53ce@mail.gmail.com>
	 <81bfc67a0812020546o79906a20jcd04bd42d18dd803@mail.gmail.com>
	 <ee2a733e0812021707i82049eai866035aef3386264@mail.gmail.com>
	 <20081204062717.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Leo Razoumov" <slonik.az@gmail.com>, git@vger.kernel.org
To: "Nanako Shiraishi" <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:01:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L80ie-0007E3-Gu
	for gcvg-git-2@gmane.org; Thu, 04 Dec 2008 00:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbYLCW76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 17:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753941AbYLCW75
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 17:59:57 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:44064 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYLCW75 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 17:59:57 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3681391rvb.1
        for <git@vger.kernel.org>; Wed, 03 Dec 2008 14:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ndYuYZ/YQ9lZCQ+gQ/wSg4lEbUiWMkOR6Ma7FmWm+uI=;
        b=f74A3cGxI9UqyuGZxwO5wfXSGnFPVT9EDSPwXIAw7pNCzlsjqDVhuvicdwKtW5qFOA
         aqoN4ycauwiO2blMrHniH2pVMvQAvolO5u8PEZqisFnABbPwhVVEdTNvCGyxkBq8YowA
         KBn4XWEocM88cEkGARj7jY3ncjAE6fluz2GQM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SUWInP4BDGfQ6Dq6VWTCF+/S5QEnMzQyEsYLtR15vp+/zwJcvw/ZYhPLQVXLKHQx02
         l/jomcwiouonXECMdtbf2Ibjhmdi2tZ9u5FxGoG08RG9mOgOJOWD004NfLUrLMO1DpEh
         YPUgnlIAedXXyoC0QJ34o5AgKF8YSTwHAqpa0=
Received: by 10.141.123.4 with SMTP id a4mr6548456rvn.273.1228345196159;
        Wed, 03 Dec 2008 14:59:56 -0800 (PST)
Received: by 10.141.145.7 with HTTP; Wed, 3 Dec 2008 14:59:56 -0800 (PST)
In-Reply-To: <20081204062717.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102301>

> Isn't what Caleb wants "-X ours/theirs" per-hunk option for merge strategy backends?

just from this description it sounds like it. I can't say anything
about that patch, but to me having such a strategy only makes sense.

-- 
Caleb Cushing
