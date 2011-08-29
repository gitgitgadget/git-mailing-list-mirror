From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [PATCH] .gitattributes: Enable cpp diff parsing for .[ch] files
Date: Mon, 29 Aug 2011 15:43:16 -0700
Message-ID: <4E5C1604.2060209@panasas.com>
References: <4E56CE8F.8080501@panasas.com> <CA+55aFxNXK-AJdrHBBycM5W632qUBi4E=jangcdRoefQiHzbug@mail.gmail.com> <4E580830.4010305@panasas.com> <1314624752.2816.32.camel@twins> <4E5BFD36.2090000@panasas.com> <CA+55aFxB7mBByT9W4c0D6kELcZMZDD_j0_S2869nS4LV0mNTbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Aug 30 00:44:04 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QyAYk-0000CC-ET
	for glk-linux-kernel-3@lo.gmane.org; Tue, 30 Aug 2011 00:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab1H2Wn5 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 29 Aug 2011 18:43:57 -0400
Received: from natasha.panasas.com ([67.152.220.90]:58889 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412Ab1H2Wn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2011 18:43:56 -0400
Received: from zenyatta.panasas.com (zenyatta.int.panasas.com [172.17.28.63])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id p7TMhNl6032499;
	Mon, 29 Aug 2011 18:43:23 -0400
Received: from [172.17.132.75] (172.17.132.75) by zenyatta.int.panasas.com
 (172.17.28.63) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 18:43:18 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <CA+55aFxB7mBByT9W4c0D6kELcZMZDD_j0_S2869nS4LV0mNTbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180372>

On 08/29/2011 03:02 PM, Linus Torvalds wrote:
> 
> I'd hate to start populating the project with more stuff.
> 
>                      Linus

OK Thanks for the answer. That I can understand
Boaz
