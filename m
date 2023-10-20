Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695371D532
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkzX56WB"
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097D6D45
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:20:46 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso1208190a12.1
        for <git@vger.kernel.org>; Fri, 20 Oct 2023 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697811644; x=1698416444; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=baIiqun9xASEkCLW7mDYqgiCpjMQlAUeAf14M9An3Qs=;
        b=mkzX56WB4YTnVCOuWVSEi5FFd2ncOaAbpI22V8AFSqvKqz41hK49qsnzFTOW8kMFke
         6OX7A5cLOnJHAeUERk78IkZR+uFenpQaDICJObIUK+LHkeKtRtx8eDyF069WUFU6Gn/c
         opeZ2vzazpWOJSnaIhiFWQ5q4oJlikLtDTJn6p62w4AMdQ55sLCL6yMZp+IslZpagaTy
         E8i8IsQ3Aqtg8FheH0Ke8Fm6he9FEKt5BLakBM1X2KKFy2ceCqaPc8sdLaeM8WDf0n15
         a578XonXtWNudQqqAI8SH/dIjTbmw3LUnM1WdIgQNacjZ4Z4gFzn5EbjdltzMbTPSl1x
         LrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697811644; x=1698416444;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=baIiqun9xASEkCLW7mDYqgiCpjMQlAUeAf14M9An3Qs=;
        b=AgBs8CT1uxF2mEfF96lkbV9VX/QZKREhuvb0NT1qfQc7VjoL9Qdu2+pym/xNRFYA2b
         eNEvJUJLPpAHAPY4R88jT6zCxd/3U81TNm+KIv93qQIt7Tk4uvUlaJWjSY5V7JHVhwtX
         P5cx/p/sGOaUXfN8v4rcGf0CfQrOG5ZbWq0GJtgJ7VCiWl+3LkVb7EZSEvfShsS9nWrq
         OAdYu+nJgSEnsjZUwR1tsSselilPHeXq+s86wZX6T7JxxZO0P5zKsozp/qiepg99orGN
         LuatyUNzkBA0ZAM8dxYe6tXJYHqcnBgvwKCizygT44NJcjX1mvHp/gUseqDfQh+esmEA
         zZaw==
X-Gm-Message-State: AOJu0YxNf4N8r9J88www0qCEBanPK7r0+3sAwrOeuOItU9qcaunse/R8
	TRETzzhtjk0M+Nhp8JEbrX6WfB3A0BAH4Fi9cL5zEJrDfb0SwQ==
X-Google-Smtp-Source: AGHT+IEktTin7GeZ11B1A8C7hqyS8m1p18zRrFxntmO/oaV3t8dsct6lpbSONnbUZl1jph28r8O5ZALNqxn6HoefeK4=
X-Received: by 2002:a05:6402:520b:b0:53f:b758:22a3 with SMTP id
 s11-20020a056402520b00b0053fb75822a3mr1716471edd.3.1697811644139; Fri, 20 Oct
 2023 07:20:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brock Whitaker <brock.e.whitaker@gmail.com>
Date: Fri, 20 Oct 2023 10:20:33 -0400
Message-ID: <CAGUSxisVxXDLyFQ-KQHQdtTqF5UihhnJ22rtTn-r9J94ToeuXg@mail.gmail.com>
Subject: Thanks and One Suggestion
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for the git-scm site. It's an invaluable resource I use often.

My only issue with it is the text isn't as easy to read as I would
like. The orange text on a white background is a little tough to read
sometimes. A higher contrast between text and background color would
help.

Splitting hairs,

B

PS - Thanks again for a super useful resource!
