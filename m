Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201B7C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 12:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350664AbiBCM6W convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 3 Feb 2022 07:58:22 -0500
Received: from elephants.elehost.com ([216.66.27.132]:34610 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242795AbiBCM6V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 07:58:21 -0500
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 213CwKUm044283
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 3 Feb 2022 07:58:20 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Jean-No=C3=ABl_Avila'?=" <avila.jn@gmail.com>,
        <git@vger.kernel.org>
References: <016401d81547$728834e0$57989ea0$@nexbridge.com> <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com>
In-Reply-To: <0c47248d-13b8-9d80-b03f-8ac6fd4ac91e@gmail.com>
Subject: RE: [Question] Translation Dictionary
Date:   Thu, 3 Feb 2022 07:58:15 -0500
Organization: Nexbridge Inc.
Message-ID: <02f001d818fd$b872e680$2958b380$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHny4N9HGuOldLgj1yDpZlahXxp4QKviEmMrEzmYHA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 3 février 2022 à 04:37, Jean-Noël Avila a écrit:
> I guess not all git translators are subscribed to the mailing list, as they mostly
> interact with Jiang. I put them in cc.
> 
> For French, I try to maintain a glossary of terms in the header of the `fr.po` file,
> available here:
> https://github.com/git/git/blob/master/po/fr.po
> 
> Best regards,
> 
> Jean-Noël
> 
> 
> Le 29/01/2022 à 20:35, rsbecker@nexbridge.com a écrit :
> > To the git translators.
> >
> > I was wondering whether there is an official translation dictionary
> > for git-related terms. At times, I am asked to provide presentations
> > with an initial translation to companies in various parts of the
> > world. It would be nice to be able to follow the official set of terms
> > used in git translations. Does such a thing exist?

This is exactly what I was hoping. I have a suspicion that the fr_CA region may have slight variances from this this - based on the Grande Dictionnaire I have from a few years back, but that changes often. I was on another project where we tried to keep in sync with Quebec's terms and had to do an annual review to pick up changes. In any event, this helps tremendously at least for LANG=fr.

Kind Regards,
Randall

