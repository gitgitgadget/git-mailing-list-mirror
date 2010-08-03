From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Re: Re: CGIT 0.8.3.1 "chokes" on some bare repos
Date: Tue, 3 Aug 2010 19:06:45 -0400
Message-ID: <AANLkTinZUGQ+P09iX5HQBfYvwYJH8UCGFG8hJR4ko_mT@mail.gmail.com>
References: <90e6ba4fd298cee673048cf13b24@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>, Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 01:06:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgQZR-00046g-Qj
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 01:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757876Ab0HCXGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 19:06:47 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61145 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757863Ab0HCXGq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 19:06:46 -0400
Received: by qwh6 with SMTP id 6so2476038qwh.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 16:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Qme1EWu2wrbJ5s7nIEfk5UmehVCIF56Fys0fWdK0xyQ=;
        b=snNr2gRcYLeU61B4QvVi3XnizHlnwvuCTtIUZtjczpnMQl4h5V7w+x3vaCrTdaqqxx
         aErkschUNoEK2hq/MSI/u+qeELTldbWT1cu0yn/Ld1/tqCz9UWKheVUcBQe7mFJFgzKU
         oL48jM3OegNJdnBwGC5CHqT2mo2B4FurnhXuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oE3L7007N0behldWtRV8fkMJDqUsLH1MyPWRvvhi3Y/7kD13CUtCrLEtnKvnTIclG5
         8sFtzAzMGa56UyBvZus6GdbSvIiFNuxnAtX6jg6IhC2+asIu3Y6pEClf+hBDq0h27lT4
         NlKBeXpuRFUwsz30har0TgUdpbg+nLx0xUVCM=
Received: by 10.229.1.106 with SMTP id 42mr1588378qce.237.1280876805229; Tue, 
	03 Aug 2010 16:06:45 -0700 (PDT)
Received: by 10.229.48.205 with HTTP; Tue, 3 Aug 2010 16:06:45 -0700 (PDT)
In-Reply-To: <90e6ba4fd298cee673048cf13b24@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152546>

Lars,

0.8.3.3 works perfectly!

Thank you!

Eugene
