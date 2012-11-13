From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 0/3] Introduce diff.submodule
Date: Tue, 13 Nov 2012 10:47:56 +0530
Message-ID: <CALkWK0ncA8R2NbPTCAJtiDgk3aRGwcAOCWLuwQLFR=cZZ+Zdxw@mail.gmail.com>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:18:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY8tN-0003Ff-06
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 06:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2KMFST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 00:18:19 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48278 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431Ab2KMFSS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 00:18:18 -0500
Received: by mail-ob0-f174.google.com with SMTP id uo13so7045254obb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 21:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=am8fwHLcsOev7vC5oLqrTUX4msNnsTA5VL46TqnOnPM=;
        b=Qy+Ycti/YXegx4z1y8bU6sSOYwtJDm4fvw+mr2haJDr6t8EE6K3fYMZOw9LuETpLU7
         9pLKPyDT6LGQmbW35P5/z9hTXymzczCOpTdAgfAj7Bv/cxDhbyfUSd/VLL7lAKogUHKf
         koHss82yxCArToX0P9dcjCXb+FkySaNB/0mh0vjGSdtLcZQ7OgCV8NElSoeOOQNVPkCb
         9z43NVKO3malpO/xvQ64jRrUMDMq9+vhAkjta9Tu8X62m+J/KfvWoDmu0Zofms3+unNF
         AFeo5C/XByXzodRPkMtJNECFUiELXapQ+kk+6jatEm1e2ZS5utEkIkkvq+olrM9fr5Jq
         QPyw==
Received: by 10.182.240.109 with SMTP id vz13mr13458675obc.81.1352783897038;
 Mon, 12 Nov 2012 21:18:17 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Mon, 12 Nov 2012 21:17:56 -0800 (PST)
In-Reply-To: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209573>

Ramkumar Ramachandra wrote:
> v1 is here: http://mid.gmane.org/1349196670-2844-1-git-send-email-artagnon@gmail.com
> v2 is here: http://mid.gmane.org/1351766630-4837-1-git-send-email-artagnon@gmail.com
>
> This version was prepared in response to Peff's review of v2.  As
> suggested, I've created a separate function which both '--submodule'
> and 'diff.submodule' use to set/ unset SUBMODULE_OPT.

Junio, can we pick this up?

Ram
