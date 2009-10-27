From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: git-svn: add support for merges during 'git svn fetch'
Date: Tue, 27 Oct 2009 12:40:56 +0900
Message-ID: <20091027124056.6117@nanako3.lavabit.com>
References: <1256006523-5493-1-git-send-email-sam.vilain@catalyst.net.nz>
	<20091020211637.GA32474@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>,
	Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 04:41:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2cvn-0006YJ-Ie
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 04:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652AbZJ0DlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 23:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbZJ0DlA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 23:41:00 -0400
Received: from karen.lavabit.com ([72.249.41.33]:58134 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427AbZJ0Dk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 23:40:59 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 9A30B11B7E7;
	Mon, 26 Oct 2009 22:41:00 -0500 (CDT)
Received: from 6540.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id AHC4T4UY1ZED; Mon, 26 Oct 2009 22:41:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=xzQ88pc3gQupg8Hf3Q2BC3wK0qffO/01QUXEaN8AewXlOBxggWtw7rM1n/A+QxcqC7L9UxE8IBindQXfMm8KpvTm7hNDpoF3PE0OAN4AMGE1Len31Sa7JD0Mqig6tayvf952ElcKYIvpFRTKKdTUpjA5l008BXf/q79j6Qgmno8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091020211637.GA32474@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131306>

Quoting Eric Wong <normalperson@yhbt.net>

> Sam Vilain <sam.vilain@catalyst.net.nz> wrote:
>> This series adds support for converting SVN merges - in the two
>> popular formats, SVK and SVN 1.5+, into git parents.
>
> Thanks Sam,
>
> There's a couple of whitespace issues with lines being too long (using 8
> character wide tabs).  Otherwise I'm happy to Ack and get them out for
> more testing/exposure; especially since I'm unlikely to exercise the
> functionality myself[1] and doesn't appear to break anything.
>
> Thanks again.

What is the status of this series and what should happen now?

Will Eric add his Ack and send you a pull request, or will you fix 
them up, forge Eric's Ack and start cooking in your 'next' branch?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
