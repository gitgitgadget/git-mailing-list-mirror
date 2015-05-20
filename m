From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 0/3] git cat-file --follow-symlinks
Date: Wed, 20 May 2015 13:46:56 -0700
Message-ID: <xmqqh9r7m0xr.fsf@gitster.dls.corp.google.com>
References: <1432141420-1027-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 20 22:47:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvAtO-0006nO-IL
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 22:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754710AbbETUrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 16:47:01 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33686 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbbETUq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 16:46:59 -0400
Received: by iebgx4 with SMTP id gx4so48693680ieb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w+zsaZTronYuxot094uTA9ZDKcsy7l5IR4LKcFst//4=;
        b=vTY/SYAPGdhRbsjkd4KSqMNjXK8Dmgw8dIGAvRdEwJ+wL9X1WKTLc+9yE6q9qxOJtZ
         44Zzq12V1VWQUDmP/r9R97UsjixhTL/EEujQuoqQu6tYifZ5UsvHmAYXpT/XE5fUy6kk
         nGM9VxyT7yVXah1S1tXzY9ufzZKwTYO9QI3yX1TK0Pq/eyXfasrHxFUtqPKI5pAAa4+D
         wDDGWGRCELa0Oe13Dy67Qwq7bJwwU3mVkSxIwczJKCnIREpRcz9kPNxqffP5Vb05p3C0
         QCq9tcD5yjKHYX/FX8ttzJTgi5GMFFpBLc5XCnbxx2Z2ITKKFcu4mWPJDybsZCTnHGci
         wNIw==
X-Received: by 10.107.138.208 with SMTP id c77mr26392984ioj.24.1432154818604;
        Wed, 20 May 2015 13:46:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:c1e1:e830:c078:d79d])
        by mx.google.com with ESMTPSA id d4sm2422733igl.1.2015.05.20.13.46.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 13:46:57 -0700 (PDT)
In-Reply-To: <1432141420-1027-1-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Wed, 20 May 2015 13:03:37 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269519>

Thanks; will replace.
