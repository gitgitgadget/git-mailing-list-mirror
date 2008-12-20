From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-mergetool: properly handle "git mergetool --
 filename"
Date: Sat, 20 Dec 2008 12:09:15 -0800
Message-ID: <7vocz6wqvo.fsf@gitster.siamese.dyndns.org>
References: <593cce2ad8b4d21995b24f0186e846d98306ae60.1229734788.git.davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 21:10:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE89o-0001hc-Tv
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 21:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbYLTUJV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 15:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753276AbYLTUJU
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 15:09:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbYLTUJU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 15:09:20 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id EABD41AAD9;
	Sat, 20 Dec 2008 15:09:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DFE421A7CA; Sat,
 20 Dec 2008 15:09:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 160BAB12-CED2-11DD-B7D8-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103658>

Thanks.
