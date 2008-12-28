From: Junio C Hamano <gitster@pobox.com>
Subject: [Notice] The tip of 'next' will be rewound shortly
Date: Sat, 27 Dec 2008 16:30:01 -0800
Message-ID: <7v8wq1b0qe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 01:32:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGjZe-0002Gp-Lm
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 01:32:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571AbYL1AaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 19:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754566AbYL1AaG
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 19:30:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753558AbYL1AaF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 19:30:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6BC0F88925;
	Sat, 27 Dec 2008 19:30:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DB19D88923; Sat,
 27 Dec 2008 19:30:02 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ABC8E4F4-D476-11DD-9226-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104037>

As has become customery recently, the 'next' branch will be rewound to
base on the last released 'master', since the v1.6.1 release was cut.

Also, earlier parts of nd/narrow topic has been dropped from 'next' and
the topic has been kicked back to 'pu'.  I haven't started looking at
moving any topics out of 'pu' to 'next' yet, so there is nothing new on
'next', other than the things that came from 'master' and 'maint'.
