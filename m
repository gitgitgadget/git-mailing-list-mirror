Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1CC1FF40
	for <e@80x24.org>; Mon, 12 Dec 2016 01:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753932AbcLLB6a (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Dec 2016 20:58:30 -0500
Received: from ozlabs.org ([103.22.144.67]:34571 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753804AbcLLB62 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2016 20:58:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tcQwg13F5z9t15; Mon, 12 Dec 2016 12:58:27 +1100 (AEDT)
Date:   Mon, 12 Dec 2016 11:02:19 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Rogier Goossens <goossens.rogier@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] gitk: Two improvements to the branch context menu
Message-ID: <20161212000219.GC18316@fergus.ozlabs.ibm.com>
References: <51900395.pKIx87RN0F@wiske>
 <10662590.KWXHt2RUKZ@wiske>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10662590.KWXHt2RUKZ@wiske>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 19, 2016 at 07:31:32PM +0100, Rogier Goossens wrote:
> Hi,
> 
> Hereby the revised patches.
> 
> Changes since v1:
> - Rebased on latest master
> - Made the changes you suggested
> - Moved 'rename branch' menu option above 'delete branch'
> - Cleaned up some code duplication that the previous patches 
> introduced.

Thanks, series applied.

Paul.
