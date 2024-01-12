Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A85C902
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4TBDTK5sscz5tlH;
	Fri, 12 Jan 2024 08:59:33 +0100 (CET)
Message-ID: <ff7a568d-dcf7-4230-ba08-5234b505ab8f@kdbg.org>
Date: Fri, 12 Jan 2024 08:59:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] `log --merge` also for rebase/cherry pick/revert
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: phillip.wood123@gmail.com, git@vger.kernel.org
References: <20240111233311.64734-1-mi.al.lohmann@gmail.com>
 <ce46229d-8964-4445-9a17-cff40aca1cb4@kdbg.org>
In-Reply-To: <ce46229d-8964-4445-9a17-cff40aca1cb4@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 12.01.24 um 08:35 schrieb Johannes Sixt:
> ... (in particular, the author date):
> https://github.com/j6t/git/commit/2327526213bc2fc3c109c1d8b4b0d95032346ff0

The Github UI is a bit unhelpful here. The author date is Nov 11, 2014.

-- Hannes

