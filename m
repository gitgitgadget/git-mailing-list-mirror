From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH resend] gitk: Adjust two equal strings which differed
 in whitespace
Date: Tue, 12 Jan 2010 22:22:14 +1100
Message-ID: <20100112112214.GE6685@brick.ozlabs.ibm.com>
References: <1263075072-25904-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 12 12:23:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUeqV-0003kZ-NO
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 12:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752089Ab0ALLXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 06:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841Ab0ALLXb
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 06:23:31 -0500
Received: from ozlabs.org ([203.10.76.45]:51366 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589Ab0ALLXa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 06:23:30 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id B88F7B7C6E; Tue, 12 Jan 2010 22:23:29 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <1263075072-25904-1-git-send-email-markus.heidelberg@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136714>

On Sat, Jan 09, 2010 at 11:11:12PM +0100, Markus Heidelberg wrote:

> There were the two strings "SHA1 ID: " and "SHA1 ID:" as description for
> the SHA1 search textbox. Change it to two equal strings, the space is
> now outside of the translated string.
> 
> Furthermore the German translation wasn't unique, but "SHA1:" resp.
> "SHA1-Hashwert:". The former was displayed after initialisation, the
> latter after changes to the textbox, for example when clearing the text.
> But it was too long to be displayed fully, so use a shorter translation.
> 
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>

Thanks, applied.

Paul.
