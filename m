Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49340C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 17:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbiKRR5M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 12:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbiKRR5B (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 12:57:01 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999A70192
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 09:56:56 -0800 (PST)
Date:   Fri, 18 Nov 2022 17:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
        s=protonmail3; t=1668794214; x=1669053414;
        bh=TCX8fMK3vNnNIkgVTjSnxDG8fb1k4zPBiQh4Mc9vdS8=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=ktYTDRKKDxhoFli8jM4EDRyvV7NL3/Gcbs9Oae2Zpvc/8uE8laEUCsUvWF2HAWP1C
         b6wzj2qYi+iQoIbOLG2AJRxiSyqtQJo/xHzFuHd5PoE4+wYwS/C6Lmd7doAsY51iNO
         rsQU6KaDOOkKNqTCPh37vv2ZeHzwVTzoiZk/dP30uNsgS+YbTHvRiynIjMSv9WO6A/
         4Q+wV/jQ93b69k1p9eiNPc4spPrpBUuxlNA8RbqhhUerov8yqueNpwf1wikHD3XJ30
         bkaitYlrWLxP/hy4CGX2f9yv58N3Sxg8IQCDnOABXo8fJwhJWM0hsagE6Braeh3tTa
         nlP4fzV9Wv9OA==
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   David Cowden <dcow@pm.me>
Subject: git-subtree docs missing
Message-ID: <MzUvo2TfR7gGs7FQsyF-0TqfSNT6X_9eZlBkFBDoa2IrpnT81MYqhNJUKh_aSsNJaH0HrM9PeoQhx6LMlFy3bd3bVCo9aqlT_7Ul-wE6LkE=@pm.me>
Feedback-ID: 9064091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What happened to the git-subtree docs on git-scm.com? https://git-scm.com/d=
ocs/git-subtree currently redirects to https://git-scm.com/docs.

David
