From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bundle: allow rev-list options to exclude annotated tags
Date: Tue, 06 Jan 2009 00:17:51 -0800
Message-ID: <7v4p0cn900.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901021725530.27818@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:19:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK79o-0007U8-1g
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 09:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbZAFIR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 03:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbZAFIR6
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 03:17:58 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbZAFIR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 03:17:57 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF63D8DE1C;
	Tue,  6 Jan 2009 03:17:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F34578DE1B; Tue,
  6 Jan 2009 03:17:53 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85E15A18-DBCA-11DD-A254-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104647>

Thanks; queued for maint (and possibly maint-1.6.0).
