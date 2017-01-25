Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FCA31F70F
	for <e@80x24.org>; Wed, 25 Jan 2017 09:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdAYJ4x (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 04:56:53 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:48608 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbdAYJ4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 04:56:52 -0500
Received: from localhost (x4e340422.dyn.telefonica.de [78.52.4.34])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id 1FF4D16C850;
        Wed, 25 Jan 2017 10:56:50 +0100 (CET)
From:   Patrick Steinhardt <patrick.steinhardt@elego.de>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <patrick.steinhardt@elego.de>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 1/4] mailmap: add Patrick Steinhardt's work address
Date:   Wed, 25 Jan 2017 10:56:45 +0100
Message-Id: <20170125095648.4116-2-patrick.steinhardt@elego.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170125095648.4116-1-patrick.steinhardt@elego.de>
References: <20170125095648.4116-1-patrick.steinhardt@elego.de>
In-Reply-To: <20170123130635.29577-1-patrick.steinhardt@elego.de>
References: <20170123130635.29577-1-patrick.steinhardt@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Patrick Steinhardt <patrick.steinhardt@elego.de>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 9c87a3840..ea59205b9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -177,6 +177,7 @@ Paolo Bonzini <bonzini@gnu.org> <paolo.bonzini@lu.unisi.ch>
 Pascal Obry <pascal@obry.net> <pascal.obry@gmail.com>
 Pascal Obry <pascal@obry.net> <pascal.obry@wanadoo.fr>
 Pat Notz <patnotz@gmail.com> <pknotz@sandia.gov>
+Patrick Steinhardt <ps@pks.im> <patrick.steinhardt@elego.de>
 Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
 Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
 Peter Baumann <waste.manager@gmx.de> <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
-- 
2.11.0

