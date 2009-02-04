From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bundle doc: update examples
Date: Wed, 04 Feb 2009 14:44:42 -0800
Message-ID: <7v8woln7ol.fsf@gitster.siamese.dyndns.org>
References: <7vab95r7j4.fsf@gitster.siamese.dyndns.org>
 <87y6wnnjvl.fsf@jidanni.org> <7vbptj9cp8.fsf@gitster.siamese.dyndns.org>
 <20090204181529.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jidanni@jidanni.org, mdl123@verizon.net, spearce@spearce.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 23:46:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUqVi-00018y-La
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 23:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785AbZBDWo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 17:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755892AbZBDWo4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 17:44:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34739 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753982AbZBDWoz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 17:44:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3A1F896C7C;
	Wed,  4 Feb 2009 17:44:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CDB3F96C71; Wed,
  4 Feb 2009 17:44:44 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 70B6DDE8-F30D-11DD-ACB5-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108450>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> This rewrites the example part of the bundle doucmentation to follow
> the suggestion made by Junio during a recent discussion (gmane 108030).
> 
> Instead of just showing different ways to create and use bundles in a
> disconnected fashion, the rewritten example first shows the simplest
> "full cycle" of sneakernet workflow, and then introduces various
> variations.
> 
> The words are mostly taken from Junio's outline. I only reformatted
> them and proofread to make sure the end result flows naturally.
> 
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
> I didn't want your improvement suggestion to go to waste either, so
> here is a proposed conclusion of this topic in a patch form, hopefully
> in a good enough quality.

I appreciate your help like this patch, and your other contributions of
"project secretary" kind, pointing out old threads, prodding about
unapplied patches, etc., because I do not have infinite amount of time.

The text seems to follow my "this might flow more naturally and easier to
read" outline exactly, and I do not have a problem with the patch itself.
Among the people who were involved in the review, Jidanni seemed to be of
the same opinion, but I haven't heard from Dscho one way or another.  So
I'd keep this on hold for now but I think the examples are organized much
better with this version and we should take it.

HOWEVER.

> After the maintainer spent a lot of time to suggest how to improve a
> proposed patch for inclusion, it is rude for a contributor to walk
> away without following through the review process. Such a proposed
> patch is not contributing to the development process but only stealing
> maintainer's and reviewers' time from the community. But others like I
> can at least try to help (^_^;).

I see a smiley, but what's with the animosity?  One thing I've always
liked about your messages to this list is that they have an exceptional
signal to noise ratio, certainly much better than mine [*1*].

I saw you were annoyed by his recent "bug tracker" remark in another
thread, and I do appreciate that you are showing a better way to help by
setting an example, but I think this comment is counterproductive.

[Footnote]

*1* You certainly never said anything like giving furniture to somebody
else ;-)
