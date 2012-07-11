From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/6] Default remote
Date: Wed, 11 Jul 2012 11:19:07 -0700
Message-ID: <7vy5mqduuc.fsf@alter.siamese.dyndns.org>
References: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Wed Jul 11 20:19:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp1Vc-0001r0-8s
	for gcvg-git-2@plane.gmane.org; Wed, 11 Jul 2012 20:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791Ab2GKST1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 14:19:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48387 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab2GKSTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 14:19:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4505E35;
	Wed, 11 Jul 2012 14:19:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JUpXsXtUMcdzkvyX/ktAKFCt0OY=; b=K29oCT
	N1WKmIWaeiO2t8BEa9NmvVuJ/Htd4FzpGAQajP7SFShTwHLk1NbinHhH1NUGN5DC
	37iQ+7+lTYurNaPJI1b6ZJtQZeNpqmLXx9gl2UPMt8s5poSDxGl2mpiVmFgAmT7x
	6+GvLPtf2I7D5HNO39py3JToCiq9SxY1o4WMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DNLRHbuFbtxdubO9HilV87thtve78zIr
	nh+X3gSa4lJhJl5Y4OhtygqfO1Q1vF0ybvhTtRB5HnWtV0zCuQQLH4XW76ea5A0Z
	SaVC4dpQ06wwVbsy6w0g/quuJarMmlVX5IrOmB8+Wi5QbwXdnYHN0w2FnaEnPlxw
	v5n4y6yqw0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 915165E34;
	Wed, 11 Jul 2012 14:19:09 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BCD05E33; Wed, 11 Jul 2012
 14:19:09 -0400 (EDT)
In-Reply-To: <1342020841-24368-1-git-send-email-marcnarc@xiplink.com>
 (marcnarc@xiplink.com's message of "Wed, 11 Jul 2012 11:33:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E856522C-CB84-11E1-9941-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201320>

marcnarc@xiplink.com writes:

> Incorporated feedback on the first version of this series[1], and also added
> documentation updates.
>
> Note that the documentation changes include 4 minor grammatical fixes (verb
> tenses, added a "the" in a couple fo places).  
> ...
> Patches 5 & 6 are unchanged.

Very nicely written summary that describes incremental changes.
