From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Introduce %<branch> as shortcut to the tracked branch
Date: Wed, 18 Mar 2009 15:34:26 -0700
Message-ID: <7vr60ubgul.fsf@gitster.siamese.dyndns.org>
References: <200903181448.50706.agruen@suse.de>
 <20090318182603.GM8940@machine.or.cz>
 <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Andreas Gruenbacher <agruen@suse.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:36:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4Mp-0004R0-L2
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754481AbZCRWeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753646AbZCRWeh
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:34:37 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43871 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbZCRWeg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:34:36 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B0EDC7080;
	Wed, 18 Mar 2009 18:34:34 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id ED3E97078; Wed,
 18 Mar 2009 18:34:29 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 18 Mar 2009 22:46:22 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F4D055EE-140C-11DE-8983-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113694>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Suggested by Pasky.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

In the longer term who suggested matters much less than why such a feature
is desirable, how it is used, and without it what is impossible and/or
cumbersome.  What's the motivation behind this?

You do not have to explain it to me, but you should explain it to the
history that records this commit, and to the users who read doccos.
