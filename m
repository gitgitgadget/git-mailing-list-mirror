From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix non-literal format in printf-style calls
Date: Tue, 11 Nov 2008 16:51:47 -0800
Message-ID: <7viqqtu5p8.fsf@gitster.siamese.dyndns.org>
References: <3t9bmcAj9kThyafdZ9mPENosknipZInn9Qq9u9oVuN7X7qwiI4GqZg@cipher.nrlssc.navy.mil> <1226351272-22253-1-git-send-email-dlowe@bitmuse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Lowe <dlowe@bitmuse.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 01:53:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L03z5-0002uV-TB
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 01:53:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbYKLAwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 19:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752183AbYKLAwD
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 19:52:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbYKLAwB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 19:52:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 291C9963A5;
	Tue, 11 Nov 2008 19:52:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BBBD9963A4; Tue,
 11 Nov 2008 19:51:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1D9D444A-B054-11DD-939A-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100707>

Thanks, will apply to 'maint' and 'master' after splitting.
