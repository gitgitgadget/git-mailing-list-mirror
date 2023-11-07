Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CD52D78A
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=idiomdrottning.org header.i=@idiomdrottning.org header.b="jkjo2oz7"
Received: from halsen.idiomdrottning.org (halsen.idiomdrottning.org [IPv6:2600:3c02:e000:179::7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC879DF
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 03:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=idiomdrottning.org;
	s=idiomdrottningorg; t=1699356281;
	bh=RDRMANRMbX46Xvf6324cywAUXdd1RWeLnwEHgMAW6QA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=jkjo2oz7kp4m3CW+dWpbWGC7YP+a1PNxZAju3L3byUGUG5EHr6YSzKgiBomB+on49
	 yiXvsfjOustEwCDWTP+qDPkvRk3hQSxeEUuhnl/QnpkkHCNqvL+gZS4mltmCdIPQ0a
	 fm49HyPxQghMtMPHhrrOGffVGE2Zu6UvmfsYTWfLyhTfXEVdGxjz6u2QhEQSn0ROvg
	 5aq7amLj0/N2nWZ5aeMj+v6suc+SVgJB8UAAZQde1oaEOsIlqNC4UnhMqw5sK+CaJ5
	 luTtjdFYkgiaMTJVlLLZijZdysh7XYsHjblKNNbJH3y5VeupgTD+bR2I2uNL61aOui
	 PNJht16NTxZZg==
Received: from [127.0.0.1] (31-211-247-254.customers.ownit.se [31.211.247.254])
	by halsen.idiomdrottning.org (Postfix) with UTF8SMTPSA id 515321ECA1;
	Tue,  7 Nov 2023 12:24:41 +0100 (CET)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=no
Subject: =?utf-8?q?Re=3A_RE=3A_first-class_conflicts=3F?=
Chat-Group-Name: =?utf-8?q?RE=3A_first-class_conflicts=3F?=
From: Sandra Snan <sandra.snan@idiomdrottning.org>
To: <git@vger.kernel.org>, Dragan Simic <dsimic@manjaro.org>,
	<rsbecker@nexbridge.com>
Date: Tue, 07 Nov 2023 11:24:40 +0000
Message-ID: <Gr..DPt0IB-WHFM@idiomdrottning.org>
In-Reply-To: <86e6b392-5a61-4864-89b0-42023e1804a6@gmail.com>
References: <87cywmintp.fsf@ellen.idiomdrottning.org>
	<86e6b392-5a61-4864-89b0-42023e1804a6@gmail.com>
Chat-Version: 1.0
Autocrypt: addr=sandra.snan@idiomdrottning.org; prefer-encrypt=mutual;
	keydata=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
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

That is wonderful! Thank you so much, Phillip! 👍🏻

