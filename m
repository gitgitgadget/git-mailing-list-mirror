Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15435C433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4DFC22288
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 14:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgLXOuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 09:50:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:58974 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgLXOuI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 09:50:08 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 0BOEnOBl057838
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 24 Dec 2020 09:49:24 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Christian Couder'" <christian.couder@gmail.com>
Cc:     "'git'" <git@vger.kernel.org>
References: <xmqqtusc5djv.fsf@gitster.c.googlers.com>        <CAP8UFD3aHEpHZWxzwz=RQr7DNAmJhLeoiOzubRqk1=7gRyG4_g@mail.gmail.com>        <xmqqblej4t1a.fsf@gitster.c.googlers.com> <xmqq7dp74so8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dp74so8.fsf@gitster.c.googlers.com>
Subject: RE: [ANNOUNCE] Git v2.30.0-rc2
Date:   Thu, 24 Dec 2020 09:49:18 -0500
Message-ID: <00ed01d6da03$f8928fc0$e9b7af40$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQEBp1sWVcaM8tnZJX5LB45UAO3TMQDPP5lbAniweocBYzWV5auLXiPQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 24, 2020 1:36 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> >> Most of the suggestions below are found by GMail.
> >>
> >> On Thu, Dec 24, 2020 at 12:08 AM Junio C Hamano <gitster@pobox.com>
> wrote:
> >>>
> >>> A release candidate Git v2.30.0-rc2 is now available for testing at
> >>> the usual places.  It is comprised of 19 non-merge commits since
> >>
> >> Maybe: s/is comprised of/comprises/
> >
> > Funny.
> >
> > I do recall somebody else (perhaps Peff but I may be misremembering)
> > helped me grammofixing the use of verb "comprise" in the sentence when
> > I started listing the names of commit authors back in v2.3.3 or
> > v2.4.0 era.  Perhaps I failed to follow the advice given?  I dunno.

NonStop test cycle in progress on both platforms.

And "comprises" is considered correct as the present tense according to
Merriam-Webster. "Is comprised of" is more formal and tends to get edited
down to "comprises" by current grammar checkers to reduce use of the passive
form of verbs that pervades technical documents and thesis papers.

Regards,
Randall "Grammar Nerd" Becker


