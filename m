From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix export_marks() error handling.
Date: Fri, 24 Jul 2009 09:35:44 -0700
Message-ID: <7vskgmkpi7.fsf@alter.siamese.dyndns.org>
References: <7v7hxyyfcg.fsf@alter.siamese.dyndns.org>
 <1248423433-25407-1-git-send-email-matthias.andree@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 24 18:36:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUNlL-0001qV-PJ
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 18:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365AbZGXQfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 12:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbZGXQfw
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 12:35:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36441 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZGXQfw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 12:35:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 266CA12800;
	Fri, 24 Jul 2009 12:35:52 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8D195127FE; Fri,
 24 Jul 2009 12:35:48 -0400 (EDT)
In-Reply-To: <1248423433-25407-1-git-send-email-matthias.andree@gmx.de>
 (Matthias Andree's message of "Fri\, 24 Jul 2009 10\:17\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D3CF57A-7870-11DE-8461-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123928>

Thanks, will apply.
