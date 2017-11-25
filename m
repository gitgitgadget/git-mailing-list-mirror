Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7C2020954
	for <e@80x24.org>; Sat, 25 Nov 2017 22:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751690AbdKYWjT (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 17:39:19 -0500
Received: from mout.gmx.net ([212.227.17.20]:53571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751664AbdKYWjS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 17:39:18 -0500
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M2FhY-1fAQDY3ERQ-00s3eh; Sat, 25
 Nov 2017 23:39:16 +0100
Date:   Sat, 25 Nov 2017 23:38:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Roberto Garcia <eltitorober1985@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Clone repository computer A to remote B doenst work
In-Reply-To: <CAOeKBwpUDD_C5mQ54Aa2pj72aVkp9F2rkmGrSVMC81d6gJQRew@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1.1711252338050.6482@virtualbox>
References: <CAOeKBwpUDD_C5mQ54Aa2pj72aVkp9F2rkmGrSVMC81d6gJQRew@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:UY4ZX8CHE/qOodrwAywqhYCYvWtPROfTs5H0UylxKgxye8ieyc5
 1sA+P6Rr+UkOt7Pq40vlJC810lCkrNaln3znq+my0rV/8cSbX99z64z4VOnkSxqm2O/t1D4
 eC4bmPg/0d6A5v7zaZCYW4npRzVJuJSYshFW+4TL8DF/DkRnXaASMLq/ACpCgag4tFiDIRM
 0c6bMJxHgqNXhCdXiT65g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:m4PqD0RTqOs=:ur964Pm0jwBPYr2J7Shebg
 VbRd5BmLn3CCb3FAdosTYyJ/zI8OycTWla2hoDXjqXBTn+VoAs3zSRgErrQ3CLvxPl9S7sPHT
 7pRbPhny70Sp+V1JZ6WcOd1kWsigWKk36TGLcljOkcRtp87mIi2j6M6wCj8/v5UbAtWVJhjcG
 fnsM9VbOGiTcrYjDcmn7HNdQ7bJZOYuyKQGqpvep5ADyMZC2W6pexg+lwS+S0zeEbOFfcuFGS
 C9XHDmhuMyhaZkqO0aLIZ56Th8w3MIeoDVK7jq/4NOtqAWL/8ODmE8q2Cqh0kdPlqfapwzPBv
 gt1/WXQjAU2KuEobeg6X0A1/wwwEdvGxOweApAhywN9aPP4edYvTtheBrTMB6e9jXSQyaE+5m
 gB6N925tmzF0D0sen0+P/H8FxzutJ5XOn546jFtl4/rMYFvbpHiN3GneIVSyGuUgNhqx6qmSf
 FBnYHv6R/weHqPG9QAD6JIYDSqN0tuUS651J8See0U86DUgUAq4c7f+4906HXv3pNNgzfma3B
 ob2Di5CjQ5to4UVubkwgyXCkSBXrjXw1BwzkLIsgkdPmQ9yDz17w0Kn731LtplHeQ0PC++xEN
 7bkcgr4EW6OldCyjV+nXhIKjSC67fUhLEe+1jq2QWocjBp+mzZMMU7rOD4cDi4JWxdEnW5I/k
 4h7B25YRKIrobXv95ZazvA5LquZt61k+YqWbgt7KxhAphrfIq0WYzEOZCf9EXVxjZefSo66Lw
 6Mby+8Mlbw+z2QQ6zligcFdgVdITL57sgNfOTzYKCXO9Qy0hczc32TCD8xHqUFPjUc6M1tQ0q
 ul4ve7js7E7sNMcmvzvhkj5GIOUiQwywUTLz3FQizz0eQqQTyhmeIHhb/EVGmd5YNiK+gRP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Roberto,

On Sat, 25 Nov 2017, Roberto Garcia wrote:

> I'm trying clone in windows a git repository to other remote machine
> (NAS Linux based).
> I have installed git for windows but i didn't installed nothing in the
> other remote machine (NAS Linux based).

You need a Git on the remote side. Otherwise Git will not be able to clone
from there.

Ciao,
Johannes
