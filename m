From: Junio C Hamano <gitster@pobox.com>
Subject: 1.7.0-rc2 tomorrow...
Date: Sat, 06 Feb 2010 18:29:03 -0800
Message-ID: <7vy6j5ixsg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Eric Wong <normalperson@yhbt.net>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Feb 07 03:29:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndwtl-00034t-Qk
	for gcvg-git-2@lo.gmane.org; Sun, 07 Feb 2010 03:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab0BGC3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 21:29:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0BGC3O (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 21:29:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 13CCF97D1E;
	Sat,  6 Feb 2010 21:29:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=jfc5
	k3Gmr2EQL0P1T9Y5ZhrNKzc=; b=O4rjK2BOMPu6Fv1/3AdIBhtmFIecMRdQybYg
	jpafzwq41iPjG/yY2QfClCB/Cb6cPWsyoz+ZcO0ZHUvzB2p3SCu/cPuFyCIPR1SF
	/w1Rk/GSnG/4Y8gKNl5GhVZLw3f81LXlX75Lv8kNIa9sKprN/Q2fUwQ/nBHaTy/y
	hjtCjQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	Ab474KrW+WykcMpWp3slg1R/dwQsw8tPgZrZ/l6lktMH5b9wViKNntMTlBTILaVC
	rDq+xbMfH7luLfjIidFdbXc9aqawVcEa4wneR39SVIjhJK4mK9lMSMIvDPVeNDZt
	lbO9eE4YLOBeE0R/RINa+gEnsrh8RmBxFY9XYDlDUN4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C60CA97D1C;
	Sat,  6 Feb 2010 21:29:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 024F197D1B; Sat,  6 Feb
 2010 21:29:04 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 92757E2C-1390-11DF-94F8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139213>

If you have updates meant for 1.7.0 (translations, etc.), please tell me
to pull in the next 18 hours or so.

Thanks.
