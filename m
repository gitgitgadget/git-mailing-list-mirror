From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: write test results to
 test-results/<basename>-<pid>
Date: Fri, 13 Mar 2009 10:22:56 -0700
Message-ID: <7vbps5gwwf.fsf@gitster.siamese.dyndns.org>
References: <cover.1236961524u.git.johannes.schindelin@gmx.de>
 <3728317206182c4d4539f3d20b8441cb160e72e3.1236961524u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0903131735110.6288@intel-tinevez-2-302> <7viqmdgx0b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sverre Rabbelier <alturin@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:25:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LiB7g-0002sl-Mr
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 18:24:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758268AbZCMRXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 13:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757432AbZCMRXM
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 13:23:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33929 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbZCMRXK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 13:23:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A01C7A177C;
	Fri, 13 Mar 2009 13:23:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 61A07A1778; Fri,
 13 Mar 2009 13:22:57 -0400 (EDT)
In-Reply-To: <7viqmdgx0b.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 13 Mar 2009 10:20:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9E6134C0-0FF3-11DE-85E0-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113213>

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> ...
>> As a consequence, one's results overwrite the other one's.
>
> Are you saying that your "fix" will break things if we did not have
> renames from j6t?

Please disregard; I shouldn't be writing an e-mail when I do not have time
to re-read and think.  Sorry for the noise.
