Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676CAC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 22:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245123AbhKZWoa convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 26 Nov 2021 17:44:30 -0500
Received: from elephants.elehost.com ([216.66.27.132]:13648 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbhKZWm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 17:42:29 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1AQMdDU3062094
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 26 Nov 2021 17:39:13 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [ANNOUNCE] Git v2.34.1 NonStop Builds Available
Date:   Fri, 26 Nov 2021 17:39:08 -0500
Organization: Nexbridge Inc.
Message-ID: <00d101d7e316$70542f70$50fc8e50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfjFlv5cbl1TxgSRm2ykdsRIyf6RQ==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The official builds for the HPE NonStop platforms for git 2.34.1 done by the ITUGLIB team are now available at the usual place at https://ituglib.connect-community.org/apps/Ituglib/SrchOpenSrcLib.xhtml for those of you who cannot do the builds yourselves. The builds were done on J06.22.00 and L21.06.00 for ia64-TNS/E and x86-TNS/X, respectively. Individual builds are available for each currently supported OpenSSL version (3.0.0, 1.1.1) and the unsupported 1.0.2 version. 

This release passes all tests except for the obvious t9001, because sendmail is not supported on platform.

Regards,
Randall Becker
On behalf of the ITUGLIB Technical Committee.

