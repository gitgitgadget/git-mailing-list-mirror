From: Simon Ruderich <simon@ruderich.org>
Subject: Re: [PATCH] git-imap-send.txt: remove the use of sslverify=false in
 GMail example
Date: Sat, 20 Apr 2013 16:08:02 +0200
Message-ID: <20130420140802.GC29454@ruderich.org>
References: <51657E59.7030001@gmail.com>
 <7vmwt6mdjg.fsf@alter.siamese.dyndns.org>
 <20130411152617.GA14264@ruderich.org>
 <5166DCD7.2030105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Barbu Paul - Gheorghe <barbu.paul.gheorghe@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 20 16:08:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTYSi-0001zo-I3
	for gcvg-git-2@plane.gmane.org; Sat, 20 Apr 2013 16:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169Ab3DTOIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 10:08:05 -0400
Received: from zucker.schokokeks.org ([178.63.68.96]:37448 "EHLO
	zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab3DTOIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 10:08:04 -0400
Received: from localhost (pD9E968B7.dip0.t-ipconnect.de [::ffff:217.233.104.183])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by zucker.schokokeks.org with ESMTPSA; Sat, 20 Apr 2013 16:08:02 +0200
  id 0000000000000017.000000005172A142.0000077D
Content-Disposition: inline
In-Reply-To: <5166DCD7.2030105@gmail.com>
User-Agent: Mutt/1.5.21 (2013-03-19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221854>

On Thu, Apr 11, 2013 at 06:55:03PM +0300, Barbu Paul - Gheorghe wrote:
> Should I create a new patch removing them all?

Sounds like a good idea to me. And update the commit message with
Junio's suggestions.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
