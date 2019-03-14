Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1DB720248
	for <e@80x24.org>; Thu, 14 Mar 2019 09:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfCNJTI (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 05:19:08 -0400
Received: from ozlabs.org ([203.11.71.1]:41539 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbfCNJTH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 05:19:07 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 44Kjnj1hfSz9s7h; Thu, 14 Mar 2019 20:19:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1552555145; bh=e8/TbP+Re0KAWD/SIoH2/sSyVnvUDswtwb+/wqRBYKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giYO+cxVGgnHAjsf6TyeQmhLpr+jMDKLdmpvhwNFcnLCPM38QViMr/x5spGDzD0pi
         Zjw4zXgKvpc0DcNLnZBVOFqbAnScYDar+vS5aDBa7SFGxceIXdCU/6uBAX7V2f2qX7
         +08YUVWj3fBFmLSOy3LZRi+8DjlvmgLeA8c7qO33/fh4ZfKwnNqneuyCqLle8RXrDn
         cuHSwMqozEGL2MMkoR2mtjl38eHeai5oVczzfwgKmiRItbHznDbyiy0wq5un7lgVmU
         6IA/OLQWXzE2TyIG3McDpMTbt7D8V18JJcOGKJ66tR5kM89a/C/9BB0sqmGJZk2Xcq
         Smt0wpXLiV0Ng==
Date:   Thu, 14 Mar 2019 20:17:35 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Alexander Shopov <ash@kambanaria.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/1] gitk: Update Bulgarian translation (317t)
Message-ID: <20190314091735.GA19416@blackberry>
References: <20190313120646.14248-1-ash@kambanaria.org>
 <20190313122833.15897-1-ash@kambanaria.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313122833.15897-1-ash@kambanaria.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 01:28:33PM +0100, Alexander Shopov wrote:
> Signed-off-by: Alexander Shopov <ash@kambanaria.org>

Thanks, applied.

Paul.
