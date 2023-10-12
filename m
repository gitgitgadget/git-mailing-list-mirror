Return-Path: <git+bounces-1-git=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24659CDB46E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 20:31:02 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5731281079
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B823D960;
	Thu, 12 Oct 2023 20:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i4W5VfEB"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59373D962
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 20:30:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31CBB
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:30:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7E4C433C7;
	Thu, 12 Oct 2023 20:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697142655;
	bh=Ym/pxMbdvm247vTaNNOcOCuORilqXz04df7lVT2ORUM=;
	h=Date:From:To:Subject:From;
	b=i4W5VfEBiRw94Rl31Z5XOvYucMCJPhYD3m5HeevWZjBEOduD66TA5B1UC3eIuMoeM
	 tCFfHzMOkHAO7pPZXON7axpc3p8D4gUWdcePZZxNkCAHDLt7nIK6K17jH0wmC4n8pK
	 B278InX6Ul30wKawc5+MxMlDrnFblksKR3pE5/jg=
Date: Thu, 12 Oct 2023 16:30:54 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: git@vger.kernel.org
Subject: This list is being migrated to new infrastructure (no action
 required)
Message-ID: <20231012-party-legwarmer-551ab7@meerkat>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list is being migrated to the new vger infrastructure. This should be a
fully transparent process and you don't need to change anything about how you
participate with the list or how you receive mail.

There will be a brief delay with archives on lore.kernel.org. I will follow up
once the archive migration has been completed.

Best regards,
Konstantin

