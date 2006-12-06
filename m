X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more
 obvious
Date: Wed, 06 Dec 2006 16:05:44 +0100
Message-ID: <4576DC48.1060201@xs4all.nl>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 15:05:54 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	gpermus@gmail.com, hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
Original-Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20061206145802.GC1714@fieldses.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33467>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GryLH-0007en-D3 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 16:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933278AbWLFPFs (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 10:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933336AbWLFPFs
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 10:05:48 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:4427 "EHLO
 smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S933278AbWLFPFs (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 10:05:48 -0500
Received: from [192.168.123.187] (muurbloem.xs4all.nl [213.84.26.127])
 (authenticated bits=0) by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id
 kB6F5XNf037567 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256
 verify=NO); Wed, 6 Dec 2006 16:05:38 +0100 (CET) (envelope-from
 hanwen@xs4all.nl)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

J. Bruce Fields escreveu:
> On Wed, Dec 06, 2006 at 03:52:26PM +0100, Han-Wen Nienhuys wrote:
>> Johannes Schindelin escreveu:
>>> It really is an important concept to grasp for people coming
>>> from CVS. Even if it is briefly mentioned, it is not obvious
>>> enough to sink in.
>> I think the goal is laudable, but IMO it would be better to shorten
>> the document rather adding more text.
> 
> OK, but...
> 
>>  Documentation/cvs-migration.txt |   34 +++++++++++++++++++++++-----------
>>  1 files changed, 23 insertions(+), 11 deletions(-)
> 
> ... that lengthens it even more than the proposed addition.

Yes, but with white space.

> I'd rather leave that introduction as it is--just as a section that
> advertises the git features without trying to explain much.  And I'd
> rather not mention push until we have a chance to explain how to use it.

As was mentioned in another thread, it make more sense to split this file up 
into separate documents for project contributors and project admins.

-- 
