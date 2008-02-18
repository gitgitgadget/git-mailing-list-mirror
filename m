From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] deref_tag: handle return value NULL
Date: Mon, 18 Feb 2008 00:40:33 -0800
Message-ID: <7vlk5ir726.fsf@gitster.siamese.dyndns.org>
References: <12033199162949-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Feb 18 09:41:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR1Z4-0007CQ-37
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 09:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756733AbYBRIky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 03:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755803AbYBRIkx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 03:40:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755511AbYBRIkw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 03:40:52 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 766D079A6;
	Mon, 18 Feb 2008 03:40:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 E42B979A5; Mon, 18 Feb 2008 03:40:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74247>

Martin Koegler <mkoegler@auto.tuwien.ac.at> writes:

> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>

Looks good, thanks.
