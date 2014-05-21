From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 14:32:06 -0700
Message-ID: <20140521213206.GA13956@hudson.localdomain>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
 <1400634170-18266-2-git-send-email-jmmahler@gmail.com>
 <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
 <xmqqwqdeomes.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 23:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnE7T-0003px-VI
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 23:32:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbaEUVcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 17:32:12 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:63089 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbaEUVcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 17:32:12 -0400
Received: by mail-pd0-f172.google.com with SMTP id x10so1757264pdj.31
        for <git@vger.kernel.org>; Wed, 21 May 2014 14:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=kVv4lX03lTz+tGn7OvMasXQDd8Q7uMmNTQMSbYl1HR0=;
        b=Jn201F8N1iyDPByafOsc1ExHi+ZL4hEpPOtC+6eOx3KcqprkxjdUShACC8sTmQ2Rwx
         o0xcmAWYf5RFvVvWCwMxSjoJW1qr1Fvqs4ukge/P4jIZe9tYV9hw7DEvGucyW3BcOQmR
         xwbrSpHSiDvC/26U3Uz9bbPrA3qMbNEEOkICA6hAf5FlN+zJJfkNeCzNDRZHVgBplHY/
         n/EHuVl6O8SusLgRnlvZW/MGysZWZoxMOQi5E4d+/IL3tGOOn38B28y2R6tnCcGOZr6/
         lU9WwTPK4BNGXt+ylmxbpD3bVyAsgkUob3aUwPJr1SFY9oNX3hcl7nDm6PKvKWTlEsAZ
         8SLQ==
X-Received: by 10.68.78.66 with SMTP id z2mr14473087pbw.71.1400707931392;
        Wed, 21 May 2014 14:32:11 -0700 (PDT)
Received: from hudson (o247-linksys-rtr.CSUChico.EDU. [132.241.18.53])
        by mx.google.com with ESMTPSA id bq4sm9629765pbb.60.2014.05.21.14.32.07
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 May 2014 14:32:09 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Wed, 21 May 2014 14:32:06 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <xmqqwqdeomes.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249837>

On Wed, May 21, 2014 at 02:24:27PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
...
> 
> It seems you sent v7 before I had a chance to comment on this one.
> The above was merely "it would be nicer..." and I am OK as-is.  The
> comments on the rest are a bit more serious, though.
> 
> Thanks.
> 

It is not a problem.  Thanks again for all your feedback.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
