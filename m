Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF64BC433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9158A61175
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 16:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbhKRQit convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 18 Nov 2021 11:38:49 -0500
Received: from elephants.elehost.com ([216.66.27.132]:17946 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbhKRQis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 11:38:48 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AIGZkO0093146
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 11:35:46 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.34.0 NonStop Builds Available
Date:   Thu, 18 Nov 2021 11:35:41 -0500
Organization: Nexbridge Inc.
Message-ID: <022d01d7dc9a$569fda70$03df8f50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdfcmPf8lKq4UvQ/QA6sc1NgjmbIhA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The official builds for the HPE NonStop platforms for git 2.34.0 done by the ITUGLIB team are now available at the usual place at https://ituglib.connect-community.org/apps/Ituglib/SrchOpenSrcLib.xhtml for those of you who cannot do the builds yourselves. The builds were done on J06.22.00 and L21.06.00 for ia64-TNS/E and x86-TNS/X, respectively. Individual builds are available for each currently supported OpenSSL version (3.0.0, 1.1.1) and the unsupported 1.0.2 version. 

This release passes all tests except for the obvious t9001, because sendmail is not supported on platform.

Please refer to the release notes https://github.com/git/git/blob/v2.34.0/Documentation/RelNotes/2.34.0.txt for details of this release.

Regards,
Randall Becker
On behalf of the ITUGLIB Technical Committee.

