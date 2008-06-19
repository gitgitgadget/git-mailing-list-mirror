From: Junio C Hamano <gitster@pobox.com>
Subject: 'next' will be rewound shortly
Date: Thu, 19 Jun 2008 02:17:02 -0700
Message-ID: <7vzlphvl69.fsf_-_@gitster.siamese.dyndns.org>
References: <7vmylixr6h.fsf@gitster.siamese.dyndns.org>
 <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 11:18:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9GHt-0006I4-61
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 11:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbYFSJRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 05:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbYFSJRX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 05:17:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43457 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815AbYFSJRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 05:17:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8E8118C3E;
	Thu, 19 Jun 2008 05:17:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9F3D918C3D; Thu, 19 Jun 2008 05:17:11 -0400 (EDT)
In-Reply-To: <7vbq1xx4y8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 19 Jun 2008 00:24:31 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8539A576-3DE0-11DD-8AE4-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85462>

Following the new tradition we began a few releases ago, I'll rewind the
tip of 'next' shortly.  Two topics will be kicked back to 'pu' while we
are at it (jc/send-pack-tell-me-more and js/rebase-i-sequencer).

This is just an advance warning.
