From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v9 0/7] refs backend preamble
Date: Tue, 21 Jul 2015 17:05:21 -0400
Organization: Twitter
Message-ID: <1437512721.30911.22.camel@twopensource.com>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>
	 <55AEA998.60501@alum.mit.edu> <1437511404.30911.21.camel@twopensource.com>
	 <xmqqpp3ltew2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 23:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHejc-0001s7-1x
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933542AbbGUVFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:05:23 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36476 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933511AbbGUVFV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:05:21 -0400
Received: by qkdv3 with SMTP id v3so141589242qkd.3
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=kNhkx9YUBRMA1JBE0QIEDkuR3WYXUYt6Jpctt1ptZh0=;
        b=SrREBC79Us8fJ7cj9xW42fnGoD3rUoEfZWUlrflFvSJi7CYorN22oquqm9uC2V1SmX
         tPg3szuKGEeh22d9+utv47o5961b8WspbRkF4w9pIcZGd6faxyUO6SqHRwzCfbAaDjOk
         NzlBCNi9uPxYq8ICkT0ur1JIS1GeHtoTBqcppwC5Qxtf0YHfkqVWiJz8KZa91byuKNVf
         THZnXLUgfLnS3BKi74YYJbsio7K7empWhRmcB5Cd4erD11jSIX6OK/F5WTO+BFVqmbhx
         LrGu7WcWiDGT/2/MiZcI34DW3x1H0IF/r/RrP2io1iK+VsJsGBIQb5MjPav1KLHTGGcW
         CMcw==
X-Gm-Message-State: ALoCoQm8Bf82ofibtf5Ych77x1wS1B1Q0fwxIGx+C6TJD9gvVJOUWGNMNvEWtpAID8KhJFFATY/5
X-Received: by 10.55.17.100 with SMTP id b97mr40198664qkh.94.1437512720403;
        Tue, 21 Jul 2015 14:05:20 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f82sm3535876qkf.7.2015.07.21.14.05.19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2015 14:05:19 -0700 (PDT)
In-Reply-To: <xmqqpp3ltew2.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274424>

On Tue, 2015-07-21 at 13:49 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > Junio, now that Michael has marked this as reviewed, do you want to pull
> > from github, or do you want me to send a re-roll to the mailing list?
> 
> Let's see the final round; that would give me a chance to properly
> sign-off your patch, and also give others a chance to eyeball them
> for one last time.
> 
> Thanks.

Sent, thanks.
