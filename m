Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD7AC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 04:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbiCDErV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 23:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiCDErU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 23:47:20 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AE5EBAFD
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 20:46:33 -0800 (PST)
Received: from Ericlaptop ([50.225.6.229]) by mrelay.perfora.net (mreueus002
 [74.208.5.2]) with ESMTPSA (Nemesis) id 0M2bYp-1oHYIH1mXF-00sLBq for
 <git@vger.kernel.org>; Fri, 04 Mar 2022 05:46:32 +0100
Reply-To: <AstroEric@eccssw.com>
From:   "Eric Claeys" <AstroEric@eccssw.com>
To:     <git@vger.kernel.org>
Subject: FIles in GutHub but not in package
Date:   Thu, 3 Mar 2022 22:46:31 -0600
Organization: Astronomy
Message-ID: <00bb01d82f82$d21c65c0$76553140$@eccssw.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adgvgrj2E7sTM2H4SXSZIqhhELpVxA==
Content-Language: en-us
X-Provags-ID: V03:K1:04DK/AQh0V30CTLkCI1rDrPDwQ9dMiV10fGNDXkNxmW/xYSzz+u
 apVC12Tj1hjfIFEi755DIfet/6eNa7gDuudZyHtWEplzOomsI7r882PSV0kZQEI+LzRUiyV
 bvt4nVuXlnUTbQcyuqgaNifuxwl3a6cVuqSBMwd4bmjQaj8O953+Xh3d0PH2lsFr4BDW+no
 3Tij5kmJd30dLzf0FRIrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QLh1VoJ8FrQ=:J62EEiNeUvzHbaSuyDUsYp
 +UZyKLL1XXMrGOMJcAQOTwdV0ULcNHDD5vSVghq3NR9M0wObPDyR9X1PAdmFoBPqOoSasSkwl
 3zK9ifE86qgZS5AM4jGgJkbeVbKiJwYXCzELsMkzUnOkj8o+MyMAMXev1yrsc4Cb1MjQwS/G7
 ANDrrfSwhFUNc/J+JpHbx8KwPLiotCCzA8vehaTmop1Lj23YLXEs57XA3VdIzriR94a9ftl/m
 1e25/ttiQYcjQCbc2rUIYBT1mapGYkpBXhET9EGGK5IA4fFl+rEjb7N/6hMUul031tWmhNmFD
 GJEEaTAxxZe0wa3yTLoh+tuW5TeEQTbUrO7+8kspogttvZVbDH1a3eFevr+l95HeHrg3MRR68
 k/4778ElQooHr4c/71JZSJYNGqYYCjw3DuCddNFdfIv0HdZYVH7u8DrjFhROI9Wm1M0q+U5q0
 IBC1xD1FEUpXJxM2QmnzjqpLR/tD70efczoruZPksXjpYto1sLsQISwwF5T4mTJKAjQNi3hSZ
 abfyxoIZvcqcEHCqDbl96vYHd/iEUtvaKxKQOpgYdZy+DU5UiQa4FWQCve2YaP8dwgVlN5K6l
 HGXtFBL/EaHHexEJd4lJ394wKKQy/mR1Q+gH2z/vJeHfXiBnGZAG4r6D0zT/CiaY4pZQwDcBf
 b8EGnH/QFE1JMM5zq/ngtln2BS+sSPFuXmZJJ8klM9YL92PRzYucdK566X/EV+tjSXso=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'd like to store some files on our GitHub site, but not have them included
when someone grabs our repository via:
    git clone --recursive https://github.com/thomasjacquin/allsky.git

Is that possible, and if so, how?  I prefer to use the GitHub web interface
to do this.

Thanks - Eric

