From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v2] xdiff/xprepare: improve O(n*m) performance in =?utf-8?b?eGRsX2NsZWFudXBfcmVjb3Jkcygp?=
Date: Wed, 24 Aug 2011 06:32:53 +0000 (UTC)
Message-ID: <loom.20110824T083156-530@post.gmane.org>
References: <7vd3g5i7ci.fsf@alter.siamese.dyndns.org> <1313546037-4104-1-git-send-email-rctay89@gmail.com> <loom.20110824T082807-840@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 08:35:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw73Q-0002D2-GG
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 08:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693Ab1HXGfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 02:35:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:35467 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296Ab1HXGfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 02:35:05 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qw73I-000288-EL
	for git@vger.kernel.org; Wed, 24 Aug 2011 08:35:04 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 08:35:04 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 08:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179988>

Marat Radchenko <marat <at> slonopotamus.org> writes:
> So, will this be applied to git master? Very impressive speed improvement.

Sorry, just discovered it is already in pu.
