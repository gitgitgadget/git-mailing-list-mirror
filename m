From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] user-manual: use 'fast-forward' instead of 'fast
 forward'
Date: Mon, 06 Apr 2009 01:14:31 -0700
Message-ID: <7v8wme9p20.fsf@gitster.siamese.dyndns.org>
References: <1238837909-3060-1-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-2-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-3-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-4-git-send-email-felipe.contreras@gmail.com>
 <1238837909-3060-5-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 10:16:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqk0X-0006R2-UU
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbZDFIOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbZDFIOk
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:14:40 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbZDFIOj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:14:39 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 28511C213;
	Mon,  6 Apr 2009 04:14:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 93764C212; Mon, 
 6 Apr 2009 04:14:33 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F7837BAC-2282-11DE-820A-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115776>

As there isn't 3/7 and this seems to depend on it, I'm dropping this, for
now, but is this an improvement, or is it a "many places already use
fast-forward and this patch is bringing consistency to the remainder"
patch?
