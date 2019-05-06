Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F1D61F45F
	for <e@80x24.org>; Mon,  6 May 2019 14:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfEFOtT (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 10:49:19 -0400
Received: from [193.29.56.124] ([193.29.56.124]:56186 "EHLO iodev.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfEFOtS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 10:49:18 -0400
X-Greylist: delayed 470 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 May 2019 10:49:17 EDT
Date:   Mon, 6 May 2019 16:41:22 +0200
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v3] git-gui: Handle Ctrl + BS/Del in the commit msg
Message-ID: <20190506144122.GE4920@kiki>
References: <20190408125406.16703-1-ismael.luceno@silicon-gears.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408125406.16703-1-ismael.luceno@silicon-gears.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/Apr/2019 12:54, Ismael Luceno Cortes wrote:
> - Control+BackSpace: Delete word to the left of the cursor.
> - Control+Delete   : Delete word to the right of the cursor.
> 
> Originally introduced by BRIEF and Turbo Vision between 1985 and 1992,
> they were adopted by most CUA-Compliant UIs, including those of: OS/2,
> Windows, Mac OS, Qt, GTK, Open/Libre Office, Gecko, and GNU Emacs.
> 
> In both cases Tk already implements the functionality bound to other key
> combination, so we use that.
<...>

Ping.
