From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] On a script for submodules
Date: Thu, 03 Jan 2008 01:39:29 -0800
Message-ID: <7vsl1fs0xa.fsf@gitster.siamese.dyndns.org>
References: <7bfdc29a0801030107t54ca45dbq167666b337f59a01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 10:40:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAMYc-0004ve-Pu
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 10:40:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbYACJjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 04:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754164AbYACJjn
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 04:39:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53961 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbYACJjm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 04:39:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 52838A5CF;
	Thu,  3 Jan 2008 04:39:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B7B46A5CE;
	Thu,  3 Jan 2008 04:39:36 -0500 (EST)
In-Reply-To: <7bfdc29a0801030107t54ca45dbq167666b337f59a01@mail.gmail.com>
	(Imran M. Yousuf's message of "Thu, 3 Jan 2008 15:07:04 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69520>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

> ... I would really appreciate if someone would take their time to
> suggest me improvements. I would also like to get some feedbacks as
> what else could be added here. A brief description can be found in the
> following posting.

Around here, it is customary to have discussion on-list, not
pointing at external web pages and repositories.  I would
suggest starting by stating what the overall design is and how
it meshes with existing git-submodule command and its design.
