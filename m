Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5381C433FE
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 10:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B84F22D3E
	for <git@archiver.kernel.org>; Sat, 12 Dec 2020 10:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438680AbgLLK2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 05:28:51 -0500
Received: from 213-229-72-132.static.as29550.net ([213.229.72.132]:50816 "EHLO
        host.syrsecserve.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391220AbgLLK2v (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Dec 2020 05:28:51 -0500
X-Greylist: delayed 14220 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Dec 2020 05:28:50 EST
Received: from syrsecserve.com (ec2-18-188-134-62.us-east-2.compute.amazonaws.com [18.188.134.62])
        by host.syrsecserve.com (Postfix) with ESMTPA id D258B3276905
        for <git@vger.kernel.org>; Sat, 12 Dec 2020 01:53:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 host.syrsecserve.com D258B3276905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrsecserve.com;
        s=default; t=1607737991;
        bh=TyDrvEeEFdXlR/MshqaTYzQ7nnR7m/zs1uM19XkvmD0=;
        h=Reply-To:From:To:Subject:Date:From;
        b=QV19Va9Tyj2jlShpi3RR6Xp2KnJR+6ieTd1vbms+5XWXI02qwtDRPqEAG+m0ePJCf
         0w08+Bco7KjUNnldIq+OZQV468g8s6w/RHeHofcr1Z+xgJ0DzX6FMyx2J38si7iccJ
         YjlmHLSP0YwzSS3QEKzLjhU06IFM5kSroByAllLQ=
DKIM-Filter: OpenDKIM Filter v2.11.0 host.syrsecserve.com D258B3276905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syrsecserve.com;
        s=default; t=1607737991;
        bh=TyDrvEeEFdXlR/MshqaTYzQ7nnR7m/zs1uM19XkvmD0=;
        h=Reply-To:From:To:Subject:Date:From;
        b=QV19Va9Tyj2jlShpi3RR6Xp2KnJR+6ieTd1vbms+5XWXI02qwtDRPqEAG+m0ePJCf
         0w08+Bco7KjUNnldIq+OZQV468g8s6w/RHeHofcr1Z+xgJ0DzX6FMyx2J38si7iccJ
         YjlmHLSP0YwzSS3QEKzLjhU06IFM5kSroByAllLQ=
Reply-To: moutraore01@syriservas.com
From:   Moussa <moutraore01@syrsecserve.com>
To:     git@vger.kernel.org
Subject: Response Required
Date:   12 Dec 2020 01:53:06 +0000
Message-ID: <20201212015306.5F56EE8FC4BE5518@syrsecserve.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Greeetings from Mali. I am sorry for contacting you like this but=20
I do have a very urgent matter that I want to discuss with you.=20
Before I proceed, I want you to keep an open mind while reading=20
this proposal. My name is Moussa Traore, I am the Personal=20
Assistant to Mr. Issa Saley Maiga who was the head of the civil=20
aviation agency in Mali during the tenure of Ibrahim Boubacar=20
Ke=C3=AFta, the former president of Mali. His tenure was overtaken by=20
the military during a coup d'etat. I am sure you would have read=20
about this in your country because it was covered by the=20
international news agencies worldwide. 

Anyway, my boss was also affected by the coup d'etat and he was=20
arrested along with other high profile politicians. Also, all of=20
his local assets (bother property and financial assets) were=20
seized by the Government. Due to this situation, my boss belives=20
that he is at risk and he is now very scared for the safety of=20
his family especially his wife and kids. In order to ensure that=20
his family is taken care of and protected incase anything happens=20
to him, he has asked me to help him find a foreign investor who=20
can help him accommodate and manage the finanical assets that he=20
has in Europe. These assets was secured with the help of a proxy=20
and it is currently held with an offshore financial bank so it is=20
safe so secure. Also, the Government of his country do not know=20
of this asset hence why they are unable to seize it as they have=20
done his other assets.

My proposal to you is for you to help us manage these funds, and=20
invest it in lucrative projects in your country that will yeild=20
good profits. You also do not have to worry about if this is safe=20
or not because everything will be handled in a legal and=20
transparent manner. You will also be handosmely rewarded for your=20
help if you decide to work with us. If this proposal interests=20
you, please kindly respond so that I can give you more details. I=20
hope to hear from you soon.

Regards,

Moussa.
