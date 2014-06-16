From: agi <agnes.pasztor@omixon.com>
Subject: ISO 13485
Date: Mon, 16 Jun 2014 17:14:01 +0200
Message-ID: <539F09B9.3050200@omixon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 16 17:14:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwYbq-0002bL-P9
	for gcvg-git-2@plane.gmane.org; Mon, 16 Jun 2014 17:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939AbaFPPOG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2014 11:14:06 -0400
Received: from mail-we0-f173.google.com ([74.125.82.173]:46254 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520AbaFPPOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2014 11:14:04 -0400
Received: by mail-we0-f173.google.com with SMTP id t60so5896648wes.32
        for <git@vger.kernel.org>; Mon, 16 Jun 2014 08:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=AbsMmTNL3LT719ZDmHiTDA00MPxeVe9LCvXuWHUBKE8=;
        b=bCliYI6im4A8eWi/mvqPVHzXXs5u+xbGi1btf9ajS1bplYb4/BKg9MHAZvXtwZdGpE
         4KH0kA8HVj33i8gs/XYbTitLb/HjjoFBYgdN20dZGBMm5+EkaIPfqSOIHeiRqC7Q83MD
         qBbZWGyK+mv++1h3umycHhuMHCVDwVeTkbqgast1T8sBn2JFlrJUD1RTJQ8NkrpUAw4+
         CnqTJFpNQI/e1qSigsImE6Wk5luOFrb3K4GeSeS15trAu+80OfVnfXOxHxNpLqbfSXHL
         EPVLH0QXnU5OFNBztm7BAaXFpadJh2SDY9XNZ04dRc9ffGEzosTKQaVviMO/MgVeDDwQ
         bLAg==
X-Gm-Message-State: ALoCoQlDi/LgVrKO3bBGzXPjYQbZTORfas4AM0zazEzhDdHhRWKPxlPXkzfZEmvW+Yl3DZIJrSSG
X-Received: by 10.180.86.199 with SMTP id r7mr27080538wiz.20.1402931643419;
        Mon, 16 Jun 2014 08:14:03 -0700 (PDT)
Received: from [192.168.1.19] (business-178-48-22-49.business.broadband.hu. [178.48.22.49])
        by mx.google.com with ESMTPSA id w2sm32129185een.41.2014.06.16.08.14.02
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 16 Jun 2014 08:14:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251718>

Hello,

I would like to ask a question about GIT v. 1.7

Is it compatible with ISO 13485 (quality management system)? Can it be 
used for developing a medical diagnostic software?

Thank you!

Kind Regards,
Agnes Pasztor
