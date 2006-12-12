X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: stgit: No patches to pop
Date: Tue, 12 Dec 2006 09:10:00 +0000
Message-ID: <tnxlkldwkd3.fsf@arm.com>
References: <7ac1e90c0612110632x56a2917cu4db33e47923f34c2@mail.gmail.com>
	<tnxpsaqwgxl.fsf@arm.com> <elk0c3$ovu$1@sea.gmane.org>
	<7ac1e90c0612110905x3f1632b9v17bb14e810715cbf@mail.gmail.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 09:10:15 +0000 (UTC)
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7ac1e90c0612110905x3f1632b9v17bb14e810715cbf@mail.gmail.com> (Bahadir
 Balban's message of "Mon, 11 Dec 2006 17:05:20 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 12 Dec 2006 09:10:24.0129 (UTC) FILETIME=[5B572F10:01C71DCD]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34071>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu3eM-0000K7-3w for gcvg-git@gmane.org; Tue, 12 Dec
 2006 10:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932157AbWLLJKH (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 04:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbWLLJKG
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 04:10:06 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:50264 "EHLO
 cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
 with ESMTP id S932157AbWLLJKF (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12
 Dec 2006 04:10:05 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18]) by
 cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id kBC9A2Yo006809;
 Tue, 12 Dec 2006 09:10:02 GMT
Received: from localhost.localdomain ([10.1.255.211]) by
 cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.0); Tue, 12 Dec 2006
 09:10:24 +0000
To: "Bahadir Balban" <bahadir.balban@gmail.com>
Sender: git-owner@vger.kernel.org

"Bahadir Balban" <bahadir.balban@gmail.com> wrote:
> On 12/11/06, Jakub Narebski <jnareb@gmail.com> wrote:
>> That is kind of strange. Pop should work like pop does, for example
>> the one in Perl or Python, removing n elements from the stack of applied
>> patches. Not work as "float <patch>"...
>> --
>> Jakub Narebski
>> Warsaw, Poland
>> ShadeHawk on #git
>
> As a new user my first expectation was as Catalin has revised. If it's
> going to stay as in 0.11 at least it would be nice to have it
> described in the wiki.

It was already modified in the StGIT repository and I am won't revert
it to the 0.11 functionality. Please feel free to modify the wiki
(which is really out of date - "stg help <command>" has more
up-to-date information).

-- 
