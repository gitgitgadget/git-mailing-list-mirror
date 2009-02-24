From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2] bash completion: add --format= and --oneline options for "git log"
Date: Tue, 24 Feb 2009 18:14:30 +0200
Message-ID: <874oyjbymx.fsf@iki.fi>
References: <7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
	<20090224130626.6117@nanako3.lavabit.com>
	<20090224045041.GA4615@coredump.intra.peff.net>
	<7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
	<20090224054524.GE4615@coredump.intra.peff.net>
	<20090224185913.6117@nanako3.lavabit.com> <871vtonlmv.fsf_-_@iki.fi>
	<87zlgcq7rq.fsf_-_@iki.fi> <20090224153913.GT22848@spearce.org>
	<878wnvbzvd.fsf@iki.fi> <20090224155724.GV22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	felipe.contreras@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 24 17:17:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbzxC-0003zE-L9
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 17:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbZBXQOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 11:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755806AbZBXQOk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 11:14:40 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:43540 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754528AbZBXQOj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 11:14:39 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A88057A9C94; Tue, 24 Feb 2009 18:14:35 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LbzvS-0001QS-Tu; Tue, 24 Feb 2009 18:14:30 +0200
In-Reply-To: <20090224155724.GV22848@spearce.org> (Shawn O. Pearce's message of "Tue\, 24 Feb 2009 07\:57\:24 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111310>

On 2009-02-24 07:57 (-0800), Shawn O. Pearce wrote:

> Teemu Likonen <tlikonen@iki.fi> wrote:
>> This is meant to be a part of Nanako's patch series:
>> 
>>     http://thread.gmane.org/gmane.comp.version-control.git/111278
>
> Oh, sorry.  I don't use a threaded client so I missed the
> fact this was attached to her series.

I'm sorry too. That was a good lesson why I should provide enough
context (Gmane link for example) when adding CCs.
