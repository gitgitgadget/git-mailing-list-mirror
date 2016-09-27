Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E8BC207EC
	for <e@80x24.org>; Tue, 27 Sep 2016 00:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933018AbcI0ANP (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 20:13:15 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:54537 "EHLO
        homiemail-a20.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932449AbcI0ANN (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 26 Sep 2016 20:13:13 -0400
Received: from homiemail-a20.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTP id 2898A7EC064;
        Mon, 26 Sep 2016 17:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=DtgOY
        em/oCOYVZf2u9c0qSAw0AQ=; b=RHKQw863/jPQyWg0mgFClf2CLeJjNEITFRVaq
        H7ufUTFV1oW4uN0FaT8Zod2UqnJC7ke7yy2rrBzud3WIuSd5fbFn8DrF1dOE7OdC
        id/otvzW84RKttKzuxgrM2o57bw9dIgkxzPl61b4NgHBJA51iCsOxO2tUxAdSdLb
        1g88W0=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a20.g.dreamhost.com (Postfix) with ESMTPSA id C23B77EC061;
        Mon, 26 Sep 2016 17:13:12 -0700 (PDT)
Message-ID: <1474935191.26902.0.camel@frank>
Subject: Re: [PATCH 3/3] add David Turner's Two Sigma address
From:   David Turner <novalis@novalis.org>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Date:   Mon, 26 Sep 2016 20:13:11 -0400
In-Reply-To: <1474935093-26757-3-git-send-email-dturner@twosigma.com>
References: <1474935093-26757-1-git-send-email-dturner@twosigma.com>
         <1474935093-26757-3-git-send-email-dturner@twosigma.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the bad subject line, this is of course v2 of the series.

On Mon, 2016-09-26 at 20:11 -0400, David Turner wrote:
> From: David Turner <novalis@novalis.org>
>=20
> Signed-off-by: David Turner <novalis@novalis.org>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/.mailmap b/.mailmap
> index 9441a54..9cc33e9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -48,6 +48,7 @@ David K=C3=A5gedal <davidk@lysator.liu.se>
>  David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
>  David S. Miller <davem@davemloft.net>
>  David Turner <novalis@novalis.org> <dturner@twopensource.com>
> +David Turner <novalis@novalis.org> <dturner@twosigma.com>
>  Deskin Miller <deskinm@umich.edu>
>  Dirk S=C3=BCsserott <newsletter@dirk.my1.cc>
>  Eric Blake <eblake@redhat.com> <ebb9@byu.net>


