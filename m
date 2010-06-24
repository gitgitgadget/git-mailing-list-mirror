From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] git-cat-file.txt: Document --textconv
Date: Thu, 24 Jun 2010 15:54:02 +0200
Message-ID: <vpqd3vgcz9h.fsf@bauges.imag.fr>
References: <4C2355EF.7030604@drmicha.warpmail.net>
	<735c21d857407c7f0cb18da13d556d3a77a358db.1277383590.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 24 15:54:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORmt9-0005sZ-I2
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 15:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab0FXNyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 09:54:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42116 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754822Ab0FXNyh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 09:54:37 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5ODjZAL019854
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 24 Jun 2010 15:45:35 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1ORmsV-0001ap-8i; Thu, 24 Jun 2010 15:54:03 +0200
In-Reply-To: <735c21d857407c7f0cb18da13d556d3a77a358db.1277383590.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu\, 24 Jun 2010 14\:56\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 24 Jun 2010 15:45:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5ODjZAL019854
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277991936.78912@T7ijmvSLI/HDU6njhkYASA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149595>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> +--textconv::
> +	Show the content as transformed by a textconv filter. In this case,
> +	<object> has be of the form <treeish>:<path>, or :<path> in order
> +	to apply the filter to the content recorded in the index at <path>.

Good, I was not totally happy with my wording, yours is definitely
better.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
