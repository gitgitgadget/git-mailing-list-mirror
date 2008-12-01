From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.1-rc1
Date: Mon, 01 Dec 2008 01:54:38 -0800
Message-ID: <7vbpvwrzj5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 01 10:56:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L75Vz-0002AM-Od
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 10:56:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbYLAJzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYLAJzL
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 04:55:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32973 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbYLAJzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 04:55:10 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 36BDF83E63;
	Mon,  1 Dec 2008 04:55:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 95DDA83E61; Mon,
  1 Dec 2008 04:54:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 23751674-BF8E-11DD-AA1C-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102012>

As promised, 1.6.1-rc1 is found at the usual places, and from here on we
will be in bugfixes-only mode until 1.6.1 final.  I also think there
probably are a few more patches on 'next' (e.g. the first patch on the
gp/gitweb-feature topic, which is a pure bugfix) that haven't merged to
'master' but should.
