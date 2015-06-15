From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] am: improve test coverage and touch up foreign patch parsing
Date: Mon, 15 Jun 2015 12:38:51 -0700
Message-ID: <xmqq7fr492yc.fsf@gitster.dls.corp.google.com>
References: <1434366493-27155-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 21:39:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aDi-0002qD-IU
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:38:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985AbbFOTiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 15:38:54 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:36210 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbbFOTix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:38:53 -0400
Received: by igbiq7 with SMTP id iq7so26543300igb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=CXnNS6ZRobUCzWANBH/oE66abSQaoBfrh4scyQyLUEY=;
        b=N5puwdtM/jA5mk7Zf/oiO+cs7gkqBk9PLcNWhDErcjq5Amb5HfLnVZ64BNhPFllneS
         9J41wXavKF1MA3mp8lnIi/MpvkOeLZfK5qP35BKjm1oLszZrLTVpLE0OFTBaPXEu5P/e
         z9+4WFkuH6oiD+++idIlUjTi3VymxxymrU2oaTtIB+0n4wpWdPr72FvU0UfB/yOsKEsr
         mYJjIjndYGOYf/YhZq4nhBkr9LhKjvEqqBwwY8esXz99CO5/bvJ0hgKft9s+znJzO0z6
         x7WBgskk4Sx0ZWiLtXH4Ycbf4ihcq2GSPrjmL2LPIAePi2oh5f9a9bKfbu+CLCV+lm2c
         Koag==
X-Received: by 10.50.79.228 with SMTP id m4mr22780065igx.6.1434397132815;
        Mon, 15 Jun 2015 12:38:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id j5sm9487351ioo.8.2015.06.15.12.38.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 12:38:52 -0700 (PDT)
In-Reply-To: <1434366493-27155-1-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Mon, 15 Jun 2015 19:08:08 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271710>

This round looks good to me.

Thanks all.
