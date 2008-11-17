From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote short help message updated
Date: Mon, 17 Nov 2008 02:15:27 -0800
Message-ID: <7vmyfyzmio.fsf@gitster.siamese.dyndns.org>
References: <1226913150-26088-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: crquan@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 17 11:17:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L21AF-0000TR-Bj
	for gcvg-git-2@gmane.org; Mon, 17 Nov 2008 11:17:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbYKQKPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2008 05:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752336AbYKQKPs
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Nov 2008 05:15:48 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbYKQKPr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2008 05:15:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 132D67EAC1;
	Mon, 17 Nov 2008 05:15:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9AE7B7EABE; Mon,
 17 Nov 2008 05:15:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B2E58252-B490-11DD-AAA1-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101206>

crquan@gmail.com writes:

> From: Cheng Renquan <crquan@gmail.com>
>
> Synced from git help remote.
>
> Signed-off-by: Cheng Renquan <crquan@gmail.com>

We strongly prefer writing commit log message in imperative mood, like:

	[PATCH] git-remote: match usage string with the manual pages

The patch itself looks good.  Thanks.
