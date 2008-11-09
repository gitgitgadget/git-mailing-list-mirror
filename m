From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Sun, 09 Nov 2008 14:12:31 -0800
Message-ID: <7v1vxka6r4.fsf@gitster.siamese.dyndns.org>
References: <20081107220730.GA15942@coredump.intra.peff.net>
 <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org>
 <20081108142756.GC17100@coredump.intra.peff.net>
 <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org>
 <20081109014926.GA31276@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 09 23:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzIY5-0005sZ-8w
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 23:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350AbYKIWNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756358AbYKIWNF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 17:13:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbYKIWNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 17:13:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6555A7B8C3;
	Sun,  9 Nov 2008 17:13:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9CBCE7B8BA; Sun,
  9 Nov 2008 17:12:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 94707CFE-AEAB-11DD-98E7-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100477>

Thanks; will be in 'next'.
