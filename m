From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: Describe git-gui Tools menu configuration
 options.
Date: Sun, 14 Dec 2008 16:43:16 -0800
Message-ID: <7vhc561d5n.fsf@gitster.siamese.dyndns.org>
References: <200812142244.32438.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 01:44:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LC1Zh-0001W2-IC
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 01:44:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbYLOAnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Dec 2008 19:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbYLOAnY
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 19:43:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463AbYLOAnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 19:43:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 50BD71A4D8;
	Sun, 14 Dec 2008 19:43:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E99BB1A4D7; Sun,
 14 Dec 2008 19:43:17 -0500 (EST)
In-Reply-To: <200812142244.32438.angavrilov@gmail.com> (Alexander Gavrilov's
 message of "Sun, 14 Dec 2008 22:44:32 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5FFE7F32-CA41-11DD-AF7F-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103116>

Alexander Gavrilov <angavrilov@gmail.com> writes:

> Now git gui has a customizable Tools menu, so this adds
> information about variables that are used to configure it.

I'll apply this as-is to include in -rc3; git-gui users please proofread
and send in any updates/fixes if necessary.
