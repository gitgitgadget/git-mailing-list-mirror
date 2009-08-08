From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/9] update 'git-show' bash completion to match the man
 page
Date: Sat, 08 Aug 2009 12:49:54 -0700
Message-ID: <7vfxc2dr19.fsf@alter.siamese.dyndns.org>
References: <9f50533b0908080156j33db6f99u18de79537677451b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Emmanuel Trillaud <etrillaud@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 08 21:50:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZrvn-0000N6-QS
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 21:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbZHHTuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 15:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753102AbZHHTuK
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 15:50:10 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099AbZHHTuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 15:50:09 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 49CE137F0;
	Sat,  8 Aug 2009 15:50:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7022837EE; Sat,  8 Aug
 2009 15:50:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE3A30B0-8454-11DE-AC53-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125301>

Emmanuel Trillaud <etrillaud@gmail.com> writes:

> Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>

What did you add?

> -		__gitcomp "--pretty= --format= --abbrev-commit --oneline
> +		__gitcomp "--pretty= --format= --abbrev-commit --oneline --encoding

Is it not "--encoding="?  If not, why not?
