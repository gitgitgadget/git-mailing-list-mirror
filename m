From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 1/3] Documentation: fix typos / spelling mistakes
Date: Fri, 17 Apr 2009 20:56:56 +0200
Message-ID: <49E8D0F8.2040104@drmicha.warpmail.net>
References: <1239992010-16698-1-git-send-email-mike@abacus.co.uk> <1239992010-16698-2-git-send-email-mike@abacus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Mike Ralphson <mike.ralphson@gmail.com>
To: Mike Ralphson <mike@abacus.co.uk>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:58:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LutGu-0006sW-UY
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 20:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759062AbZDQS5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 14:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758772AbZDQS5H
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 14:57:07 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49962 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757826AbZDQS5G (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 14:57:06 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 658FE31EE50;
	Fri, 17 Apr 2009 14:57:03 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Apr 2009 14:57:03 -0400
X-Sasl-enc: XpQqNXsYhBZp+F3cz41idM+PkPkuqFEx3hjFsx9rPMuX 1239994622
Received: from localhost.localdomain (p5DCC190E.dip0.t-ipconnect.de [93.204.25.14])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 44D18250D6;
	Fri, 17 Apr 2009 14:57:02 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090414 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <1239992010-16698-2-git-send-email-mike@abacus.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116778>

Mike Ralphson venit, vidit, dixit 17.04.2009 20:13:
> Signed-off-by: Mike Ralphson <mike@abacus.co.uk>
> ---
>  Documentation/git-cvsimport.txt         |    2 +-
>  Documentation/git-format-patch.txt      |    2 +-
>  contrib/thunderbird-patch-inline/README |    4 ++--
>  gitweb/README                           |    2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
> index d7bab13..614e769 100644
> --- a/Documentation/git-cvsimport.txt
> +++ b/Documentation/git-cvsimport.txt
> @@ -196,7 +196,7 @@ Problems related to tags:
>  
>  If you suspect that any of these issues may apply to the repository you
>  want to import consider using these alternative tools which proved to be
> -more stable in practise:
> +more stable in practice:
>  
>  * cvs2git (part of cvs2svn), `http://cvs2svn.tigris.org`
>  * parsecvs, `http://cgit.freedesktop.org/~keithp/parsecvs`
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index eb2fbcf..5eddca9 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -194,7 +194,7 @@ CONFIGURATION
>  -------------
>  You can specify extra mail header lines to be added to each message
>  in the repository configuration, new defaults for the subject prefix
> -and file suffix, control attachements, and number patches when outputting
> +and file suffix, control attachments, and number patches when outputting
>  more than one.
>  
>  ------------
> diff --git a/contrib/thunderbird-patch-inline/README b/contrib/thunderbird-patch-inline/README
> index 39f96aa..000147b 100644
> --- a/contrib/thunderbird-patch-inline/README
> +++ b/contrib/thunderbird-patch-inline/README
> @@ -1,12 +1,12 @@
>  appp.sh is a script that is supposed to be used together with ExternalEditor
> -for Mozilla Thundebird. It will let you include patches inline in e-mails
> +for Mozilla Thunderbird. It will let you include patches inline in e-mails
>  in an easy way.
>  
>  Usage:
>  - Generate the patch with git format-patch.
>  - Start writing a new e-mail in Thunderbird.
>  - Press the external editor button (or Ctrl-E) to run appp.sh
> -- Select the previosly generated patch file.
> +- Select the previously generated patch file.
>  - Finish editing the e-mail.
>  
>  Any text that is entered into the message editor before appp.sh is called
> diff --git a/gitweb/README b/gitweb/README
> index 8433dd1..ad73c6a 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -206,7 +206,7 @@ not include variables usually directly set during build):
>   * $fallback_encoding
>     Gitweb assumes this charset if line contains non-UTF-8 characters.
>     Fallback decoding is used without error checking, so it can be even
> -   'utf-8'. Value mist be valid encodig; see Encoding::Supported(3pm) man
> +   'utf-8'. Value mist be valid encoding; see Encoding::Supported(3pm) man

That line clearly demonstrates the limits of word based spell
checkers... s/mist/must/ ;)

>     page for a list.   By default 'latin1', aka. 'iso-8859-1'.
>   * @diff_opts
>     Rename detection options for git-diff and git-diff-tree. By default
