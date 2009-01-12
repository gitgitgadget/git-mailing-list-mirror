From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] Enable in-process submodule traversal
Date: Sun, 11 Jan 2009 18:07:42 -0800
Message-ID: <7v3afpmg41.fsf@gitster.siamese.dyndns.org>
References: <1231717555-10559-1-git-send-email-hjemli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 03:09:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMCEq-0005Ks-Iq
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 03:09:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbZALCHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 21:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbZALCHt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 21:07:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47654 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZALCHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 21:07:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B48351BF67;
	Sun, 11 Jan 2009 21:07:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AE5991BDF0; Sun,
 11 Jan 2009 21:07:44 -0500 (EST)
In-Reply-To: <1231717555-10559-1-git-send-email-hjemli@gmail.com> (Lars
 Hjemli's message of "Mon, 12 Jan 2009 00:45:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CEC77E24-E04D-11DD-B47E-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105278>

Sounds interesting except 1/3 didn't seem to reach the list...
