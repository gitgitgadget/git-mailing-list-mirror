From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: GIT 0.99.9e
Date: Mon, 7 Nov 2005 07:47:18 -0800
Message-ID: <20051107154718.GJ3001@reactrix.com>
References: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 16:48:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ9DX-0007tJ-Q0
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 16:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVKGPr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 10:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbVKGPr2
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 10:47:28 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:49792 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S964850AbVKGPr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 10:47:27 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA7FlIf0030450;
	Mon, 7 Nov 2005 07:47:18 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA7FlIIJ030448;
	Mon, 7 Nov 2005 07:47:18 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11267>

On Sun, Nov 06, 2005 at 09:43:19PM -0800, Junio C Hamano wrote:

>  - http-push seems to still have a bug or two but that is to be
>    expected for any new code, and I am reasonably sure it can be
>    ironed out; preferably before 1.0 but it is not a
>    showstopper.

It seems like a minor point, but is this the appropriate name or should
it be dav-push?  Not that there's anything else in the works AFAIK but
it's certainly possible that something else could run over HTTP later
on.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
