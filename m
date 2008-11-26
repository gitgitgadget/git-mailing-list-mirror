From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: fix keyword-expansion regex
Date: Wed, 26 Nov 2008 12:33:55 -0800
Message-ID: <7vljv6fcr0.fsf@gitster.siamese.dyndns.org>
References: <20081126185215.GA11037@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 21:36:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5R6v-0006sm-7t
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 21:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYKZUe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 15:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbYKZUe2
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 15:34:28 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55595 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbYKZUe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 15:34:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 765D8178B3;
	Wed, 26 Nov 2008 15:34:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C703D178B6; Wed,
 26 Nov 2008 15:33:57 -0500 (EST)
In-Reply-To: <20081126185215.GA11037@osc.edu> (Pete Wyckoff's message of
 "Wed, 26 Nov 2008 13:52:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9EAAE5AA-BBF9-11DD-8E64-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101764>

I will queue this to 'pu' and wait for an Ack from git-p4 folks.   Thanks.
