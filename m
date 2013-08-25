From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/fast-import: clarify summary for `feature`
 command
Date: Sat, 24 Aug 2013 22:57:37 -0700
Message-ID: <20130825055737.GO2882@elie.Belkin>
References: <1377246560-19847-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 25 07:57:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDTKd-0007tt-7P
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 07:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab3HYF5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 01:57:43 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:58899 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755996Ab3HYF5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 01:57:42 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so2199317pde.38
        for <git@vger.kernel.org>; Sat, 24 Aug 2013 22:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vcdNJdDBBIwzrZVcZYLvCFDa/qkcn0p/zFsdG7rXCNc=;
        b=GvBnphoDU0Rpk0AhT98vxkhnuevVQbkdPbeRvZFquerpFhfiZmIRynpYqcDD3aRFVL
         oq6UUAdiuGOzuasJJGgIraaRckqSy+A80j9Pv3oi6QVR35lMKG3sJN7qqfeHFMQqq0rV
         fd2Rkb9R3fpd/u4R/jWjeOQFVZhQjEysGAt4fzNZIh9Bua/A5TZaFOzkY2zBvgPuri9y
         4H/GgC+g1CDGjbyyXEVJlkx7uGZxPu3wPTz+2yjvpN+lDuRPC1govaW/2uG6V30RJrkU
         0S4/I3Fk3gayepU4+DCtknJG9szAAd6LlYYs6ExLvzYVXRv0zEWJN5mixqjUTtTDw6WS
         ykOQ==
X-Received: by 10.67.3.103 with SMTP id bv7mr7740264pad.15.1377410262143;
        Sat, 24 Aug 2013 22:57:42 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id zq10sm11679618pab.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 24 Aug 2013 22:57:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1377246560-19847-1-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232926>

Matthieu Moy wrote:

> In most cases, "feature <foo>" does not just require that the feature
> exists, but also changes the behavior to enable it.

For what it's worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
