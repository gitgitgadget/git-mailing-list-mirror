From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUGFIX PATCH 2/2] fast-export: use an unsorted string list for
 extra_refs
Date: Sun, 23 Nov 2008 17:07:09 -0800
Message-ID: <7vwseund8i.fsf@gitster.siamese.dyndns.org>
References: <1227378168-14992-1-git-send-email-vmiklos@frugalware.org>
 <alpine.DEB.1.00.0811231254580.30769@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0811231255380.30769@pacific.mpi-cbg.de>
 <20081123180353.GM4746@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Nov 24 02:08:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4Pwe-000608-TT
	for gcvg-git-2@gmane.org; Mon, 24 Nov 2008 02:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbYKXBHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 20:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbYKXBHl
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 20:07:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbYKXBHk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Nov 2008 20:07:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 783A8815CC;
	Sun, 23 Nov 2008 20:07:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E27E3815AC; Sun,
 23 Nov 2008 20:07:11 -0500 (EST)
In-Reply-To: <20081123180353.GM4746@genesis.frugalware.org> (Miklos Vajna's
 message of "Sun, 23 Nov 2008 19:03:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4942702E-B9C4-11DD-9D37-8214C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101582>

Thanks both; I do not have time to actually double-check and apply for the
next 36 hours or so, though.
