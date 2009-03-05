From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 05 Mar 2009 19:12:21 +0900
Message-ID: <20090305191221.6117@nanako3.lavabit.com>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:14:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAbB-0000aZ-02
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbZCEKNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbZCEKNN
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:13:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:40256 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbZCEKNM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:13:12 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id AD7F011B84A;
	Thu,  5 Mar 2009 04:13:10 -0600 (CST)
Received: from 9662.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id X7NMEN72B6JR; Thu, 05 Mar 2009 04:13:10 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=cymMc0yYkLFCE35mbnHNlYCYRhWJ6gc+JM3su5ry7suOf3MZl6jq177hXj/3H+sXj5ADHV+EtBBOBH9a0GlJGp3z+ZnV+r0WtX8rbDnj+makol9qOi1lUlCPWqbiCVPYEn3OlGc4bobgCF+RUqPawXuSOVX8OLXm1lI8GPOo/Qw=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112285>

Quoting Junio C Hamano <gitster@pobox.com>:

> * jk/sane-relative-time (Tue Feb 24 00:42:16 2009 -0500) 1 commit
>  + never fallback relative times to absolute
>
> I think I sent out a "here is how" patch for something related to
> --date=<format> option that may be related to this topic; I seem to have
> lost it.

Do you mean this one?

	http://article.gmane.org/gmane.comp.version-control.git/112033

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
