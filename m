X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 0/3] Misc stgit patches
Date: Thu, 30 Nov 2006 01:23:04 +0100
Message-ID: <20061130002304.21981.67797.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Thu, 30 Nov 2006 00:28:52 +0000 (UTC)
Cc: GIT list <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpZmH-0002OP-Le for gcvg-git@gmane.org; Thu, 30 Nov
 2006 01:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967726AbWK3A1n (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 19:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967723AbWK3A1n
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 19:27:43 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:9930 "EHLO
 smtp2-g19.free.fr") by vger.kernel.org with ESMTP id S967726AbWK3A1n (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 19:27:43 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp2-g19.free.fr (Postfix) with ESMTP id 0120577C1; Thu,
 30 Nov 2006 01:27:42 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch) by
 bylbo.nowhere.earth with esmtp (Exim 4.62) (envelope-from
 <ydirson@altern.org>) id 1GpZms-0006Au-FW; Thu, 30 Nov 2006 01:28:26 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

One of the following patches contains a pretty substantial change to stack.py to help
adding new stored properties to a Series just like it is done for a Patch.  It was
expected to be the first in a series for storing branch parent information, but as you
may have read already, it's not for today :)

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
