From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Rename detection: Avoid repeated filespec population
Date: Wed, 21 Jan 2009 02:27:48 -0800
Message-ID: <7vprihdkd7.fsf@gitster.siamese.dyndns.org>
References: <20090120155957.GA23237@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 11:29:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPaKv-0001GC-8Q
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 11:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763059AbZAUK14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 05:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762255AbZAUK1z
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 05:27:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47821 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761056AbZAUK1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 05:27:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 29DFA923F8;
	Wed, 21 Jan 2009 05:27:54 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DCA87923F4; Wed,
 21 Jan 2009 05:27:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 29B96432-E7A6-11DD-9BF3-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106593>

Thanks.
