From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/Test] Build in merge is broken
Date: Sun, 13 Jul 2008 19:53:13 -0700
Message-ID: <7v8ww5mb1i.fsf@gitster.siamese.dyndns.org>
References: <loom.20080713T073129-112@post.gmane.org>
 <20080713124100.GB10347@genesis.frugalware.org>
 <20080713174659.GE10347@genesis.frugalware.org>
 <20080713184300.GF10347@genesis.frugalware.org>
 <402c10cd0807131915u6567cba9h361d26d3dc003739@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@frugalware.org>, git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 04:54:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIECj-00011M-Gr
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 04:54:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbYGNCxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 22:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbYGNCxW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 22:53:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754442AbYGNCxV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 22:53:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67FF92AEE3;
	Sun, 13 Jul 2008 22:53:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DE93C2AEE1; Sun, 13 Jul 2008 22:53:15 -0400 (EDT)
In-Reply-To: <402c10cd0807131915u6567cba9h361d26d3dc003739@mail.gmail.com>
 (Sverre Hvammen Johansen's message of "Sun, 13 Jul 2008 19:15:00 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04678976-5150-11DD-925B-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88369>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> Test cases for build in merge.
> ---

Thanks.

Obviously this is not for application but to help Miklos and others to
help fixing the remaining issues.

Tonight's pu won't have this but that is only because I am currently deep
in today's integration session already.
