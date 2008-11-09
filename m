From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git send-email: interpret unknown files as revision 
 lists
Date: Sun, 09 Nov 2008 10:56:19 -0800
Message-ID: <7vmyg8afu4.fsf@gitster.siamese.dyndns.org>
References: <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
 <1225815858-30617-4-git-send-email-madcoder@debian.org>
 <1225815858-30617-5-git-send-email-madcoder@debian.org>
 <7vvdv3nj28.fsf@gitster.siamese.dyndns.org>
 <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
 <7v1vxroxn1.fsf@gitster.siamese.dyndns.org>
 <20081105104001.GA22272@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 19:58:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzFTo-0006qr-Pr
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 19:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbYKIS4e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 13:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755643AbYKIS4e
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 13:56:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755607AbYKIS4d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 13:56:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 191C795730;
	Sun,  9 Nov 2008 13:56:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3E9A79572D; Sun, 
 9 Nov 2008 13:56:21 -0500 (EST)
In-Reply-To: <20081105104001.GA22272@artemis.corp> (Pierre Habouzit's message
 of "Wed, 05 Nov 2008 11:40:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1F142228-AE90-11DD-933C-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100463>

Pierre Habouzit <madcoder@debian.org> writes:

> Okay, still having --[no-]format-patch is probably a good idea indeed
> for scripts. Will do.
> ...
> Probably, I kept what was done as is, but we probably want do_edit() to
> die() if the user killed it.
> ...
>> So I am not opposed to a sendemail.foo configuration option.
>
> Will do

Thanks.
