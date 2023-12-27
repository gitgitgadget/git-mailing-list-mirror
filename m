Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BCC2563
	for <git@vger.kernel.org>; Wed, 27 Dec 2023 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYv+s9hb"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bb0af58134so17687939f.3
        for <git@vger.kernel.org>; Tue, 26 Dec 2023 17:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703639882; x=1704244682; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=XYv+s9hbzJTetBZQ2rx01xgJnmrGd8B9ScTHBivejeBnAbaDbo3h4Qf5CaqNF3793u
         j2oTjscUaiMsnjftKC3lYyMerXx6indgq4UnUhuqZv1IzC0O7a9hdNU9JZ+rQTyvPFtc
         MFuxAVOHcje/Q4WA6H+7rOUEw8JJZ8YjgHPmDEa9IATwe/JMxTwtSHdFtNzT3N0fzfWe
         HtPa+vo2c9LHcBDkOfOw3mRv9PSoqM4NzVyjBNf/ARpnIuRd2GG2lrDg2CI/hys/7CXV
         LIQnd5SesgWpsQcnq9Zn0OsjgVWPkz+/iXZBoAt5XJr+SOHS4O22gZdjZ2T4nWY4qR/v
         KC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703639882; x=1704244682;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a67+Xn2ScPIinix0jYfRqCmskGmMpaGSAycuaim21OI=;
        b=FqNaRWAlTi/YexMPIIlq4w8HsI6lhSHHbfB5bORYnblNC2nZQJo4opEDLSNCCPDJCw
         RxX0Fkuf1ATCGfs3HhlLWy3zv3RNF7l/faq4r1eV2fXiClpelQaPBr46neF3+UxjUHCA
         JyiNG0rul//+o++SzPNdDMsgc07qOiI23Mm9G1TTCD4Nu1TPZ6SavGSdqlsU84auzYsx
         JabRpLwqRzMV1c/nM27EiQLr1xLsdayrJ/8zXaM+lm2mME0PVa1dR839ZDVf9HAjHF/N
         vITQ0lMoume5GeuDEiWGbJpoOSEu5rsL2Akd/uXgUc65eUwsXY5hf0wZKzdApSjaxRH5
         4png==
X-Gm-Message-State: AOJu0Yx16Uqfx05obXBZm9on/ttndD91+DTSDF7BsfdZtxeHc6oDA5G4
	hRp9d0qzZPbAc1DK6Wm749Duzyw9Qy/K7HHENlNGWMHi+/8=
X-Google-Smtp-Source: AGHT+IHZcXneziyIh3iP4WrheQZUOb1ASL4u4l2/kDL0/EKFUKwcIwjbKzdZ7O7uqsqSBYqFT3z1IiMScqp9qQ6RzXU=
X-Received: by 2002:a05:6e02:144c:b0:360:a97:9311 with SMTP id
 p12-20020a056e02144c00b003600a979311mr5677973ilo.29.1703639882198; Tue, 26
 Dec 2023 17:18:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kirandeep Paul <kdspaul@gmail.com>
Date: Tue, 26 Dec 2023 17:17:51 -0800
Message-ID: <CA+cTC5sAm9FSqs05=_OX_PbybAOcDdyfesJRwyKAzdotj+9N=A@mail.gmail.com>
Subject: subscribe to git mailing list
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe git
