From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: replace SHA1 entry field on keyboard paste
Date: Sun, 15 Jun 2014 14:55:37 +1000
Message-ID: <20140615045537.GA21978@iris.ozlabs.ibm.com>
References: <5316E4F6.2080803@gmail.com>
 <1395305931-5248-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ilya Bobyr <ilya.bobyr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 06:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww2WG-0002wx-Ns
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 06:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbaFOE57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 00:57:59 -0400
Received: from ozlabs.org ([103.22.144.67]:53947 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031AbaFOE56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 00:57:58 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 917BA140094; Sun, 15 Jun 2014 14:57:55 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <1395305931-5248-1-git-send-email-ilya.bobyr@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251664>

On Thu, Mar 20, 2014 at 01:58:51AM -0700, Ilya Bobyr wrote:
> We already replace old SHA with the clipboard content for the mouse
> paste event.  It seems reasonable to do the same when pasting from
> keyboard.
> 
> Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>

Thanks, applied.

Paul.
