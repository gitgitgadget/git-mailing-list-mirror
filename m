From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] Fix AsciiDoc errors in merge documentation
Date: Fri, 05 Sep 2008 00:26:14 +0200
Message-ID: <48C06086.7080405@isy.liu.se>
References: <48BFBBEF.6010403@isy.liu.se> <200809042348.48570.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000101080209030406080401"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Sep 05 00:27:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbNIS-0006PZ-F0
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 00:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754675AbYIDW0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 18:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754692AbYIDW0S
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 18:26:18 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:60760 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754666AbYIDW0S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 18:26:18 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id D7FA825A51;
	Fri,  5 Sep 2008 00:26:16 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 21868-10; Fri,  4 Jul 2008 02:08:56 +0200 (MEST)
Received: from [192.168.13.34] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 14F2A25A50;
	Fri,  5 Sep 2008 00:26:16 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <200809042348.48570.johan@herland.net>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94967>

This is a multi-part message in MIME format.
--------------000101080209030406080401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Johan Herland wrote:
> On Thursday 04 September 2008, Gustaf Hendeby wrote:
>> Trying to compile the documentation from next has failed for me for a
>> while and now I got to the point where I tracked down the offending
>> commit: 70a3f89733a (git-merge documentation: describe how conflict is
>> presented).
> 
> This fixes the problem for me.

Nice, solves my problems too. Thanks!

Tested-by: Gustaf Hendeby <hendeby@isy.liu.se>

/Gustaf

--------------000101080209030406080401
Content-Type: text/x-vcard; charset=utf-8;
 name="hendeby.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hendeby.vcf"

begin:vcard
fn:Gustaf Hendeby
n:Hendeby;Gustaf
org;quoted-printable:Link=C3=B6pings universitet;Department of Electrical Enginering
adr;quoted-printable:;;;Link=C3=B6ping;;SE-581 83;Sweden
email;internet:hendeby@isy.liu.se
title:Research Associate
tel;work:+46 14 28 22 26
tel;cell:+46 730 64 64 89
x-mozilla-html:FALSE
url:http://www.control.isy.liu.se/~hendeby
version:2.1
end:vcard


--------------000101080209030406080401--
