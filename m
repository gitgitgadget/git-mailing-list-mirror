From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] git remote update: New option --prune
Date: Sun, 05 Apr 2009 02:47:39 -0700
Message-ID: <7veiw7v3d0.fsf@gitster.siamese.dyndns.org>
References: <20090402123823.GA1756@pvv.org>
 <9b18b3110904020634i17633645ue4ba91701ea243a1@mail.gmail.com>
 <20090402134414.GB26699@coredump.intra.peff.net>
 <7vab6zexq7.fsf@gitster.siamese.dyndns.org> <20090402201803.GA5397@pvv.org>
 <7vljqieq1r.fsf@gitster.siamese.dyndns.org> <20090403090036.GA23955@pvv.org>
 <20090403090344.GB5199@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, demerphq <demerphq@gmail.com>,
	git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 11:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqOyf-0007lL-Ig
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 11:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933AbZDEJru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 05:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756855AbZDEJrt
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 05:47:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756853AbZDEJrs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 05:47:48 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 424FAA8E46;
	Sun,  5 Apr 2009 05:47:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9AA4CA8E45; Sun,
  5 Apr 2009 05:47:41 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1A93C12-21C6-11DE-9A9C-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115648>

Thanks, queued (with a minor C90 fixup).
