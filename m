Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2461A2098B
	for <e@80x24.org>; Sun, 16 Oct 2016 20:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756818AbcJPUmU (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 16:42:20 -0400
Received: from biz186.inmotionhosting.com ([23.235.208.68]:46485 "EHLO
        biz186.inmotionhosting.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756406AbcJPUmT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Oct 2016 16:42:19 -0400
Received: from [162.252.91.76] (port=43961 helo=[192.168.1.137])
        by biz186.inmotionhosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.87)
        (envelope-from <hwj@BridgeportContractor.com>)
        id 1bvsG4-000tSV-UB
        for git@vger.kernel.org; Sun, 16 Oct 2016 13:42:17 -0700
From:   Howard Johnson <hwj@BridgeportContractor.com>
Subject: link broken on git man page
To:     git@vger.kernel.org
Message-ID: <db083f89-b502-fe61-ce62-e7c4701f8764@BridgeportContractor.com>
Date:   Sun, 16 Oct 2016 13:42:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - biz186.inmotionhosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - BridgeportContractor.com
X-Get-Message-Sender-Via: biz186.inmotionhosting.com: authenticated_id: organizer@iclimatecredits.org
X-Authenticated-Sender: biz186.inmotionhosting.com: organizer@iclimatecredits.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This link below is broken in the man page.  (I'm on Debian Jessie).


GIT(1)                            Git Manual                            
GIT(1)

NAME
        git - the stupid content tracker

SYNOPSIS
        git [--version] [--help] [-C <path>] [-c <name>=<value>]
            [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
            [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
            [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
            <command> [<args>]

DESCRIPTION
        Git is a fast, scalable, distributed revision control system with an
        unusually rich command set that provides both high-level 
operations and
        full access to internals.

        See gittutorial(7) to get started, then see Everyday Git[1] for a
        useful minimum set of commands. The Git User’s Manual[2] has a more
        in-depth introduction.

        After you mastered the basic concepts, you can come back to this 
page
        to learn what commands Git offers. You can learn more about 
individual
        Git commands with "git help command". gitcli(7) manual page 
gives you
        an overview of the command-line command syntax.

        Formatted and hyperlinked version of the latest Git 
documentation can
        be viewed at http://git-htmldocs.googlecode.com/git/git.html.


                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


