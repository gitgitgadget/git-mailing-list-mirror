From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] Documentation/Makefile: fix spaces around assignments
Date: Tue, 12 Feb 2013 13:00:29 -0800
Message-ID: <20130212210029.GD12240@google.com>
References: <cover.1360700102.git.john@keeping.me.uk>
 <48645e424b932536e8cd877962a29b9cfa8bdebd.1360700102.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:01:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5MyR-00067U-IV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755688Ab3BLVAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:00:37 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:49120 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab3BLVAe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:00:34 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so306420pad.24
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 13:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=KZ/BFq2OQT6g1ayO6yc5JHtc+YhwKory4zAQSR1RzBk=;
        b=UOkuBylmZYlRM0/gZMScjWBXsdk6JTMPMW8ysqil3bSq+cjzbPR2NLZCiRH0PTt5IB
         d2N+dRWW7nj5EpgC7LNCjTPJRrIA34fBGrVLlvy/5P4pFXjX6pEDFLhsahzRIh80bgtl
         aoDVXgBv6MyIFkboiwFuv3fXYFA1Vq3U75+lAVinuW3Wu8V7yv5jnRy/5gK32AUDRcIF
         FI29m0n2EaXTz8zPRJX4W9EmisByM8k/6S6/jVfEaZ1iu7TfywpkITGaPMnKqzaNiYri
         Eb/S6bf3cvSAvR3++O31NDbjq7VSDO/qQPCYXhrpn3oKKmIqms97EQjWqitrZ+fPcTNh
         Xn6w==
X-Received: by 10.66.222.35 with SMTP id qj3mr36249585pac.69.1360702833708;
        Tue, 12 Feb 2013 13:00:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id y9sm77700421paw.1.2013.02.12.13.00.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 13:00:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <48645e424b932536e8cd877962a29b9cfa8bdebd.1360700102.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216197>

Hi,

John Keeping wrote:

> [Subject: [PATCH 1/3] Documentation/Makefile: fix spaces around assignments]

It's not so much "fix spaces" as "use consistent spacing", no?

Aside from that nit, looks like a sensible no-op to me, so
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
