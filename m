X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] making docs blows up in b1bfcae438ad:git-merge-file.txt
Date: 17 Dec 2006 10:20:33 -0800
Message-ID: <86ac1mcrke.fsf@blue.stonehenge.com>
References: <86y7p7cssx.fsf@blue.stonehenge.com> <4584857D.703@gmail.com>
	<20061216234717.15ECE8F5A8@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 18:20:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.4; tzolkin = 5 Kan; haab = 17 Mac
In-Reply-To: <20061216234717.15ECE8F5A8@blue.stonehenge.com>
Original-Lines: 16
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34697>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw0cn-0002Rp-RB for gcvg-git@gmane.org; Sun, 17 Dec
 2006 19:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932303AbWLQSUe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 13:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWLQSUe
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 13:20:34 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:8955 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932303AbWLQSUe (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 13:20:34 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id 8AADB8F3AC for <git@vger.kernel.org>; Sun, 17 Dec
 2006 10:20:33 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 28123-01-54 for <git@vger.kernel.org>; Sun, 17 Dec 2006 10:20:33 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 1CE728F692;
 Sun, 17 Dec 2006 10:20:33 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

>>>>> "The" == The Answering Machine <merlyn.'s-answering.machine@stonehenge.com> writes:

The> I've received your mail.
The> Your message has been queued, and will probably be read within 48 hours.

Naughty SCM sent email addressed to me personally, but added a reply-to
of the list.

My answering machine behaved perfectly in this case, but SCM triggered it
badly. :(

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
