From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH v2 2/3] glossary: improve description of SHA-1 related
 topics
Date: Sun, 7 Apr 2013 21:14:07 +0200
Message-ID: <20130407191407.GA13708@ruderich.org>
References: <1613609657.1719438.1365347197409.JavaMail.ngmail@webmail09.arcor-online.net>
 <824604721.1719644.1365347429662.JavaMail.ngmail@webmail09.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Sun Apr 07 21:14:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOv2e-0003Fn-9h
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 21:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760631Ab3DGTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 15:14:12 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:32915 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756423Ab3DGTOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 15:14:11 -0400
Received: from localhost (p54B5FDE7.dip.t-dialin.net [::ffff:84.181.253.231])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Sun, 07 Apr 2013 21:14:10 +0200
  id 000000000000009C.000000005161C582.00004E56
Content-Disposition: inline
In-Reply-To: <824604721.1719644.1365347429662.JavaMail.ngmail@webmail09.arcor-online.net>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220362>

On Sun, Apr 07, 2013 at 05:10:29PM +0200, Thomas Ackermann wrote:
> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
> [snip]
>
>  [[def_object_name]]object name::
> -	The unique identifier of an <<def_object,object>>. The <<def_hash,hash>>
> -	of the object's contents using the Secure Hash Algorithm
> -	1 and usually represented by the 40 character hexadecimal encoding of
> -	the <<def_hash,hash>> of the object.
> +	The unique identifier of an <<def_object,object>>.  The
> +	object name is usually represented by a 40 character
> +	hexadecimal string.  Also colloquially called <<def_SHA1,SHA-1>>
                                                                        ^
Trailing . missing.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
