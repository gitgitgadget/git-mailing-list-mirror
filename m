From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add a simple getpass() for MinGW
Date: Tue, 07 Apr 2009 19:32:39 -0700
Message-ID: <7vfxgjub7c.fsf@gitster.siamese.dyndns.org>
References: <cover.1239154140u.git.johannes.schindelin@gmx.de>
 <7ba615a300fe2742e8d32f0313c6ee9a1a1aaed3.1239154140u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	gitster@pobox.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNcL-0008Hv-Vh
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759304AbZDHCcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 22:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757539AbZDHCcs
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:32:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755192AbZDHCcr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 22:32:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 584BFA83F4;
	Tue,  7 Apr 2009 22:32:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B0A76A83F1; Tue,
  7 Apr 2009 22:32:40 -0400 (EDT)
In-Reply-To: <7ba615a300fe2742e8d32f0313c6ee9a1a1aaed3.1239154140u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Wed, 8 Apr 2009 03:30:22 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8B8BA12C-23E5-11DE-AD88-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116024>

Thanks; should I take this directly or via Hannes's pull request?
