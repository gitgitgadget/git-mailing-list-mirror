From: Robert Pollak <robert.pollak@jku.at>
Subject: Re: dependable submodules
Date: Mon, 21 Mar 2011 17:18:56 +0100
Message-ID: <4D877A70.8070907@jku.at>
References: <AANLkTi=JVO+KhnLKR-PvNQQFaZLhUmiVbKFxuytYEpmc@mail.gmail.com>	<7vd3lmv2k1.fsf@alter.siamese.dyndns.org> <AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, apenwarr@gmail.com
To: Daniel <daniel@netwalk.org>
X-From: git-owner@vger.kernel.org Mon Mar 21 17:27:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1hwq-0007B4-PC
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 17:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab1CUQ0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 12:26:55 -0400
Received: from email.edvz.uni-linz.ac.at ([140.78.3.58]:64129 "EHLO
	email.uni-linz.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689Ab1CUQ0x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 12:26:53 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2011 12:26:53 EDT
Received: from [192.168.168.60] (unknown [140.78.223.2])
	by email.uni-linz.ac.at (Postfix) with ESMTP id C0F29B849;
	Mon, 21 Mar 2011 17:18:56 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTin8Mr5xLtLqHSVuEOzzfmqnR2LU5vDdVfPprNXn@mail.gmail.com>
X-Enigmail-Version: 1.1.1
OpenPGP: id=ADDE9E08;
	url=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169609>

 On 2011-03-20 Daniel wrote:
[...]
> So would it be correct to say that even though those files are
> remotely fetched on a clone of the repository, they are actually
> revisioned and stored in the super project?

You might want to try Avery Pennarun's git-subtree, which seems to
provide this functionality.
It's at https://github.com/apenwarr/git-subtree.
