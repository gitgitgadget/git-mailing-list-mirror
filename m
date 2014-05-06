From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (May 2014, #01; Tue, 6)
Date: Tue, 06 May 2014 18:50:29 -0500
Message-ID: <536975458b570_110415b330c55@nysa.notmuch>
References: <xmqqlhuecz1b.fsf@gitster.dls.corp.google.com>
 <53696d8aa12d2_747f15213089@nysa.notmuch>
 <xmqqha52cvuf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 02:01:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhpIX-0002z1-00
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 02:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbaEGABR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 20:01:17 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:53709 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbaEGABQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 20:01:16 -0400
Received: by mail-ob0-f182.google.com with SMTP id wn1so277621obc.13
        for <git@vger.kernel.org>; Tue, 06 May 2014 17:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=f4yxZG5HvIidRYI8y7l2uBlQN6k7Uuj4foPzIh0VfvY=;
        b=SkL2X0EWhffhqoIernZ4Oi2WiYKh0sDPdfUVws354TYJOVu1WVUWaC7Y2HmOEMEGvQ
         oXjyKVbKBVxKu5cLZfJ2rfQm8Zjon0BVp25sgcjK5YqzVQr0k4piMCHep5V+YRTCPL1e
         oU14mGIcsubEgepu01J/8r67vkNz84w+LpydNMq1cc6GlZc12bJnbA8Tciy5s7ut4rrN
         mqRwzfpM1AwQ5WvzhJS4VV3WeO6wQ3mJFc7QHsFePk1/pG1p7cy6iTauZtuXgiAoPVVs
         4D9BxRPUTrSaW7Af8ODAs67butycGuT1WtjYDyIJQv6JsLMADKNDqE1yKTQWxUTgrE+n
         sxOA==
X-Received: by 10.182.112.231 with SMTP id it7mr40634439obb.8.1399420875346;
        Tue, 06 May 2014 17:01:15 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id oz15sm58537646oeb.13.2014.05.06.17.01.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 May 2014 17:01:14 -0700 (PDT)
In-Reply-To: <xmqqha52cvuf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248271>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Plus this one which has been completely ignored:
> >
> >    completion: move out of contrib
> 
> It is not about "ignored".  It is about running out of time before
> concluding the day's integration.

A comment doesn't require integration.

Either way the rest of the patches have already "advanced".

-- 
Felipe Contreras
