From: "Mikhail T." <mi+thun@aldan.algebra.com>
Subject: Re: How to fork a file (git cp ?)
Date: Wed, 04 May 2011 15:17:32 -0400
Message-ID: <4DC1A64C.4090508@aldan.algebra.com>
References: <4DC1934D.6070608@aldan.algebra.com> <4DC19955.7040503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 04 21:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHha0-0004bs-3u
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 21:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab1EDTRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 15:17:37 -0400
Received: from smtp03.lnh.mail.rcn.net ([207.172.157.103]:1344 "EHLO
	smtp03.lnh.mail.rcn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230Ab1EDTRf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 15:17:35 -0400
Received: from mr16.lnh.mail.rcn.net ([207.172.157.36])
  by smtp02.lnh.mail.rcn.net with ESMTP; 04 May 2011 15:17:34 -0400
Received: from smtp01.lnh.mail.rcn.net (smtp01.lnh.mail.rcn.net [207.172.4.11])
	by mr16.lnh.mail.rcn.net (MOS 4.2.3-GA)
	with ESMTP id BBF71828;
	Wed, 4 May 2011 15:17:32 -0400
Received-SPF: None identity=pra; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="mi+thun@aldan.algebra.com";
  x-conformance=sidf_compatible
Received-SPF: None identity=mailfrom; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="mi+thun@aldan.algebra.com";
  x-conformance=sidf_compatible
Received-SPF: None identity=helo; client-ip=209.6.61.133;
  receiver=smtp01.lnh.mail.rcn.net;
  envelope-from="mi+thun@aldan.algebra.com";
  x-sender="postmaster@utka.zajac";
  x-conformance=sidf_compatible
X-Auth-ID: anat
Received: from 209-6-61-133.c3-0.sbo-ubr1.sbo.ma.cable.rcn.com (HELO utka.zajac) ([209.6.61.133])
  by smtp01.lnh.mail.rcn.net with ESMTP; 04 May 2011 15:17:33 -0400
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.9.2.13) Gecko/20101229 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <4DC19955.7040503@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172764>

On 04.05.2011 14:22, Johannes Sixt wrote:
> You just cp the file and git add it. But you will not be able to follow
> a history of the file.
Thank you for the information...

So, is this something worth adding to the wishlist, or was it omitted on purpose 
(and which purpose was that, then)?

Yours,

    -mi
