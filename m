Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C68CD1FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 21:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbcLTVG1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 16:06:27 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:46622 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbcLTVG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 16:06:26 -0500
Received: from glandium by mitsuha.glandium.org with local (Exim 4.88)
        (envelope-from <mh@glandium.org>)
        id 1cJRc6-0008PC-0N; Wed, 21 Dec 2016 06:06:22 +0900
Date:   Wed, 21 Dec 2016 06:06:21 +0900
From:   Mike Hommey <mh@glandium.org>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johan@herland.net
Subject: Re: [PATCH] fast-import: properly fanout notes when tree is imported
Message-ID: <20161220210621.5gubonuscn6t2de7@glandium.org>
References: <xmqqbmw6jp59.fsf@gitster.mtv.corp.google.com>
 <20161220210448.32213-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161220210448.32213-1-mh@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20161126 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I forgot the v2 in the subject.

Mike
