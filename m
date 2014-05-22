From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v8 0/2] format-patch --signature-file <file>
Date: Thu, 22 May 2014 07:23:32 -0700
Message-ID: <20140522142332.GA15095@hudson.localdomain>
References: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 16:23:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnTuH-0007ey-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 16:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbaEVOXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 10:23:38 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:48769 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbaEVOXh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 10:23:37 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so2527020pab.26
        for <git@vger.kernel.org>; Thu, 22 May 2014 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=RIOb34OgXlSupWLh4vJrWB/qEatJ04dQvSQIytpD9eA=;
        b=bEcozK+q7AmBmpgyatFykYgwiZCucuevFby6Wr95+WZPL5SrToFy+M4PGsYmCUnfmg
         m2hkbO4r+a24MELjQ7tTXt0EKhJc72xNXNGTDeGGqVQbbmgCXez+SLDf0CaMA2MZbHaj
         CwS0kGs/zw44ifFcWlUK/yYyQV40HSuZB9vBiNH9bQXM6cnch3YT7/GL6bpMf8FS0qp/
         pEH3UMLRkRufmNoX0KXY8jL/4Qte+FSGXjGp2ARGViNst3LBnHwkw7dEWARlvtWcNtXP
         43MzNrlV3kSvC93SQ7Q4+Nq76OS3mvLShXGds6H5etaJCyv7A6FXkLJd9HlnYkEDw00r
         sH4A==
X-Received: by 10.66.142.132 with SMTP id rw4mr69035634pab.6.1400768617095;
        Thu, 22 May 2014 07:23:37 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id pe3sm13354110pbc.23.2014.05.22.07.23.33
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 07:23:35 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Thu, 22 May 2014 07:23:32 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1400723589-8975-1-git-send-email-jmmahler@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249906>

Junio,

On Wed, May 21, 2014 at 06:53:07PM -0700, Jeremiah Mahler wrote:
> v8 of patch to add format-patch --signature-file <file> option.
> 
...
> 

I just notice that my patch is in 'pu'.
But it is version 7 instead of the improved version 8.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
