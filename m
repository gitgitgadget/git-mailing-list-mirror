Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891961F404
	for <e@80x24.org>; Thu, 14 Dec 2017 17:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754419AbdLNRsc convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 14 Dec 2017 12:48:32 -0500
Received: from aibo.runbox.com ([91.220.196.211]:40378 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754377AbdLNRsa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 12:48:30 -0500
Received: from [10.9.9.211] (helo=mailfront11.runbox.com)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <dwheeler@dwheeler.com>)
        id 1ePXcT-0004a2-4w; Thu, 14 Dec 2017 18:48:29 +0100
Received: from [198.97.200.97] (helo=[172.16.31.97])
        by mailfront11.runbox.com with esmtpsa  (uid:258406 )  (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        id 1ePXcJ-0004iy-EV; Thu, 14 Dec 2017 18:48:19 +0100
Date:   Thu, 14 Dec 2017 12:48:10 -0500
In-Reply-To: <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
References: <E1eOwqn-0005Bd-OB@rmmprod05.runbox> <CA+P7+xrWFE+6t-Z8cGQX5WtZP1_EQSa+J7vF65dLDSOnLfFxXQ@mail.gmail.com> <01075529-4B7B-4C05-927F-0504315F2B3F@dwheeler.com> <CACBZZX5XDKwwXWtH8V9QD5v-4i+nHPuZ8x2n_Z3zuexQmg2mgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] doc: Modify git-add doc to say "staging area"
To:     =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
CC:     Jacob Keller <jacob.keller@gmail.com>, git <git@vger.kernel.org>
From:   "David A. Wheeler" <dwheeler@dwheeler.com>
Message-ID: <662C691D-7263-4469-87F4-4BA8A50CC4E8@dwheeler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 13, 2017 7:54:04 AM EST, "Ævar Arnfjörð Bjarmason" <avarab@gmail.com> wrote:
>After your patch the majority of the docs will still talk about
>"index", is this part of some larger series, perhaps it would be good
>to see it all at once...

Yes, this would be part of a larger series.

I'm happy to do the work, but I don't want to do it if it's just going to be rejected.

The work is very straightforward, in almost all cases you simply replace the word index with the phrase staging area.  The change is similar for the word cache.  So I'm not sure what seeing it all at once would do for anybody.

Are there one or two other files that you would like to see transformed to see as an example?  If you're just looking for a sense of it, that should be enough.




--- David A.Wheeler
