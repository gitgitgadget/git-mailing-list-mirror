From: Heiko Voigt <git-list@hvoigt.net>
Subject: Re: [PATCH] cvsimport: add test illustrating a bug in cvsps
Date: Mon, 23 Feb 2009 21:35:09 +0100
Message-ID: <49A3087D.2010004@hvoigt.net>
References: <49A2EFC6.5000104@hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 21:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbhXf-00044y-FR
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 21:36:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbZBWUfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 15:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbZBWUfO
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 15:35:14 -0500
Received: from darksea.de ([83.133.111.250]:43763 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750900AbZBWUfO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 15:35:14 -0500
Received: (qmail 9880 invoked from network); 23 Feb 2009 21:34:57 +0100
Received: from unknown (HELO macbook.lan) (127.0.0.1)
  by localhost with SMTP; 23 Feb 2009 21:34:57 +0100
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
In-Reply-To: <49A2EFC6.5000104@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111173>

Heiko Voigt schrieb:
> +    echo "Rev 3
> +Rev 2
> +Rev 1" > expect &&
> +    test_cmp actual expect 

Just realized that I have overseen some whitespace issues in this patch.
I will resend a cleaned version after I got some feedback and also add
my Signed-off line.

bye Heiko 
