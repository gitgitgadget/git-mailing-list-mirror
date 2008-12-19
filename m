From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Clarify git-format-patch --in-reply-to
Date: Sat, 20 Dec 2008 06:51:35 +0900
Message-ID: <20081220065135.6117@nanako3.lavabit.com>
References: <87k59wc73n.fsf@jidanni.org>
 <7vzlitho1o.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Dec 19 22:54:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDnIO-00085Q-3l
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 22:54:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750AbYLSVwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 16:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754323AbYLSVwK
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 16:52:10 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50945 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755310AbYLSVwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 16:52:09 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 683B0C7A6C;
	Fri, 19 Dec 2008 15:52:08 -0600 (CST)
Received: from 1713.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id BJKHYWYYKG1V; Fri, 19 Dec 2008 15:52:08 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=vu9qRK5vwc6GYIX9+7EKZrg1BJLGWPdwWAVYBvYcsqyn/gtC/QpzBbP9YzTwVj+iQO1AQsNfNUN6oT34hbQmQ04l8egyIy/d/x3OVsNFeda6XN4rV5vYwVlEEVhBNnWlRU/vxt/rvrwVwFws2AtKT2z1++t0Ytig1PNI7Eexb1M=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <87k59wc73n.fsf@jidanni.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103586>

Quoting jidanni@jidanni.org:

> Signed-off-by: jidanni <jidanni@jidanni.org>

I understand that "Signed-off-by" is about code ownership and thought that the official history prefers to have a real name instead of a pseudonym. Perhaps you would want to say "Dan Jacobson <jidanni@jidanni.org>" or something similar?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
