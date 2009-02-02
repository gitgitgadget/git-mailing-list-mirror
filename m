From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-add -i/-p: Change prompt separater from slash to
 comma
Date: Sun, 01 Feb 2009 23:49:10 -0800
Message-ID: <7vy6wpl1mx.fsf@gitster.siamese.dyndns.org>
References: <1233546159-30347-1-git-send-email-gitster@pobox.com>
 <1233546159-30347-2-git-send-email-gitster@pobox.com>
 <4986A334.6070903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 02 08:50:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtZs-0005SL-K5
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 08:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZBBHtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 02:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbZBBHtT
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 02:49:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbZBBHtT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:49:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C06552A467;
	Mon,  2 Feb 2009 02:49:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 17C1D2A466; Mon, 
 2 Feb 2009 02:49:12 -0500 (EST)
In-Reply-To: <4986A334.6070903@gmail.com> (William Pursell's message of "Mon,
 02 Feb 2009 07:39:32 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE7990F6-F0FD-11DD-93CC-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108062>

William Pursell <bill.pursell@gmail.com> writes:

> Not a major complaint, but how about localizing the occurence
> of the separator.  Something like this:

I think that is sensible.  I've already queued the resurrected series to
'next' and am deep in the process of tonight's pushout preparation (this
time I've even written What's cooking), so I'd rather not rewind what I
have already and redo it.  Could you send an incremental update on top of
what's in next (more specifically ace30ba (In add --patch, Handle K,k,J,j
slightly more gracefully., 2008-11-27) please?
