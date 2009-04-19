From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Work around ash "alternate value" expansion bug
Date: Sat, 18 Apr 2009 21:38:17 -0700
Message-ID: <7vws9hs1fq.fsf@gitster.siamese.dyndns.org>
References: <1240044459-57227-1-git-send-email-ben@ben.com>
 <1240112527-79979-1-git-send-email-ben@ben.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Jackson <ben@ben.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 06:40:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvOp1-00042r-51
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 06:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZDSEi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 00:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbZDSEi2
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 00:38:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZDSEi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 00:38:27 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 942B9104A4;
	Sun, 19 Apr 2009 00:38:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BD330104A2; Sun,
 19 Apr 2009 00:38:20 -0400 (EDT)
In-Reply-To: <1240112527-79979-1-git-send-email-ben@ben.com> (Ben Jackson's
 message of "Sat, 18 Apr 2009 20:42:07 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EB3E3CBA-2C9B-11DE-90BE-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, looks good.
