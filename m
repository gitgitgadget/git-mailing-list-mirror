X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: git tag: don't complain of empty messages
Date: Sun, 26 Nov 2006 17:46:11 +0100
Message-ID: <4569C4D3.5060102@xs4all.nl>
References: <ejfc1t$6am$1@sea.gmane.org> <7v64dgo9gj.fsf@assigned-by-dhcp.cox.net> <4569C409.5080509@xs4all.nl>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 16:50:31 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 13
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82-171-213-190.dsl.ip.tiscali.nl
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <4569C409.5080509@xs4all.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32357>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoNCv-0007yq-7Q for gcvg-git@gmane.org; Sun, 26 Nov
 2006 17:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935436AbWKZQuL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 11:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935440AbWKZQuL
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 11:50:11 -0500
Received: from main.gmane.org ([80.91.229.2]:49098 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S935436AbWKZQuK (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 11:50:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GoNCd-0007ux-2E for git@vger.kernel.org; Sun, 26 Nov 2006 17:50:03 +0100
Received: from 82-171-213-190.dsl.ip.tiscali.nl ([82.171.213.190]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 17:50:03 +0100
Received: from hanwen by 82-171-213-190.dsl.ip.tiscali.nl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Sun, 26 Nov 2006
 17:50:03 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys escreveu:
> Junio C Hamano escreveu:
>> Please follow Documentation/SubmittingPatches.
> 
> See below, hope I didn't mess up.

please add

Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>


-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
