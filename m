Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284221114
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 21:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D04FA4
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:15:01 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id DA2DF24054;
	Mon, 23 Oct 2023 17:14:59 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qv2GJ-kdW-00; Mon, 23 Oct 2023 23:14:59 +0200
Date: Mon, 23 Oct 2023 23:14:59 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTbiU+SwvGi9972S@ugly>
References: <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <ZTa4iqe0lqn/Yg5L@ugly>
 <ZTbJiIkIyXwWK8JP.jacob@initialcommit.io>
 <ZTbVY7Nf+DTYqHky@ugly>
 <d55eaf41f55bdff0b5ae734e5d7e6724@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d55eaf41f55bdff0b5ae734e5d7e6724@manjaro.org>

On Mon, Oct 23, 2023 at 10:51:31PM +0200, Dragan Simic wrote:
>The hint should be about how to turn the tables and verbosity on, not 
>how to get rid of it.
>
but that's just backwards. a noob shouldn't be bothered with putting the 
tool into noob-friendly mode, neither actually nor "just" 
psychologically. switching to "expert" mode should be the conscious 
effort. and making it opt-in wouldn't even save the experts any 
annoyance, as they need to opt out from the hint anyway.

regards
