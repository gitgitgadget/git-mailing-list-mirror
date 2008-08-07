From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [RFH/PATCH] asciidoc markup fixes
Date: Fri, 08 Aug 2008 01:26:33 +0200
Message-ID: <489B84A9.2090900@isy.liu.se>
References: <7v8wv8ifyi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000307060401040004030203"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 01:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRFOV-0003sq-TA
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 01:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbYHGX6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 19:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbYHGX6p
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 19:58:45 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:39629 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbYHGX6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 19:58:44 -0400
X-Greylist: delayed 1927 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Aug 2008 19:58:43 EDT
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 7A57F25A41;
	Fri,  8 Aug 2008 01:26:35 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 22154-02; Fri,  4 Jul 2008 02:08:56 +0200 (MEST)
Received: from [192.168.13.34] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id BEBE525947;
	Fri,  8 Aug 2008 01:26:34 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <7v8wv8ifyi.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91614>

This is a multi-part message in MIME format.
--------------000307060401040004030203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Junio C Hamano wrote:
> After this patch,
> 
>     git grep '`+`,' -- Documentation
> 
> should report noting.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Passes the test with ascidoc 8.2.7, xmlto 0.0.21, DocBooks-utils 0.6.14.

Tested-by: Gustaf Hendeby <hendeby@isy.liu.se>

--------------000307060401040004030203
Content-Type: text/x-vcard; charset=utf-8;
 name="hendeby.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hendeby.vcf"

begin:vcard
fn:Gustaf Hendeby
n:Hendeby;Gustaf
org;quoted-printable:Link=C3=B6pings universitet;Department of Electrical Enginering
adr;quoted-printable;quoted-printable:;;;Link=C3=B6ping;;SE-581 83=0D=0A=
	;Sweden
email;internet:hendeby@isy.liu.se
title:PhD Student
tel;work:+46 14 28 22 26
tel;cell:+46 730 64 64 89
x-mozilla-html:FALSE
url:http://www.control.isy.liu.se/~hendeby
version:2.1
end:vcard


--------------000307060401040004030203--
