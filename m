From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 6/6] Documentation/git-log.txt: capitalize section
 names
Date: Mon, 15 Jul 2013 11:17:13 -0700
Message-ID: <20130715181713.GG14690@google.com>
References: <20130715173536.GB14690@google.com>
 <1373910925-18422-1-git-send-email-Matthieu.Moy@imag.fr>
 <1373910925-18422-7-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jul 15 20:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UynKt-0006xM-FA
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 20:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453Ab3GOSRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 14:17:19 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38777 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262Ab3GOSRR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 14:17:17 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so10990612pdi.13
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eATu+9mQsev41KsQiJl2PVciEjOzDfQVUhMCzZ5CxZ4=;
        b=e/CT8+cljZSlni+1nGhkGr+2Qidl31413oMO0uh6+H6XhMeutY0XZCwsmO2grpdAua
         2hIWefH4D5h+WOSju282/+WMlzvuRz7qvke4/n5kCTOoonDvbrES5mOeVPpgT1AMXgvq
         pX0NjKJfsYBrk2abFSDsK9jhRLAnhGsCMiaMcqwsvn5RjuJ0CkTonuoEdewobiqlY2Ne
         Fy/0FcECIxDiqAWLNmZD60tHvZnsCBTSMCOQmRXSQozTmDGSRPwHjGPY48mrt++TUakf
         QY0aO2xPGFS6nhFTJ+MoY1tqcXBQrApwd3PliA9B2QpJe+Y0bUFx5gFrk4Fyd5MKQZ9s
         8s5A==
X-Received: by 10.66.136.49 with SMTP id px17mr56702022pab.133.1373912236950;
        Mon, 15 Jul 2013 11:17:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id bg3sm62134977pbb.44.2013.07.15.11.17.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 11:17:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1373910925-18422-7-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230513>

Matthieu Moy wrote:

> This is the convention in other files and even at the beginning of git-log.txt

The docs aren't so consistent on this, but I agree that it makes sense
to at least be consistent within the generated git-log.html. :)

Generally the series looks very good.  Thanks for taking this on.
