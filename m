Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EE11728
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7200192
	for <git@vger.kernel.org>; Thu, 26 Oct 2023 01:35:50 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id 7AA4924189;
	Thu, 26 Oct 2023 04:35:49 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvvqH-ITO-00; Thu, 26 Oct 2023 10:35:49 +0200
Date: Thu, 26 Oct 2023 10:35:49 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] ci: split out logic to set up failed test artifacts
Message-ID: <ZTok5cDVT7ug/GCc@ugly>
References: <cover.1698305961.git.ps@pks.im>
 <4a864a1d174f7d4d36202a375302d450fbe9f2a3.1698305961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4a864a1d174f7d4d36202a375302d450fbe9f2a3.1698305961.git.ps@pks.im>

On Thu, Oct 26, 2023 at 10:00:16AM +0200, Patrick Steinhardt wrote:
>We have some logic in place to create a directory with the output from
>failed tests, which will then subsequently be uploaded as CI artifact.
								      ^ 
								      +s

regards
