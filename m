From: Junio C Hamano <gitster@pobox.com>
Subject: The tip of next rewound....
Date: Mon, 03 Aug 2009 01:13:51 -0700
Message-ID: <7v7hxle2m8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 03 10:14:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXsgH-0004XV-5P
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 10:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252AbZHCIN5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 04:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752850AbZHCIN4
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 04:13:56 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63012 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbZHCIN4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 04:13:56 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1DD231E5BC;
	Mon,  3 Aug 2009 04:13:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A67861E5BB; Mon, 
 3 Aug 2009 04:13:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96379BFE-8005-11DE-B3B2-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124689>

As announced earlier, I rewound the tip of 'next' tonight.

The tip of 'pu' may fail the selftest in the new cvs-vcs area.
