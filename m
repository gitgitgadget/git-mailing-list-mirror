From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH][v2] http authentication via prompts (with correct line
 lengths)
Date: Fri, 13 Mar 2009 23:43:19 -0700
Message-ID: <7v3adgeha0.fsf@gitster.siamese.dyndns.org>
References: <49B5AF67.6050508@gmail.com>
 <7v1vt6dxg9.fsf@gitster.siamese.dyndns.org> <49B5F0BA.3070806@gmail.com>
 <7v63ihdgy6.fsf@gitster.siamese.dyndns.org>
 <e2b179460903120153u5fdb58b6tf3027eea23673df0@mail.gmail.com>
 <7vsklihsti.fsf@gitster.siamese.dyndns.org> <49BA55E2.1060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Ralphson <mike.ralphson@gmail.com>, git@vger.kernel.org
To: Mike Gaffney <mr.gaffo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 07:44:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiNc7-0008WO-Gg
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 07:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbZCNGn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2009 02:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752529AbZCNGn1
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 02:43:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZCNGn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2009 02:43:26 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D75E35493;
	Sat, 14 Mar 2009 02:43:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3A605548F; Sat,
 14 Mar 2009 02:43:21 -0400 (EDT)
In-Reply-To: <49BA55E2.1060604@gmail.com> (Mike Gaffney's message of "Fri, 13
 Mar 2009 07:47:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6AE27792-1063-11DE-8B1C-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113238>

Mike Gaffney <mr.gaffo@gmail.com> writes:

> I was going to try and clean this up this weekend or early next week. I'm also
> trying to encourage open source submissions at work and was using this
> as an example patch to get people going (we need the fix to use git). So
> I do plan finishing this, just have to do it when I have time.

Thanks.
