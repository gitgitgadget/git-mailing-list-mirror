From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] filter-branch -d: Export GIT_DIR earlier
Date: Wed, 18 Feb 2009 16:53:38 -0800
Message-ID: <7v1vtvs0vh.fsf@gitster.siamese.dyndns.org>
References: <20090217083146.GA7338@lars.home.noschinski.de>
 <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302>
 <20090217175959.GA3564@lars.home.noschinski.de>
 <20090217180540.GB3564@lars.home.noschinski.de>
 <alpine.DEB.1.00.0902180002090.10279@pacific.mpi-cbg.de>
 <20090218083535.GA5466@lars.home.noschinski.de>
 <alpine.DEB.1.00.0902181125410.6274@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Noschinski <lars@public.noschinski.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 19 01:55:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZxC5-0004Vu-IA
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 01:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753205AbZBSAxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 19:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbZBSAxq
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 19:53:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbZBSAxq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 19:53:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 774022B6DA;
	Wed, 18 Feb 2009 19:53:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C11A72B6B7; Wed,
 18 Feb 2009 19:53:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C17EB468-FE1F-11DD-A657-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110600>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Last iteration :)
>
> Yep, I like it.

Thanks.
