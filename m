From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Google Summer of Code 2008
Date: Sun, 02 Mar 2008 17:05:57 +0100
Message-ID: <vpqlk516rh6.fsf@bauges.imag.fr>
References: <200802262356.28971.jnareb@gmail.com>
	<alpine.LSU.1.00.0802281021070.22527@racer.site>
	<200802291304.16026.jnareb@gmail.com>
	<200803020053.09815.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 17:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVqji-00028Z-GS
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 17:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbYCBQHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 11:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbYCBQHt
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 11:07:49 -0500
Received: from imag.imag.fr ([129.88.30.1]:44736 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbYCBQHs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 11:07:48 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id m22G5wpc020444
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 2 Mar 2008 17:05:58 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1JVqhJ-0007hL-Km; Sun, 02 Mar 2008 17:05:57 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1JVqhJ-0005Vq-HT; Sun, 02 Mar 2008 17:05:57 +0100
In-Reply-To: <200803020053.09815.jnareb@gmail.com> (Jakub Narebski's message of "Sun\, 2 Mar 2008 00\:53\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 02 Mar 2008 17:06:00 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75800>

Jakub Narebski <jnareb@gmail.com> writes:

> On Fri, 29 Feb 2008, Jakub Narebski wrote:
>
>> I'd send other ideas (including new ones, like translating
>> svn:externals into git submodules in git-svn; or making git mode
>> for Emacs have all features of tig, git-gui and gitk; or improving
>> shallow clone support) in a later post.
>
> And here they are.
>
> * GNU Emacs git GUI
>
>   Make git mode for Emacs full featured git GUI, and not only commit
>   tool, following ideas of PCL-CVS... and its limitation. I guess that
>   DVC (http://download.gna.org/dvc) git mode is one thing to examine
>   searching for features to implement, but from what I have read in
>   documentation it is quite a but GNU Arch centric.

The documentation is, but the tool isn't. Actually, DVC started as
"Xtla", which was _only_ a GNU Arch interface. The tool evolved a lot
since then, but the documentation is totally outdated :-(.

-- 
Matthieu
