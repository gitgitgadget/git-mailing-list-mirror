From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: minor improvements for Mac OS X (Darwin)
Date: Wed, 04 Feb 2009 22:50:15 -0800
Message-ID: <7viqnpidi0.fsf@gitster.siamese.dyndns.org>
References: <1233814148-67700-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, benny.kra@googlemail.com,
	nanako3@lavabit.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 07:52:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUy5f-00015o-5X
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 07:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbZBEGu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 01:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752349AbZBEGu0
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 01:50:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbZBEGu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 01:50:26 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D8489677B;
	Thu,  5 Feb 2009 01:50:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C5E199677A; Thu,
  5 Feb 2009 01:50:17 -0500 (EST)
In-Reply-To: <1233814148-67700-1-git-send-email-jaysoffian@gmail.com> (Jay
 Soffian's message of "Thu, 5 Feb 2009 01:09:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 43BFE0B6-F351-11DD-9572-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108507>

Thanks; will apply directly to master to see if anybody screams, as I do
not have access to any OSX machine.
