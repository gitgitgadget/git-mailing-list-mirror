From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push/pull: adjust missing upstream help text to changed interface
Date: Tue, 06 Nov 2012 23:45:24 +0900
Message-ID: <03ff9252-71dc-4c28-a542-d65d16ba6549@email.android.com>
References: <00F68AED-5D59-44F2-B0F1-E541881BC2CB@uva.nl> <bd710e422cb8ca0cec4cf52ea3c9ddb284d6c60d.1352197626.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeroen van der Ham <vdham@uva.nl>, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 15:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVkPS-0006Aj-1d
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 15:45:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab2KFOpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 09:45:33 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50170 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab2KFOpc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 09:45:32 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so383789pad.19
        for <git@vger.kernel.org>; Tue, 06 Nov 2012 06:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=apCslLWcVUjcDTH2A2Yv5rCb4EOMlzaguDMXn7O/9sg=;
        b=ZgaTfbruH/RZkjk5c1Pf2O6a9t0SQfQA9nxkHa4fJqRzJSoqgDV0021a9mj052tkk+
         g7RaAfVAKHbLmL5G5Q/I9C6RL5wTXqq46bjUFXtaPQ8vliT4Kwo89IoAd15I/qsfolIC
         ll/PYlbV5EyeSmRegVkkHIGipV63QsU4DACtCcTKF4zIVsyobKQ9v4GEVjPqcfT4UkSO
         7KGZcbQHM8JbdjWu0Y7KKNY9H11Fm+KILO9zvpiYIsziaJEekI9SjvdVxywaHrjSE/YA
         AIx1Yw1mkhZ/aPsbO9XWSSQRdXKFVwO9bzAU3kZZV98d+ZJ0M9TMRs9bmhwo//A5zTtY
         feHg==
Received: by 10.68.234.36 with SMTP id ub4mr4033302pbc.68.1352213132173;
        Tue, 06 Nov 2012 06:45:32 -0800 (PST)
Received: from android-3799f502a64a2a87 ([210.253.209.14])
        by mx.google.com with ESMTPS id se4sm12452238pbb.13.2012.11.06.06.45.29
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Nov 2012 06:45:31 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <bd710e422cb8ca0cec4cf52ea3c9ddb284d6c60d.1352197626.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209114>



Michael J Gruber <git@drmicha.warpmail.net> wrote:

>Yes, I'm in low hanging fruits mood.
>
>Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>

It is called tying loose ends, and is very important. Very much appreciated.
