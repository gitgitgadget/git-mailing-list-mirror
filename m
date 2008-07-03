From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/15] manpages: fix bogus whitespace
Date: Thu, 03 Jul 2008 16:55:12 -0700
Message-ID: <7vprpuwmjj.fsf@gitster.siamese.dyndns.org>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org>
 <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
 <Pine.GSO.4.62.0807022354520.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Fri Jul 04 01:56:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEYf0-00035a-3N
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 01:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbYGCXzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 19:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbYGCXzZ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 19:55:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49086 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbYGCXzY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 19:55:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D938412DEF;
	Thu,  3 Jul 2008 19:55:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0E72E12DEE; Thu,  3 Jul 2008 19:55:13 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7F5F201E-495B-11DD-9C7C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87340>

Jonathan Nieder <jrnieder@uchicago.edu> writes:

> It's distracting.
>
> Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
> ---
>  Documentation/git-fast-import.txt  |    2 +-
>  Documentation/git-format-patch.txt |    8 ++++----
>  Documentation/git-gui.txt          |    4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 70cc8e8..9602764 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -86,7 +86,7 @@ OPTIONS
>  
>  --quiet::
>  	Disable all non-fatal output, making fast-import silent when it
> -	is successful.	This option disables the output shown by
> +	is successful.  This option disables the output shown by

How did you find *this* one?  It took me a few minutes to finally notice
that you are talking about the HT.  In other words, I had to work hard to
get distracted by it.
