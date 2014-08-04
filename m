From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [ANNOUNCE] Git v2.1.0-rc1
Date: Tue, 05 Aug 2014 00:41:49 +0100
Message-ID: <53E01A3D.8070504@ramsay1.demon.co.uk>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 05 01:41:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XERt8-00046E-ND
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 01:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbaHDXly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 19:41:54 -0400
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:43502 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752354AbaHDXlx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 19:41:53 -0400
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id CAFCD400CAA;
	Tue,  5 Aug 2014 00:41:48 +0100 (BST)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 9B6D0400C7D;
	Tue,  5 Aug 2014 00:41:48 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Tue,  5 Aug 2014 00:41:48 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254794>

On 04/08/14 23:31, Junio C Hamano wrote:
> v2.1.0-rc1, the first release candidate Git for v2.1, is now

[snip]

> 
>  * The leaf function to check validity of a refname format has been
>    micro-optimized, using SSE2 instructions when available.  A few
>    breakages during its development have been caught and fixed already
>    but there might remain some more still; please test and report if
>    you find any.

This has been removed.

ATB,
Ramsay Jones
