X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] Trim hint printed when gecos is empty.
Date: Tue, 28 Nov 2006 11:52:24 +0100
Message-ID: <ekh4cu$q6e$2@sea.gmane.org>
References: <ekh2uh$nk2$1@sea.gmane.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 28 Nov 2006 10:52:50 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 15
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <ekh2uh$nk2$1@sea.gmane.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32509>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp0Zr-0001Qb-Oy for gcvg-git@gmane.org; Tue, 28 Nov
 2006 11:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935845AbWK1Kwh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 05:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935846AbWK1Kwh
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 05:52:37 -0500
Received: from main.gmane.org ([80.91.229.2]:48863 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935845AbWK1Kwg (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 05:52:36 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gp0Zl-0001Pi-Hj for git@vger.kernel.org; Tue, 28 Nov 2006 11:52:33 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 11:52:33 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 11:52:33 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys escreveu:
> Trim hint printed when gecos is empty.
> Remove asterisks for readability
> Suggest use of git-config for easy cut & pasting.
> ---

and 

Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>

is there a reason why git-format-patch doesn't add a sign-off by default?


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
