From: =?UTF-8?Q?Cl=C3=A9ment_Poulain?= <clement.poulain@ensimag.imag.fr>
Subject: Re: [PATCH v3 0/4] git-gui blame: use textconv
Date: Mon, 14 Jun 2010 19:18:36 +0200
Organization: Ensimag
Message-ID: <c80899f148cbfc9446554c6c706fdbfb@ensimag.fr>
References: <1276102929-31712-1-git-send-email-clement.poulain@ensimag.imag.fr>
Reply-To: clement.poulain@ensimag.imag.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <gitster@pobox.com>, <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 19:19:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OODJs-00041Q-O9
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 19:19:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756434Ab0FNRT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jun 2010 13:19:26 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39661 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab0FNRT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 13:19:26 -0400
Received: from ensikerberos.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o5EHAaxf018303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jun 2010 19:10:36 +0200
Received: from ensicom.imag.fr (web-ensimag [195.221.228.24])
	by ensikerberos.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id o5EHIb5K014546;
	Mon, 14 Jun 2010 19:18:37 +0200
Received: from webmail.ensimag.fr (localhost [127.0.0.1])
	by ensicom.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id o5EHIakj027394;
	Mon, 14 Jun 2010 19:18:36 +0200
In-Reply-To: <1276102929-31712-1-git-send-email-clement.poulain@ensimag.imag.fr>
X-Sender: clement.poulain@ensimag.imag.fr
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 14 Jun 2010 19:10:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5EHAaxf018303
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: clement.poulain@ensimag.imag.fr
MailScanner-NULL-Check: 1277140236.8896@tKkX4MLjhT+NqmN6LgAxLA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149130>

Hi,

I've seen this series is now on pu. I have 2 questions concerning the
fourth patch (ca23df5e, Cl=C3=A9ment Poulain, 2010-06-09 19:02:08) tagg=
ed with
[DONTMERGE] and annotated with [jc: shouldn't merge this to 'next' or
higher but take it via Shawn].

=46irst, is the tag only for this patch, or for the whole series?=20
Then, do we have something more to do?

Regards
