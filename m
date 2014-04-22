From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Tue, 22 Apr 2014 09:19:40 +0200
Message-ID: <CAHGBnuMty-86jfUto=L3muhgEVwVE70FQQY2FJ1bn7AUjfEtLQ@mail.gmail.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
	<53557071.5040500@gmail.com>
	<xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 09:19:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUza-0005Gy-0g
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 09:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbaDVHTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 03:19:42 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:42716 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbaDVHTk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 03:19:40 -0400
Received: by mail-yh0-f51.google.com with SMTP id f10so4459705yha.38
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 00:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MyqXP2B3S/k1oudsjcPTBvp2a3V3o6NRy15AVGBZQ60=;
        b=Eb57rwb0mGhl4GCqrreeamZ0iDH3LsD1aC6Skg99YOLTzCcRKbtIAOMaIfC3k7kFYe
         U+ZY548of5fxiVT+dKcyB112OsNWDifkMKpS8GBQQYeFbcSIY4Xr/gzwuXf3juygHfqH
         IVhSXHvPjQJ2aS9afK64SmYss/lf16h+Pa+RWFz6tuKKi1nsMN8huNYfowV4p85tDHLH
         ID64LDCZF5jT+I++V8CBwSKFzIOKMmN0Hm2htVPy+V8ZJniHr9kpiEIkOfbVouRv3Wyw
         Eq+eG8HfXsgiRsgcaak0X1uuAz9Bl7o4kR2/X9h5fI44sLH/M7TmJiRUzAhOKHNeOR6h
         WjAQ==
X-Received: by 10.236.41.165 with SMTP id h25mr628312yhb.126.1398151180334;
 Tue, 22 Apr 2014 00:19:40 -0700 (PDT)
Received: by 10.170.151.10 with HTTP; Tue, 22 Apr 2014 00:19:40 -0700 (PDT)
In-Reply-To: <xmqqtx9m8obr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246708>

On Mon, Apr 21, 2014 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> If we don't standardize this now people will come up with their own
>> definitions [1] [2] (and many others if you just search GitHub) which
>> are again likely to differ (slightly), hindering interoperability.
>
> I am afraid that that ship has sailed long time ago, though.

That's most likely true, but it does not get better by postponing this
even more. I still think there's value in introducing this now, Git
still attracts new developers every day. In fact, I currently see a
leap forwarding in the Windows world towards Git, caused by some
rethinking and structural changes in some big companies.

-- 
Sebastian Schuberth
