From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/8] reflog: rearrange the manpage
Date: Thu, 12 Feb 2015 16:17:34 +0100
Message-ID: <54DCC40E.4040506@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>	<1423473164-6011-6-git-send-email-mhagger@alum.mit.edu> <CAGZ79kY+AN6fmbBfCBdkUXiBSgJusFa7Jv2OS=n=EPXBpzp8EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 16:17:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLvWZ-0007bB-7t
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 16:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbbBLPRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 10:17:47 -0500
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:59086 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752766AbbBLPRo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 10:17:44 -0500
X-AuditID: 1207440e-f79bc6d000000c43-34-54dcc4109e1b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id F5.4F.03139.014CCD45; Thu, 12 Feb 2015 10:17:36 -0500 (EST)
Received: from [192.168.69.130] (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CFHYp8013709
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 10:17:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kY+AN6fmbBfCBdkUXiBSgJusFa7Jv2OS=n=EPXBpzp8EQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqCtw5E6IQecqTYuuK91MFg29V5gt
	3t5cwmjRPeUto0Vv3ydWi82b21kc2Dx2zrrL7rFgU6nHxUvKHp83yQWwRHHbJCWWlAVnpufp
	2yVwZ/xq2shUsJ+zYuOk9UwNjMvYuxg5OSQETCTm/njIBGGLSVy4t56ti5GLQ0jgMqPEv/Ut
	jBDOeSaJ1t1NzCBVvALaEt+3/ACzWQRUJW4s7WADsdkEdCUW9TSDTRIVCJI4dPoxC0S9oMTJ
	mU/AbBEBNYmZq2aDbWAWmMckcaX9J1izsICZxP4d81ggth1glNi76wXYfZwCgRIfd3xlBbGZ
	BdQl/sy7xAxhy0tsfzuHeQKjwCwkS2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzU
	Il1jvdzMEr3UlNJNjJAw59vB2L5e5hCjAAejEg/vCtM7IUKsiWXFlbmHGCU5mJREeYV3A4X4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8EYtA8rxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGan
	phakFsFkZTg4lCR4zx0CahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxWt8MTBi
	QVI8QHsvgrTzFhck5gJFIVpPMSpKifNOAkkIgCQySvPgxsKS1ytGcaAvhXklDgNV8QATH1z3
	K6DBTECDJ864DTK4JBEhJdXAOOVKx5KDCfwp9/eqz2d+u7ysLl8hqYqhu3T/CZc1+Vsf7e43
	XPb0+G+2T2/r76h1Bz7T+egctVtquUzSv5g0EwU288biGT9qElma0u7UKO/fcWrD 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263740>

On 02/11/2015 12:42 AM, Stefan Beller wrote:
> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> ---all::
>> -       Instead of listing <refs> explicitly, prune all refs.
>> +--stale-fix::
>> +       This revamps the logic -- the definition of "broken commit"
>> +       becomes: a commit that is not reachable from any of the refs and
>> +       there is a missing object among the commit, tree, or blob
>> +       objects reachable from it that is not reachable from any of the
>> +       refs.
> 
> --stale-fix becomes more and more irrelevant over time,
> so why not put in at the very end even after --all ?
> 
> Thinking out loud:
> (--expire=,--expire-unreachable= and --stale-fix) look like a group
> and (--updateref --rewrite --verbose and --all) also feel like a group,
> so you wanted to keep --stale-fix after --expire-unreachable= ?

Yes, that's what I was thinking.

But you are right that the docs could be improved even more, so in the
re-roll I will make some further changes.

> While talking about this man page, we should also add --dry-run?

Good point. I'll fix that, too.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
