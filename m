From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Fix bug in p4Where method.
Date: Thu, 04 Dec 2008 18:23:39 -0800
Message-ID: <7voczr1hsk.fsf@gitster.siamese.dyndns.org>
References: <1228397853-15921-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 03:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8QNP-0002aw-GE
	for gcvg-git-2@gmane.org; Fri, 05 Dec 2008 03:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755016AbYLECXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2008 21:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755026AbYLECXu
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Dec 2008 21:23:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbYLECXt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2008 21:23:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 901B4846E8;
	Thu,  4 Dec 2008 21:23:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id B26D5846E5; Thu,
  4 Dec 2008 21:23:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C063DEBA-C273-11DD-B02A-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102394>

Thanks.  Will apply to 'master' and will be in 1.6.1 final, unless some p4
users object (I do not use p4 myself, so that is the best I could do).
