From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] Name change: other -> commands.
Date: Thu, 27 Nov 2008 17:27:01 -0800
Message-ID: <7vej0wabdm.fsf@gitster.siamese.dyndns.org>
References: <492F0CB8.2080808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 02:29:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5sA8-0000W6-9i
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 02:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbYK1B1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 20:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbYK1B1O
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 20:27:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbYK1B1O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 20:27:14 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1033917A13;
	Thu, 27 Nov 2008 20:27:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6DA9217A10; Thu,
 27 Nov 2008 20:27:02 -0500 (EST)
In-Reply-To: <492F0CB8.2080808@gmail.com> (William Pursell's message of "Thu,
 27 Nov 2008 21:10:16 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AF0319F2-BCEB-11DD-94A7-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101854>

I see this needless churn.  Some commands are always available, so these
are indeed other commands.
