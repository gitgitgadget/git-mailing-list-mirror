From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Define linkgit macro in [macros] section
Date: Mon, 08 Dec 2008 17:26:24 -0800
Message-ID: <7vvdtu5ebj.fsf@gitster.siamese.dyndns.org>
References: <e2480c70812081029s36eac963t76092c09af990ad@mail.gmail.com>
 <loom.20081208T201048-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 02:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9rO7-0001Ib-MC
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 02:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbYLIB0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 20:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbYLIB0a
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 20:26:30 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbYLIB03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 20:26:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C367285B50;
	Mon,  8 Dec 2008 20:26:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 195A385B4F; Mon,
  8 Dec 2008 20:26:25 -0500 (EST)
In-Reply-To: <loom.20081208T201048-954@post.gmane.org> (Alexey Borzenkov's
 message of "Mon, 8 Dec 2008 20:13:06 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 672BECDC-C590-11DD-BE5C-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102593>

Thanks, and it does not change the output with older version (at least
7.1.2, I'll try with the one they have at k.org later tonight) in any
negative way.

Will apply.
