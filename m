X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-1.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Jerome Lovy <t2a2e9z8ncbs9qg@brefemail.com>
Subject: Rationale for the "Never commit to the right side of a Pull line"
 rule
Date: Thu, 26 Oct 2006 18:47:43 +0200
Message-ID: <ehqp1u$j4$1@sea.gmane.org>
Reply-To: t2a2e9z8ncbs9qg@brefemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 26 Oct 2006 16:52:15 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 20
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212.11.48.246
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30237>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8SO-0005y5-9l for gcvg-git@gmane.org; Thu, 26 Oct
 2006 18:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423490AbWJZQvt convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006 12:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423492AbWJZQvt
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 12:51:49 -0400
Received: from main.gmane.org ([80.91.229.2]:31717 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1423490AbWJZQvs (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 12:51:48 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gd8S7-0005ty-Mp for git@vger.kernel.org; Thu, 26 Oct 2006 18:51:36 +0200
Received: from 212.11.48.246 ([212.11.48.246]) by main.gmane.org with esmtp
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26
 Oct 2006 18:51:35 +0200
Received: from t2a2e9z8ncbs9qg by 212.11.48.246 with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 26 Oct 2006
 18:51:35 +0200
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

Could someone please point me to / give me the rationale for the "Never=
=20
commit to the right side of a Pull line" rule ?

I found the rule in the second Note of the git-fetch man-page (eg=20
http://www.kernel.org/pub/software/scm/git/docs/git-fetch.html).

It's been taken over in _bold letters_ by X.Org/freedesktop.org in thei=
r=20
"UsingGit" document (http://freedesktop.org/wiki/UsingGit).

In both places though, I don't see any explanation, but rather a=20
commandment ;-) . Am I missing the ovious ?

My candid thoughts: to me the practice recommended here seems=20
subjectively "cleaner" indeed, but is it objectively better or even=20
essential? Why?

TIA
J=E9r=F4me
