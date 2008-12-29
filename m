From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix the building of user-manual.texi and gitman.texi
 documents
Date: Mon, 29 Dec 2008 00:39:48 -0800
Message-ID: <7veizre5nv.fsf@gitster.siamese.dyndns.org>
References: <1230537789-5376-1-git-send-email-tlikonen@iki.fi>
 <1230537789-5376-2-git-send-email-tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Dec 29 09:41:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHDgc-0006V7-O1
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 09:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbYL2Ijz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 03:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYL2Ijy
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 03:39:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbYL2Ijy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 03:39:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D660D1B452;
	Mon, 29 Dec 2008 03:39:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D7C161B428; Mon,
 29 Dec 2008 03:39:49 -0500 (EST)
In-Reply-To: <1230537789-5376-2-git-send-email-tlikonen@iki.fi> (Teemu
 Likonen's message of "Mon, 29 Dec 2008 10:03:08 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43125F44-D584-11DD-9C0E-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104081>

I do not build nor use info myself these days, so I'll apply the patches
but when somebody else screams I'll let you and that somebody else work on
improvements.

Thanks.
