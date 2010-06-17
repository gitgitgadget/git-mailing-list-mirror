From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: What's cooking in git.git (Jun 2010, #02; Wed, 16)
Date: Thu, 17 Jun 2010 21:05:59 +0200
Organization: Ensimag
Message-ID: <0d059f457e2edc87093de2e0ea3c911a@ensimag.fr>
References: <7viq5ict4p.fsf@alter.siamese.dyndns.org> <7vocf939vu.fsf@alter.siamese.dyndns.org>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Andrew Sayers <andrew-git@pileofstuff.org>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	Brian Downing <bdowning@lavos.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Ian Ward Comfort <icomfort@stanford.edu>,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Philippe Bruhat (BooK)" <book@cpan.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simo Melenius <simo.melenius@iki.fi>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 21:33:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPKq5-0004AU-3r
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 21:33:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757394Ab0FQTdR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 15:33:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45486 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757338Ab0FQTdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jun 2010 15:33:16 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5HIvrWG021463
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jun 2010 20:57:53 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5HJ600w027090;
	Thu, 17 Jun 2010 21:06:00 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o5HJ5xEe029516;
	Thu, 17 Jun 2010 21:05:59 +0200
In-Reply-To: <7vocf939vu.fsf@alter.siamese.dyndns.org>
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 17 Jun 2010 20:57:55 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5HIvrWG021463
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
MailScanner-NULL-Check: 1277405877.22033@AAbcEM2U3GeGQS1ZIyxkdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149322>

>> * ab/blame-textconv (2010-06-07) 3 commits
> 
> Type punning in textconv_object() needs to be fixed.
> 
>> * cp/textconv-cat-file (2010-06-09) 4 commits
> 
> Likewise.

A fix was proposed here:
http://mid.gmane.org/1276610328-28532-1-git-send-email-axel.bonnet@ensimag.imag.fr
and here:
http://mid.gmane.org/1276617028-5265-1-git-send-email-clement.poulain@ensimag.imag.fr

Is that OK ?

Regards
