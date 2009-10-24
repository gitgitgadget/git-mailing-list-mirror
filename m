From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Use fast-forward
Date: Sat, 24 Oct 2009 22:07:09 +0900
Message-ID: <20091024220709.6117@nanako3.lavabit.com>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 24 15:07:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1gL2-00042e-M4
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 15:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753312AbZJXNHJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 09:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZJXNHH
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 09:07:07 -0400
Received: from karen.lavabit.com ([72.249.41.33]:60145 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbZJXNHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 09:07:06 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 486D011BB48;
	Sat, 24 Oct 2009 08:07:11 -0500 (CDT)
Received: from 8748.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id YO30N2651D5P; Sat, 24 Oct 2009 08:07:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=3cjCyCjf/ndxqB/vfxdt/lIMPvsXdawRhjDVbKADbVQIVYYEThqMfM9PoOHrqMQar+YvEvM3+VNi5PRPWF80AuxOTzoUs0QH/lIcIQQrw9Eyha4jgU6A84H9blA7RvHbbg94WXZKR72O7yI8OspAs5hRvhlaOIyhBFlW73JocO8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131162>

Quoting Felipe Contreras <felipe.contreras@gmail.com>

> As suggested in the mailing list, now I've replaced all instances of 'fast
> forward' with 'fast-forward'.

I had an impression that the consensus from the previous 
discussion was that there is no such consensus that this 
is an improvement, because there isn't a clear-cut rule?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
