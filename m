Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638461FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 12:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbdJ3Mua (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 08:50:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:54521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbdJ3Mu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 08:50:29 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M8m7Q-1e1QpY3aNY-00CArN; Mon, 30
 Oct 2017 13:50:24 +0100
Date:   Mon, 30 Oct 2017 13:50:24 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: A note from the maintainer
In-Reply-To: <xmqqy3nt40pq.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1710301348350.6482@virtualbox>
References: <xmqqy3nt40pq.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:QOb+c17N6gTemUJqQeVzCpJ0qAak/BE2yF5mJ3gyj3eOpnuFVnl
 CphF7IkGUzxfzbgEWk85buaLTeBFqMPFJ4d4IjkT+nkesdJW/AhXR4qQGuby+TI73NXOQV/
 stmgU10kHuolYeW9NFebK6AWWjY3K5lb1Y1PogoJs2kx04ZsTplGt8WRJE01YSTRIYI6kWl
 DIXHEonam9wP76awsdE2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eWO/y4w/0hI=:eOxklLClOPE4s1inAtisqt
 zfthJenfuxrRf4x7DmYqM4qoRvAfkcX9LYvhlqLkLpra/g4BSVrTNtl07XFFhXwFjWO8n9ObJ
 VS3VZR878QNGYAHEzYth3PTj8/1de+U4QC3O9sarCaHuZLeMP8VKBXbTOmLgBmBuAc9sIJPFg
 IrAhBYeR908tc3CqoTD3UpXeVIBveV1mkviDgrf5A0hQ8LtqlS88LgJhAMUzFcKmRKwTde+zR
 XbfThMLHI3XxEZgbFO9vYbKJescCUT4r/1e80gvWesbr93VPGX99L6tnZ1dImZUPXsaO8oc+l
 xS/Jx967qD72ceyMGz+CAdYFbPHrm1wQBYdY2CbBO0JGYwzUrwuCKbyZnpUq+BK0Y7IWpUpTr
 F9hYgm2WusOZIHdkk0b87ou8qDkVEbdapyeEMzjJ/gNwoz6GTsSVyqHtcawiF+DO8AJ+nulAU
 R2mvWV+ZPgN52bk80J4GbLROZcT5JtVd/L19BpEY/LdP1cRJ/fqKiVPlxooKyabnjRLKfr3nk
 zNQC3/addHm9tZgpwQKfpWtEfowcDtnTS0CtMZSBaBgVR4eHOhC3oYmYObK7VOO0sHuO/wkXe
 PflAMFgFQdw8CEOoQjW+CcygZ2xeMfAjDfyYx4ndroRUHuGAkMz6soe2RHbiHXmtSUndlBkzv
 LStvdjjDE2L7AI9CmBzjjmhQ/FLfJQEueo3Px++Bo7IROYXd2qgod8JaFG7SC5hj4gv8QdLPb
 TRkfnhddW24FyLmVgEz0d1sGx+6D02RjvjIWnIKRiSuuM5hUEXJZzlYldgklkD051DBowIeIL
 c06YjOO6flrXpU1cGHrr6JLwszeHP96xMLrXwKqX0FUitfvF4JmMXRwXaiC98bFsneTiClV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 30 Oct 2017, Junio C Hamano wrote:

> The development is primarily done on the Git mailing list. Help
> requests, feature proposals, bug reports and patches should be sent to
> the list address <git@vger.kernel.org>.  You don't have to be
> subscribed to send messages.  The convention on the list is to keep
> everybody involved on Cc:, so it is unnecessary to say "Please Cc: me,
> I am not subscribed".

I have heard about a dozen complaints that mails were simply eaten by the
mailing list. At least some of those cases were due to HTML (or
HTML/plain) mails being quietly dropped, and it caused more than just
minor frustration.

Maybe mention this in your maintainer's note, to help stave off such
problems?

Ciao,
Dscho
