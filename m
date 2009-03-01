From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add init-serve, the remote side of "git init
 --remote=host:path"
Date: Sat, 28 Feb 2009 16:04:19 -0800
Message-ID: <7vbpsmds70.fsf@gitster.siamese.dyndns.org>
References: <7vsklye05k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 01:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdZBs-000803-Nf
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 01:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755074AbZCAAE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 19:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755075AbZCAAEZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 19:04:25 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062AbZCAAEY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Feb 2009 19:04:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 09AD79D257;
	Sat, 28 Feb 2009 19:04:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 58C1F9D256; Sat,
 28 Feb 2009 19:04:21 -0500 (EST)
In-Reply-To: <7vsklye05k.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 28 Feb 2009 13:12:23 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8508F6E2-05F4-11DE-B1A3-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111801>

I've cleaned up the series somewhat and now it is two independent clean-up
followed by the updated version of these two patches.
