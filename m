From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC PATCH v3 0/8] Remote helpers smart transport extensions
Date: Tue, 08 Dec 2009 07:25:32 +0900
Message-ID: <20091208072532.6117@nanako3.lavabit.com>
References: <1260116931-16549-1-git-send-email-ilari.liusvaara@elisanet.fi> <7v7hsz9qxj.fsf@alter.siamese.dyndns.org> <20091207210608.6117@nanako3.lavabit.com> <7vein635vn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 23:28:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHm4P-00067I-GY
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 23:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935644AbZLGW2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 17:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934624AbZLGW2N
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 17:28:13 -0500
Received: from karen.lavabit.com ([72.249.41.33]:41362 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933131AbZLGW2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 17:28:12 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 4F33611B8A9;
	Mon,  7 Dec 2009 16:28:19 -0600 (CST)
Received: from 6528.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id XZ1OVZOPDV0U; Mon, 07 Dec 2009 16:28:19 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=4YZ1k2m4/34jfcWth+aEg/Qoa8JXY/phvF5BCnscx+IE6E3b+bzjPlwa0apMic2+QO+ASnrkcsBJzHldx/okD2VFjdDZ7yFaQP+GQJdoeDC+RB7SGQL5V5QzffjUrsQY2AqpKr9BWSRd4zTBppf/7unpA/7Ul5ckeimuamRwJ5M=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vein635vn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134789>

Quoting Junio C Hamano <gitster@pobox.com>

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> Quoting Junio C Hamano <gitster@pobox.com>
>>
>>> I queued to ease the discussion in 'pu'.  I had to fix-up some conflicts
>>> while doing so.  Please sanity check the result.
>>
>> I see that you changed many "char* variable" to "char *variable", but
>> what is the reason for these changes?
>
> Nico already gave you correct and more concise version; this more verbose
> explanation is primarily for you who said a few times that you are not
> fluent in C.  Others can skip this message without missing anything.

Thanks everybody for quick answers and thank you, Junio, 
for a detailed explanation. Now I understand.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
