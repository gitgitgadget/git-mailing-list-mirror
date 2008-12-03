From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4030-diff-textconv: Make octal escape sequence more
 portable
Date: Tue, 02 Dec 2008 18:18:37 -0800
Message-ID: <7vhc5mhugy.fsf@gitster.siamese.dyndns.org>
References: <4934F245.9020908@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 03:20:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7hLR-0000Ml-Tj
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 03:20:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754817AbYLCCSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 21:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYLCCSo
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 21:18:44 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33175 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbYLCCSn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 21:18:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 19AB083B39;
	Tue,  2 Dec 2008 21:18:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 406D683B36; Tue,
  2 Dec 2008 21:18:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B4E276C6-C0E0-11DD-A324-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102205>

Thanks.
