From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] Add push --set-upstream
Date: Sat, 16 Jan 2010 09:03:21 +0900
Message-ID: <20100116090321.6117@nanako3.lavabit.com>
References: <1263595630-18962-1-git-send-email-ilari.liusvaara@elisanet.fi> <7vzl4frl7i.fsf@alter.siamese.dyndns.org> <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 01:03:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVw8X-0004By-Af
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 01:03:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146Ab0APADZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758361Ab0APADZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 19:03:25 -0500
Received: from karen.lavabit.com ([72.249.41.33]:51464 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757742Ab0APADZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 19:03:25 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id CCBD211B786;
	Fri, 15 Jan 2010 18:03:24 -0600 (CST)
Received: from 4336.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id V24D7XFQ6LBD; Fri, 15 Jan 2010 18:03:24 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Lyt5q+EVpEEzOb2V3rhiSuQ6q4155b6JN8GIjwzgQXhhufiNEvj4eYQmN84WRjxRWeRcgbEZ89AuIlTIV3Mj9jbRBmvXRFUIJl6NP7aH2RqWLt3gOj6Toqhxx/iqiK4S/EsLzp44AZRc3DvvwPMi140x/q8pX+9/JyjezqhzHJE=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <7vfx66sz5p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137167>

Quoting Junio C Hamano <gitster@pobox.com>

> Junio C Hamano <gitster@pobox.com> writes:
>
>>         # Ok let's do it for real.
>>         git push    --track there this
>
> Ugh; s/--track/--set-upstream/, of course.

How can I use this to say I want to use 'pull --rebase'?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
