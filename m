From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Summary of the problems with git pull
Date: Wed, 28 May 2014 03:39:19 -0500
Message-ID: <5385a0b7c1722_61910632f8a2@nysa.notmuch>
References: <5366db742d494_18f9e4b308aa@nysa.notmuch>
 <536de90320f06_239010732fc82@nysa.notmuch>
 <CAGK7Mr4uucBN=17ph5pBjrz7yP60By1sERU9oBL+c2-gsMDmrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"W. Trevor King" <wking@tremily.us>,
	Philip Oakley <philipoakley@iee.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Richard Hansen <rhansen@bbn.com>, Andreas Krey <a.krey@gmx.de>,
	Marat Radchenko <marat@slonopotamus.org>
To: Philippe Vaucher <philippe.vaucher@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 28 10:51:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpZZX-0003va-Ag
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 10:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbaE1Iuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 04:50:50 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:46297 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbaE1Ius (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 04:50:48 -0400
Received: by mail-ob0-f180.google.com with SMTP id va2so10321474obc.25
        for <git@vger.kernel.org>; Wed, 28 May 2014 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=+gwqbXrU3+B8DgG2Lt7tMTscC91LREBS17JM0DY8UU0=;
        b=KSXgbHgFWdSxXV0LgoCcEIqHybngg55tQ0RmfY6+jRv18+z8PYNaJDCNgOu7EL7Slt
         XwYbs2bdM90uJMm7nnSBdzW17rSKi7HyN5NCmYgtuwlc6a2p8Axc1W23jwOkWlVnwZrs
         ntt/L/vi0Mc7ck7jwyz2ZBPK/LaFCZVRkukArfJ6RShwpes9UJRz9tAu732Fdtd7EM++
         ME3VKSG390GizXseOslPdPRvoIyNvJMl1CaQbJT6MzkznxRtLnv0IhKdX+lOXrQ4415N
         UqImQZm4h6tF4fJiX8rr8+NkYcUllWfI9G5ZyPmY1n5X7tmUzQCnv9KbhsUSF0KtcmNl
         SQGQ==
X-Received: by 10.60.103.78 with SMTP id fu14mr39629841oeb.21.1401267048228;
        Wed, 28 May 2014 01:50:48 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id g3sm33296202obd.18.2014.05.28.01.50.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 May 2014 01:50:47 -0700 (PDT)
In-Reply-To: <CAGK7Mr4uucBN=17ph5pBjrz7yP60By1sERU9oBL+c2-gsMDmrw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250275>

Philippe Vaucher wrote:
> Sorry if I missed a thread where it was already decided not to include
> it.
> 
> Felipe, please don't use this to start any non-constructive behavior
> (rant on who is right/wrong, "my patches are not accepted", etc).

I never sent those patches. I gave up on the Git project.

-- 
Felipe Contreras
