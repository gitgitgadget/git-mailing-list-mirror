From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [BUG] - "git commit --amend" commits, when exiting the editor
 with no changes written
Date: Wed, 3 Feb 2010 01:15:35 -0500
Message-ID: <20100203061535.GA6566@cthulhu>
References: <8c9a061002021214j673afbc8vfa5d941fba518648@mail.gmail.com>
 <32541b131002021227o1ec9f369w6096e85382857b8a@mail.gmail.com>
 <76c5b8581002021247j6df8f609ld9e5d87a060a5423@mail.gmail.com>
 <394FB581-C9B9-40AB-AFB6-39B68ED5BEAD@wincent.com>
 <76c5b8581002021356m52bb1817k9a4a29da0d4b681d@mail.gmail.com>
 <77153A83-158D-4D36-A622-7AA3947C7D52@wincent.com>
 <76c5b8581002021431o2b5073a0s42b273b6d61893db@mail.gmail.com>
 <32541b131002021435kadb68ffge77ad5f4e1775418@mail.gmail.com>
 <76c5b8581002021502i2bb34967y9a88d8b25ce7fa42@mail.gmail.com>
 <32541b131002021540g7a2834c9hacf2be5962f66515@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 07:15:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcYWc-00062L-E3
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 07:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647Ab0BCGPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 01:15:37 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:57637 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0BCGPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 01:15:37 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id C15BD82200B; Wed,  3 Feb 2010 01:15:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <32541b131002021540g7a2834c9hacf2be5962f66515@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138808>

* Avery Pennarun (apenwarr@gmail.com) [100202 18:41]:
> You can however add *new* stuff.  That's why I suggested adding an
> option.  You could even make it a config option so you only have to
> set it once (just like setting your preferred editor).

Or, he can set his $EDITOR to a script that checks the mtime.

    --larry
