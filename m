Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_20,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94B3C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9313F61159
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 21:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFOVjl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 17:39:41 -0400
Received: from elephants.elehost.com ([216.66.27.132]:29734 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbhFOVjG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 17:39:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 15FLavwp064034
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 15 Jun 2021 17:36:57 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'LeMieux, Janel'" <LeMieuxJ@issaquah.wednet.edu>,
        <git@vger.kernel.org>
References: <SJ0PR11MB48309669D8DE8A299D607F7A8D309@SJ0PR11MB4830.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB48309669D8DE8A299D607F7A8D309@SJ0PR11MB4830.namprd11.prod.outlook.com>
Subject: RE: Allowed list
Date:   Tue, 15 Jun 2021 17:36:52 -0400
Message-ID: <007e01d7622e$9176ab10$b4640130$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJGencwoi+7yD1UyePWaFLNPhUVDao3Z8kw
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On June 15, 2021 4:51 PM, LeMieux, Janel wrote:
>To: git@vger.kernel.org
>Subject: Allowed list
>
>Hello -
>
>I work for a public school and our students all have school email addresses but they only accept internal emails unless we add
senders to
>our "safe sender" list. Which service related email accounts should we add to our student email server for students to be able to
create
>and maintain a Git account?

You do not need an account to work directly with git. However, it may be that you are using GitHub or some other Cloud git provider.
You would need accounts for that and should contact the provider directly.

Regards,
Randall


