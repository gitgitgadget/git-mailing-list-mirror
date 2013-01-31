From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: [PATCH] gitremote-helpers.txt: rename from
 git-remote-helpers.txt
Date: Thu, 31 Jan 2013 22:28:10 +0000
Message-ID: <1359671290-ner-7089@calvin>
References: <7vfw1ijtz2.fsf@alter.siamese.dyndns.org>
	<fc96ae61bb64ce19e856d7a1624e2130c99afd47.1359662569.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Max Horn <max@quendi.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 23:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U12cZ-0000Qu-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 23:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab3AaW2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 17:28:17 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:47658 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326Ab3AaW2P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 17:28:15 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so1716345eek.14
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 14:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:subject:to:cc:references:in-reply-to:mime-version
         :date:message-id:content-type;
        bh=Dx9dsnQ3P0X9SqjVvzJNTUZZpQqxqN8fsmXcSIaB2X8=;
        b=hPu14IFtQF/CRu76fdR4VNZXIWTweVVLs3NUB1VKavJ7k1wL73FQIuEkbAnc7EMm3Z
         PljoLSmkK/P4UhIJ1g02+Cz5kG/ckRZtIQl4Cy6IGUEwQht4qHYGbXzjpkTuVALQe2hr
         Oa7ywRGFxKKlhXmyXrXvLtTcekISJffaH7J0Hg1p9hH0yxjvC4m/Av9JzBBQR6L+S6Tn
         w5csNR4RGx2v+jepocWo52tAk2KqDAnz170v8WeBMjkirljg7WXEjkrwSw5Rza6Wyvy3
         zAWONJRrkNARI8fz1KvIZKnfp1iG2WhXdeE1fdzyNLmWEgDIFbBWBds3xVSKYSL6mr+t
         QLig==
X-Received: by 10.14.178.196 with SMTP id f44mr32235642eem.14.1359671294095;
        Thu, 31 Jan 2013 14:28:14 -0800 (PST)
Received: from calvin.caurea.org (cust.static.46-14-151-191.swisscomdata.ch. [46.14.151.191])
        by mx.google.com with ESMTPS id h5sm9603639eem.1.2013.01.31.14.28.12
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 14:28:13 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id CAECE1A9018; Thu, 31 Jan 2013 22:28:10 +0000 (UTC)
In-Reply-To: <fc96ae61bb64ce19e856d7a1624e2130c99afd47.1359662569.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215176>

On Thu, 31 Jan 2013 20:08:14 +0000, John Keeping <john@keeping.me.uk> wrote:
> This is the patch to rename it to "gitremote-helpers.txt".
> 
>  Documentation/{git-remote-helpers.txt => gitremote-helpers.txt} | 6 +++---

It feels somewhat weird to have 'git-remote' but 'gitremote-helpers'.
