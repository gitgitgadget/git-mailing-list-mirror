Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78EC01F453
	for <e@80x24.org>; Tue,  2 Oct 2018 22:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJCFpk (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 01:45:40 -0400
Received: from mout.gmx.net ([212.227.17.20]:47921 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725198AbeJCFpk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 01:45:40 -0400
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1fKtLL3O1g-00mauW; Wed, 03
 Oct 2018 00:59:51 +0200
Received: from [192.168.0.171] ([37.201.193.149]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LhSfM-1fKtLL3O1g-00mauW; Wed, 03
 Oct 2018 00:59:51 +0200
Date:   Wed, 3 Oct 2018 00:59:52 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     David Brown <david@davidwbrown.name>
cc:     git@vger.kernel.org
Subject: Re: git clone works in ide but not git bash CLI
In-Reply-To: <2e7399d2595f403507ebbe748ee5f5ae@davidwbrown.name>
Message-ID: <nycvar.QRO.7.76.6.1810030058530.2034@tvgsbejvaqbjf.bet>
References: <2e7399d2595f403507ebbe748ee5f5ae@davidwbrown.name>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2+6CE7CXfnyG1gLrxnnKIFqXDuTKCYAnRiV6HngR5Ulvlzd/jnA
 YiNOVmZJwQOJz6SDSWMvC+siJOhjoO4djZNAxw9u/ndgd9h0j89iQe3mOZN4vdiBw0PX0Xm
 agLSQtx8SOmnjmHgKXNd/81nqS7Yg4FvlsTnlYgTxQzxrJ8uqvQCPNr6FdXhsYAn1u2Q+Y5
 U6lyqVCy8RyQ1NMnnAA3g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2zDZTY5mcJQ=:yKqFS7dgFgi8NWvkzp0YYu
 eI2ueBptgK2HSKkClu55UUdgEWT5N3HOXQPc2X9kplKSJwcnV3dy+vsa4LWebHB6+Jd+OMaEL
 ATzZOJw1QVQYuwJGzfFlowYoinUDcSiRg5HVNqn4p6WrUOeK+JH6S4BQjxqOnA9cJfdlckei3
 JFoCLXzbkYaAdiGI3mivDevyWIiaL9+ohSFgl19F3ZA2Un9sSEziWUY4ixgwbLf41/k9tEokW
 7lkq1c/+OiEZqa1JyN674XYNPxuv6nZTkrA6gFFhXDJ+yLSYctXIE6BqWmpVzk1dodd2nHG20
 wz4wQO6DyNJz5Y1zLZbWnLQOv2MT1VGsf999BSXZ9o2+ezbCd/OL1j0K1YVL/WH8+hlhU/q0x
 C5FEavaAjkBZfTIULcOPaaqTcn11Dy3xoucecUGx+WQW/p+ziCbItEWzESYBHOBMZgngD+N8b
 /qtHD4hqsZPrDzYy4+JOVCVVL7xkFuQ0raRfORzXGzr37T6VQQTzHyb2bNe6Ke5/eh50BYPKE
 TIz0GrRnK0qQAwVbCha0sQVHySWGiVYHrl6q6tu2xF+WEKWmcUr4/A+MEX/CJ/A3UvkXXIGGh
 mGYbmbEKYUdf1jHxKQxCHwU5CpnLgVxoZBJMO7NmBCsNXUvbzNSp1nj4BWSscno88H77APpPz
 hkAxdoo2ZzFdRRXyFT/6zQWUzRfi2AFnjpPo7YxZxZVI/s0wSSEkX/dydIfFWBxANn4Z5J4qL
 jxHcbv1D6CVbonXA4W3LEfFw2PFNi3E+XVQMfDhr+NF1WcvTIbUhrjdU62+dPcqzMkleckmkz
 7zODFsyNny3kOAWl6sghvftlELUFgmatkmxB8Me8IkyORLKxfc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi David,

On Mon, 24 Sep 2018, David Brown wrote:

> Howdy, I have a conundrum:
> 
> App: Spring Cloud Config Server
> envvars: GIT_URL and SSH_KEY
> IDE: Intellij 2018.2.4 Ultimate
> 
> When I use the IDE to assign the SSH_KEY value all is copacetic.
> 
> If I assign the envvar at the Git Bash CLI:
> 
> com.jcraft.jsch.JSchException: Auth fail
> 
> Any guesses?

This sounds like you use JGit somehow? Whereas "Git Bash CLI" suggests
that you actually want to use Git for Windows?

Ciao,
Johannes

> Thanks and regards,
> 
> 
