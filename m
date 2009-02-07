From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: do not fail silently when the HEAD could not be
 detached
Date: Sat, 07 Feb 2009 13:45:56 -0800
Message-ID: <7v7i41udij.fsf@gitster.siamese.dyndns.org>
References: <cover.1234027102u.git.johannes.schindelin@gmx.de>
 <679be9321b4cf4f694917cb9eebba70376a43a0a.1234027102u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 07 22:48:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVv21-0008CH-ME
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 22:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbZBGVqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 16:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753584AbZBGVqD
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 16:46:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753571AbZBGVqB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 16:46:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B7C8F2AA5B;
	Sat,  7 Feb 2009 16:46:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2487B2A9D5; Sat, 
 7 Feb 2009 16:45:57 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B5D659F8-F560-11DD-AAB5-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108888>

Sounds sensible to be in 1.6.2.
