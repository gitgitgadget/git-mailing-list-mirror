From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Avoid printing a spurious message.
Date: Tue, 11 Nov 2008 16:51:29 -0800
Message-ID: <7vod0lu5pq.fsf@gitster.siamese.dyndns.org>
References: <87myg67ywz.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:53:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03z5-0002uV-5V
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYKLAvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYKLAvu
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:51:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57806 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYKLAvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:51:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 67C4D963A1;
	Tue, 11 Nov 2008 19:51:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B86B99639C; Tue,
 11 Nov 2008 19:51:32 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 156BDF52-B054-11DD-B09F-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100706>

Good eyes, thanks.  Will apply to 'maint'.
