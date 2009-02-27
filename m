From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2] bash completion: add --format= and --oneline options for "git log"
Date: Fri, 27 Feb 2009 20:53:58 +0200
Message-ID: <87y6vrvhh5.fsf@iki.fi>
References: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
	<7vbpsuxqpo.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902221055g4e815a78oc0aa094304588ab7@mail.gmail.com>
	<7vljrxveqa.fsf@gitster.siamese.dyndns.org>
	<94a0d4530902231656l71ee0e45nbdd1c20035d3dd4@mail.gmail.com>
	<94a0d4530902231703n701a17dbkd20c0e14d759dddf@mail.gmail.com>
	<7v3ae4r53f.fsf@gitster.siamese.dyndns.org>
	<20090224130626.6117@nanako3.lavabit.com>
	<20090224045041.GA4615@coredump.intra.peff.net>
	<7vprh8mm9k.fsf@gitster.siamese.dyndns.org>
	<20090224054524.GE4615@coredump.intra.peff.net>
	<20090224185913.6117@nanako3.lavabit.com> <871vtonlmv.fsf_-_@iki.fi>
	<87zlgcq7rq.fsf_-_@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 19:55:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld7s6-0002UP-2l
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 19:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756089AbZB0SyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 13:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbZB0SyN
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 13:54:13 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:40610 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766AbZB0SyM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 13:54:12 -0500
Received: from mithlond.arda.local (80.220.180.181) by jenni2.inet.fi (8.5.014)
        id 48FC5A8805A0E902; Fri, 27 Feb 2009 20:54:06 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1Ld7qQ-0002Mt-Ui; Fri, 27 Feb 2009 20:53:58 +0200
In-Reply-To: <87zlgcq7rq.fsf_-_@iki.fi> (Teemu Likonen's message of "Tue\, 24 Feb 2009 15\:33\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111694>

On 2009-02-24 15:33 (+0200), Teemu Likonen wrote:

> We also add --format= completion for "git show".
>
> Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
> ---

>  contrib/completion/git-completion.bash |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)

ns/pretty-format topic got merged to "next" (e7a7e8a) but my bash
completion patch didn't go there. Is there a specific reason for that?
The patch was acked by Shawn.

The thread is here:

http://thread.gmane.org/gmane.comp.version-control.git/110962/focus=111286
