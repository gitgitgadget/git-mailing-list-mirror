From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Fix two issues found by valgrind
Date: Tue, 27 Jan 2009 15:17:20 -0800
Message-ID: <7v63k01gqn.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901280005180.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 00:18:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRxCm-0000sc-ND
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 00:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbZA0XR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 18:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbZA0XR1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 18:17:27 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60373 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbZA0XR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 18:17:27 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EA74394C59;
	Tue, 27 Jan 2009 18:17:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 062F694C57; Tue,
 27 Jan 2009 18:17:21 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901280005180.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed, 28 Jan 2009 00:07:21 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A82331E6-ECC8-11DD-8371-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107425>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Okay, not tons of issues.  But at least it was worth the hassle.

Thanks.
