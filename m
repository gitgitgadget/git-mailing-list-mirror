From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/5] pack-check.c: minor formatting fix to match coding style
Date: Sun, 01 Feb 2009 06:45:28 +0900
Message-ID: <20090201064528.6117@nanako3.lavabit.com>
References: <1233313517-24208-1-git-send-email-gitster@pobox.com>
 <1233313517-24208-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:47:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNgf-0008PE-Rp
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZAaVqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:46:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752457AbZAaVqN
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:46:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44926 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362AbZAaVqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:46:11 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id C3FC7C888C;
	Sat, 31 Jan 2009 15:46:09 -0600 (CST)
Received: from 9691.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id RJNYO9MSKCIZ; Sat, 31 Jan 2009 15:46:09 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Ei+1bIvOaAt5Brq0Twizefx3E6dcphtH1C4n7Bm7eVJyVjkTvZLnvLbC/0KY/CZlsaHVgmoWRnFLiTSfYTu0l4fcQUTejD0Bz0gVI7KlA7/gLAYX02SdsLwX9WCVICH1etYAqlC0uO3iiwgguMQBGbsxBZHd7oX1zNWXSsMJq44=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1233313517-24208-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107942>

Quoting Junio C Hamano <gitster@pobox.com>:

> Adjust misaligned columns and multi-line comments that violate our coding
> style before touching this file.
>
> Also fix an obvious typo.

What typo did you fix?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
