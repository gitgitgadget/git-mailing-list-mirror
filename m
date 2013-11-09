From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] Correct word usage of "timezone" in
 "Documentation/RelNotes" directory
Date: Fri, 8 Nov 2013 17:02:38 -0800
Message-ID: <20131109010238.GH10302@google.com>
References: <1383958133-4207-1-git-send-email-jstjohn@purdue.edu>
 <1383958133-4207-3-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Sat Nov 09 02:02:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vewwn-0002LE-L1
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 02:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757937Ab3KIBCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 20:02:42 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:33767 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268Ab3KIBCl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 20:02:41 -0500
Received: by mail-pb0-f41.google.com with SMTP id wy17so2887168pbc.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/ENpjRSJIwOjflsvKbkIEykHmUnNNIrEyI+KboA54dw=;
        b=cu5lA1oznGP/k2FctVvvML3tLAmad8BTSMrwifQlrR6AShHkxK0KViZ5Q+IeMyG0tL
         lX8Qv+yDa53YrZ/R3k2PlSmf+sXlEOdx7q+hz40ilBaUvDMxFGDqfGV/vhH5DBhLd3Wf
         +kgCeW8aBuKSArNqmTg//vlW/BVTJSFLytMYPBrUGRlb5o40IarjtHlmx6uuS4Bck/LI
         hbCTno3HiGS2P3wYp0GAGDWHwOpr/1E2sCwGLs+qPelwM5qpnxWnk0lHE2znTWYG4hD9
         0B/cs1sVWB0beJFBUh+zrsk1CegT7X0atHiFm5fXU8QTzwqL0KpgDJgcaLLmxQoB6THv
         Xw9g==
X-Received: by 10.68.216.132 with SMTP id oq4mr17911622pbc.50.1383958960840;
        Fri, 08 Nov 2013 17:02:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id zq10sm17513939pab.6.2013.11.08.17.02.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 17:02:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1383958133-4207-3-git-send-email-jstjohn@purdue.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237481>

Jason St. John wrote:

> I broke this off into a separate patch in case the release notes are
> essentially "fixed" in history and typos, misspellings, etc. don't get
> corrected.

Yeah, I'd prefer not to retroactively fix release notes for cases
like this.

Thanks,
Jonathan
