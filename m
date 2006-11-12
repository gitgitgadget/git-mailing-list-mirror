X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/2] mail and import tests
Date: Sun, 12 Nov 2006 22:14:34 +0100
Message-ID: <20061112211434.19362.66077.stgit@localhost>
References: <b0943d9e0611080212q35dae8d0w2642ed1d0189f8fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 12 Nov 2006 21:16:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <b0943d9e0611080212q35dae8d0w2642ed1d0189f8fe@mail.gmail.com>
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31276>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjMgK-0007g7-SL for gcvg-git@gmane.org; Sun, 12 Nov
 2006 22:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753140AbWKLVPu convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006 16:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbWKLVPu
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 16:15:50 -0500
Received: from mxfep03.bredband.com ([195.54.107.76]:5833 "EHLO
 mxfep03.bredband.com") by vger.kernel.org with ESMTP id S1753140AbWKLVPt
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 16:15:49 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82]) by
 mxfep03.bredband.com with ESMTP id
 <20061112211547.KXSH25623.mxfep03.bredband.com@ironport.bredband.com> for
 <git@vger.kernel.org>; Sun, 12 Nov 2006 22:15:47 +0100
Received: from ua-83-227-180-148.cust.bredbandsbolaget.se (HELO
 yoghurt.hemma.treskal.com) ([83.227.180.148]) by ironport.bredband.com with
 ESMTP; 12 Nov 2006 22:15:47 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by
 yoghurt.hemma.treskal.com (Postfix) with ESMTP id A18AF4CC24; Sun, 12 Nov
 2006 22:15:46 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Tests for "stg import" and "stg mail". The later test is not very
ambitious, but it can always be extended later.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
