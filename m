From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH v4 0/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 17:53:45 -0400
Message-ID: <CALs4jVFY=E3Ejh81hxhH62F=dh31jP7_Tmx0tFmfGqAsr+_n4A@mail.gmail.com>
References: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 17 22:54:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPfU5-00060h-KA
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 22:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbaCQVyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 17:54:08 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:47618 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaCQVyH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 17:54:07 -0400
Received: by mail-wg0-f48.google.com with SMTP id l18so5236957wgh.19
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=HAmlUEeHODHktu2XGYegGThm7mpzBynxyf5Mbmhs17E=;
        b=F5DRtWwznLGTwKDvIFqwqvHMxwasMaNbzOObOVOAjM2DSGJO/4pwMQQN3cW672N/dh
         owUayzkVGvuh7t8VwWTIMniEEJ9FxxC88Ck9ajd6Yhfa/f8Qbyh53epkZkuZwaWSLlNM
         dn3+r3Yg8tGXgNu3oCZKq6ha9fxQeH8nye/InNSBZGOOScj3bm2KQG3rg1O4PKlKqMWZ
         BszXqs0FKyQdTMVnZFXjVfhAgHn1fv0C7nA4+lCyaXeVObRN1Kpo78R6qccMGd4abmQF
         XehKjCwGaEdvcfHfor/tM3nhsIYzDEZ9mhFDNYl6pkeGRJZVR4UZuK3/KFlcbMY/QmFE
         RSAg==
X-Received: by 10.180.25.46 with SMTP id z14mr11289033wif.49.1395093245557;
 Mon, 17 Mar 2014 14:54:05 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Mon, 17 Mar 2014 14:53:45 -0700 (PDT)
In-Reply-To: <1395093144-6786-1-git-send-email-quintus.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244295>

My mistake, folks. This is [PATCH v4]. Apologies for the confusion.

Quint
