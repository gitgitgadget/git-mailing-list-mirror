From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
Subject: Re: [PATCH] web--browse: support /usr/bin/cygstart on Cygwin
Date: Tue, 23 Jul 2013 17:28:33 -0500
Message-ID: <51EF0391.5070502@users.sourceforge.net>
References: <1371799472-11564-1-git-send-email-yselkowitz@users.sourceforge.net> <7vbo6zo3d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 24 00:29:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1l4k-0007Cf-6j
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 00:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934328Ab3GWW2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 18:28:41 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:64501 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934312Ab3GWW2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 18:28:38 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so4836435pad.8
        for <git@vger.kernel.org>; Tue, 23 Jul 2013 15:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=mY9CSpvuvc2wV2EtySOTp3qHnk90VhMLY7vszhk+Ufk=;
        b=pX6tay8UZ1CFpXlaohQ6/nVycxB0DzwSHFKX0Li6gglVQaehZoMMZpbvj9l1fqZZlc
         u7AGVCPmIsG311RpHBBeIkyy0lY2/ufcQ1nn6bUNoCQ8zqO5cHcR/LlrXG2agUj7LpFo
         piUbHtr51JD3G2Bv3ABu7PD7YUljfyeSvIRbnmkY978XtRxvs/II6CLt+z7Cy/lO5azJ
         80rW4T7hIZ9WUE5QmA52U1D9C2lo4zMYQQPad2Cz730k3RoobiAjr/73+cFkb3NBTmN/
         3jfGLCiCtZ55oxxSQr/GGNqB3xvv5FlusqPYNq8VvIKTy7JEhSrUL34wSyIw/4iOgW3d
         bFYQ==
X-Received: by 10.67.12.175 with SMTP id er15mr39438760pad.31.1374618517680;
        Tue, 23 Jul 2013 15:28:37 -0700 (PDT)
Received: from [192.168.0.101] (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])
        by mx.google.com with ESMTPSA id we2sm47499403pab.0.2013.07.23.15.28.35
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 23 Jul 2013 15:28:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <7vbo6zo3d1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231065>

On 2013-06-21 11:06, Junio C Hamano wrote:
>> From: Yaakov Selkowitz <yselkowitz@users.sourceforge.net>
>>
>> While both GUI and console Cygwin browsers do exist, anecdotal evidence
>> suggests most users rely on their native Windows browser.  cygstart,
>> which is a long-standing part of the base Cygwin installation, will
>> cause the page to be opened in the default Windows browser (the one
>> registered to open .html files).
>>
>> Signed-off-by: Yaakov Selkowitz <yselkowitz@users.sourceforge.net>
>
> Will queue and wait for somebody from Cygwin land to comment.

Ping?  Is there someone in particular whose input you are looking for?


Yaakov
