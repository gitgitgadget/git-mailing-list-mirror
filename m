Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF281F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 08:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbcJDIyN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 04:54:13 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:60751 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753860AbcJDIyL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 04:54:11 -0400
Received: from mfilter24-d.gandi.net (mfilter24-d.gandi.net [217.70.178.152])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id BFABE1720F0;
        Tue,  4 Oct 2016 10:54:09 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter24-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter24-d.gandi.net (mfilter24-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id aK8wS33QPpFK; Tue,  4 Oct 2016 10:54:08 +0200 (CEST)
X-Originating-IP: 46.232.148.34
Received: from localhost (ip-46-232-148-34.static.adsl.cheapnet.it [46.232.148.34])
        (Authenticated sender: strk@kbt.io)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 631921720D9;
        Tue,  4 Oct 2016 10:54:07 +0200 (CEST)
Date:   Tue, 4 Oct 2016 10:54:05 +0200
From:   Sandro Santilli <strk@kbt.io>
To:     Andrey Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: broken post-via-gmane link from https://git-scm.com/community
Message-ID: <20161004085405.GA22869@localhost>
References: <20161004081157.GB17002@localhost>
 <36c73304-aceb-7c51-2788-5ba4cdbc862f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36c73304-aceb-7c51-2788-5ba4cdbc862f@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 11:52:18AM +0300, Andrey Rybak wrote:
> Hi,
> 
> On 04.10.2016 11:11, Sandro Santilli wrote:
> > The "post via gmane" link on https://git-scm.com/community points
> > to an unexistent server 'post.gmane.org':
> > http://post.gmane.org/post.php?group=gmane.comp.version-control.git
> It would probably be better to address this on git-scm.com
> github page, where the source for the site is hosted:
> https://github.com/git/git-scm.com/issues

Done:
https://github.com/git/git-scm.com/issues/859

--strk;

  ()   Free GIS & Flash consultant/developer
  /\   https://strk.kbt.io/services.html
