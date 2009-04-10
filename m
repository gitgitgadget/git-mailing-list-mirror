From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] documentation: Makefile accounts for SHELL_PATH setting
Date: Fri, 10 Apr 2009 09:34:30 +0900
Message-ID: <20090410093430.6117@nanako3.lavabit.com>
References: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 02:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ls4kV-0007hz-32
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 02:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757570AbZDJAfQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755231AbZDJAfP
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 20:35:15 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56628 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbZDJAfO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 20:35:14 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id B9C4311B8B6;
	Thu,  9 Apr 2009 19:35:12 -0500 (CDT)
Received: from 1828.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id FXJBWNTKLZVJ; Thu, 09 Apr 2009 19:35:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Kr913Z4gatbdkNMNza5fURiAoSPWcntsaIaJcpRkhjK0Km6JYAukqcn0yUtNtdithH0zHnOrG07lAec4BZ/YAfvzYtmVda4w1/FPXvGC79wnUjaQgaSgajFZmG9OviTCTcD/tNiRibdDPt5sTv2xbxwz6t+xiGJbFpMpc1ouB4Y=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1237728044-15651-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116223>

Quoting Ben Walton:

> Ensure that the Makefile that generates and installs the Documentation
> is aware of any SHELL_PATH setting.  Use this value if found or the
> current setting for SHELL if not.  This is an accommodation for systems
> where sh is not bash.
>
> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>

Junio, may I ask what happened to this patch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
