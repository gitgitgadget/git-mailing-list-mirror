Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1B43F4D0
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDEB133
	for <git@vger.kernel.org>; Tue, 24 Oct 2023 14:31:31 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id B4F5F20092;
	Tue, 24 Oct 2023 17:31:30 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qvOzq-y68-00; Tue, 24 Oct 2023 23:31:30 +0200
Date: Tue, 24 Oct 2023 23:31:30 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Charvi Mendiratta <charvi077@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RESEND v2] git-rebase.txt: rewrite docu for fixup/squash (again)
Message-ID: <ZTg3stQRcC1ZYFxj@ugly>
References: <20231023130016.1093356-1-oswald.buddenhagen@gmx.de>
 <ZTamhY1sTpp1N6n+@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZTamhY1sTpp1N6n+@nand.local>

On Mon, Oct 23, 2023 at 12:59:49PM -0400, Taylor Blau wrote:
>The line wrapping is a little odd: it looks like each sentence begins 
>on a its own line.
>
this is indeed the case.

>Did you mean for there to be a visual separation between those 
>sentences in the rendered doc?
>
no.

the idea is to keep the churn down in later edits, by making reflowing 
the entire paragraph visibly unnecesary. i can change it if it's deemed 
too weird.

regards
