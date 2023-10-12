Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B1D53C
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 20:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AHeOeXDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9236C433B9;
	Thu, 12 Oct 2023 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697143240;
	bh=xgHw7sUfmDFHcmcss9XpvK3ft6ysGapiFHtRdM43hWg=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=AHeOeXDRkfZtcUpDj6Dlhc5CSIZEWfKYwGM0QsA+4ZIeH6T3v8hJg7w+xh9JRPQ2u
	 BXcsuvdIKsg19gf7MzIodkaXJ7dxW4wxTqQYN5IfkZ2E2n9cjPQFPcnkKAJArci//D
	 IWzlU8az2e3kxzv1CSDg0ZKt9F3lnrELA3YqLuDk=
Date: Thu, 12 Oct 2023 16:40:38 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: git@vger.kernel.org
Subject: Re: This list is being migrated to new infrastructure (no action
 required)
Message-ID: <20231012-magnifier-decipher-4493ec@meerkat>
References: <20231012-party-legwarmer-551ab7@meerkat>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231012-party-legwarmer-551ab7@meerkat>

On Thu, Oct 12, 2023 at 04:30:54PM -0400, Konstantin Ryabitsev wrote:
> This list is being migrated to the new vger infrastructure. This should be a
> fully transparent process and you don't need to change anything about how you
> participate with the list or how you receive mail.
> 
> There will be a brief delay with archives on lore.kernel.org. I will follow up
> once the archive migration has been completed.

This work is completed now. If you think something isn't working right, please
report it to helpdesk@kernel.org.

-K
