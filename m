From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] user-manual: fixed typo in example
Date: Sat, 26 May 2007 15:35:46 -0400
Message-ID: <20070526193546.GA10867@fieldses.org>
References: <1180206987131-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat May 26 21:35:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs23O-0004pH-0x
	for gcvg-git@gmane.org; Sat, 26 May 2007 21:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbXEZTfr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 15:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbXEZTfr
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 15:35:47 -0400
Received: from mail.fieldses.org ([66.93.2.214]:58045 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750994AbXEZTfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 15:35:47 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1Hs23G-0003yH-3M; Sat, 26 May 2007 15:35:46 -0400
Content-Disposition: inline
In-Reply-To: <1180206987131-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48486>

On Sat, May 26, 2007 at 09:16:27PM +0200, Steffen Prohaska wrote:
>  -------------------------------------------------
> -$ gitk ($ git show-ref --heads ) --not  $( git show-ref --tags )
> +$ gitk $( git show-ref --heads ) --not  $( git show-ref --tags )
>  -------------------------------------------------

Oops; thanks!--b.
